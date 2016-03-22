// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "services/media/framework_mojo/mojo_producer.h"

namespace mojo {
namespace media {

MojoProducer::MojoProducer() {
  task_runner_ = base::MessageLoop::current()->task_runner();
  DCHECK(task_runner_);
}

MojoProducer::~MojoProducer() {
  base::AutoLock lock(lock_);
}

void MojoProducer::AddBinding(InterfaceRequest<MediaProducer> producer) {
  bindings_.AddBinding(this, producer.Pass());
}

void MojoProducer::PrimeConnection(const FlushConnectionCallback& callback) {
  Demand demand;

  {
    base::AutoLock lock(lock_);
    max_pushes_outstanding_ = 10; // TODO(dalesat): Made up!
    demand = current_pushes_outstanding_ < max_pushes_outstanding_ ?
        Demand::kPositive :
        Demand::kNegative;
  }

  DCHECK(demand_callback_);
  demand_callback_(demand);
  SetState(MediaState::PAUSED);

  DCHECK(consumer_.is_bound());
  consumer_->Prime([this, callback]() {
    callback.Run();
  });
}

void MojoProducer::FlushConnection(const FlushConnectionCallback& callback) {
  {
    base::AutoLock lock(lock_);
    max_pushes_outstanding_ = 0;
  }

  DCHECK(demand_callback_);
  demand_callback_(Demand::kNegative);

  DCHECK(consumer_.is_bound());
  consumer_->Flush(callback);
  first_pts_since_flush_ = Packet::kUnknownPts;
  end_of_stream_= false;
}

void MojoProducer::SetStatusCallback(
    const StatusCallback& callback) {
  status_callback_ = callback;
}

int64_t MojoProducer::GetFirstPtsSinceFlush() {
  return first_pts_since_flush_;
}

PayloadAllocator* MojoProducer::allocator() {
  return &mojo_allocator_;
}

void MojoProducer::SetDemandCallback(const DemandCallback& demand_callback) {
  demand_callback_ = demand_callback;
}

Demand MojoProducer::SupplyPacket(PacketPtr packet) {
  DCHECK(packet);

  if (first_pts_since_flush_ == Packet::kUnknownPts) {
    first_pts_since_flush_ = packet->pts();
  }

  // If we're no longer connected, throw the packet away.
  if (!consumer_.is_bound()) {
    SetState(MediaState::UNPREPARED);
    // TODO(dalesat): More shutdown?
    return Demand::kNegative;
  }

  Demand demand;

  {
    base::AutoLock lock(lock_);
    DCHECK(current_pushes_outstanding_ < max_pushes_outstanding_);
    DCHECK(!end_of_stream_) << "packet pushed after end-of-stream";

    ++current_pushes_outstanding_;

    if (packet->end_of_stream()) {
      end_of_stream_ = true;
      demand = Demand::kNegative;
      max_pushes_outstanding_ = 0;
    } else {
      demand = current_pushes_outstanding_ < max_pushes_outstanding_ ?
          Demand::kPositive :
          Demand::kNegative;
    }
  }

  MediaPacketPtr media_packet = CreateMediaPacket(packet);
  task_runner_->PostTask(FROM_HERE, base::Bind(
      &MojoProducer::SendPacket,
      base::Unretained(this),
      packet.release(),
      base::Passed(media_packet.Pass())));

  return demand;
}

void MojoProducer::Connect(
    InterfaceHandle<MediaConsumer> consumer,
    const ConnectCallback& callback) {
  DCHECK(consumer);

  consumer_ = MediaConsumerPtr::Create(std::move(consumer));

  if (!mojo_allocator_.initialized()) {
    mojo_allocator_.InitNew(256 * 1024); // TODO(dalesat): Made up!
  }

  consumer_->SetBuffer(
      mojo_allocator_.GetDuplicateHandle(),
      mojo_allocator_.size(),
      [callback]() {
    callback.Run();
  });
}

void MojoProducer::Disconnect() {
  DCHECK(demand_callback_);
  demand_callback_(Demand::kNegative);
  SetState(MediaState::UNPREPARED);
  consumer_.reset();
}

void MojoProducer::SendPacket(
    Packet* packet_raw_ptr,
    MediaPacketPtr media_packet) {
  consumer_->SendPacket(
    media_packet.Pass(),
    [this, packet_raw_ptr](MediaConsumer::SendResult send_result) {
      PacketPtr packet = PacketPtr(packet_raw_ptr);
      Demand demand;

      {
        base::AutoLock lock(lock_);
        demand = --current_pushes_outstanding_ < max_pushes_outstanding_ ?
            Demand::kPositive :
            Demand::kNegative;
      }

      DCHECK(demand_callback_);
      demand_callback_(demand);

      if (end_of_stream_ && packet->end_of_stream()) {
        SetState(MediaState::ENDED);
      }
    });
}

void MojoProducer::SetState(MediaState state) {
  if (state_ != state) {
    state_ = state;
    if (status_callback_) {
      status_callback_(state_);
    }
  }
}

MediaPacketPtr MojoProducer::CreateMediaPacket(
    const PacketPtr& packet) {
  DCHECK(packet);

  MediaPacketRegionPtr region = MediaPacketRegion::New();
  region->offset = packet->size() == 0 ? 0 :
      mojo_allocator_.OffsetFromPtr(packet->payload());
  region->length = packet->size();

  MediaPacketPtr media_packet = MediaPacket::New();
  media_packet->pts = packet->pts();
  media_packet->end_of_stream = packet->end_of_stream();
  media_packet->payload = region.Pass();

  return media_packet.Pass();
}

} // namespace media
} // namespace mojo
