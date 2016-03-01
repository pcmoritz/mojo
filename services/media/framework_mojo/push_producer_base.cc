// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "services/media/framework_mojo/push_producer_base.h"

namespace mojo {
namespace media {

PushProducerBase::PushProducerBase() :
    state_(MediaState::UNPREPARED),
    end_of_stream_(false),
    max_pushes_outstanding_(0),
    current_pushes_outstanding_(0) {
  task_runner_ = base::MessageLoop::current()->task_runner();
  DCHECK(task_runner_);
}

PushProducerBase::~PushProducerBase() {
  base::AutoLock lock(lock_);
}

void PushProducerBase::SetStatusCallback(
    const StatusCallback& callback) {
  status_callback_ = callback;
}

PayloadAllocator* PushProducerBase::allocator() {
  return &mojo_allocator_;
}

void PushProducerBase::SetDemandCallback(
    const DemandCallback& demand_callback) {
  demand_callback_ = demand_callback;
}

void PushProducerBase::Prime() {
  {
    base::AutoLock lock(lock_);
    max_pushes_outstanding_ = 10; // TODO(dalesat): Made up!
  }

  DCHECK(demand_callback_);
  demand_callback_(Demand::kPositive);
  SetState(MediaState::PAUSED);
}

Demand PushProducerBase::SupplyPacket(PacketPtr packet) {
  DCHECK(packet);

  // If we're no longer connected, throw the packet away.
  if (!IsConnected()) {
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
      &PushProducerBase::PushPacket,
      base::Unretained(this),
      packet.release(),
      base::Passed(media_packet.Pass())));

  return demand;
}

void PushProducerBase::PushPacket(
    Packet* packet_raw_ptr,
    MediaPacketPtr media_packet) {
  PushPacketInternal(packet_raw_ptr, media_packet.Pass());
}

void PushProducerBase::PushCompleted(const PacketPtr& packet) {
  DCHECK(packet);

  Demand demand;

  {
    base::AutoLock lock(lock_);
    DCHECK(current_pushes_outstanding_);
    demand = --current_pushes_outstanding_ < max_pushes_outstanding_ ?
        Demand::kPositive :
        Demand::kNegative;
  }

  DCHECK(demand_callback_);
  demand_callback_(demand);

  if (end_of_stream_ && packet->end_of_stream()) {
    SetState(MediaState::ENDED);
  }
}

void PushProducerBase::OnConnectionLost() {
  DCHECK(demand_callback_);
  demand_callback_(Demand::kNegative);
  SetState(MediaState::UNPREPARED);
}

void PushProducerBase::SetState(MediaState state) {
  if (state_ != state) {
    state_ = state;
    if (status_callback_) {
      status_callback_(state_);
    }
  }
}

MediaPacketPtr PushProducerBase::CreateMediaPacket(
    const PacketPtr& packet) {
  DCHECK(packet);

  MediaPacketRegionPtr region = MediaPacketRegion::New();
  region->offset = mojo_allocator_.OffsetFromPtr(packet->payload());
  region->length = packet->size();

  MediaPacketPtr media_packet = MediaPacket::New();
  media_packet->pts = packet->presentation_time();
  media_packet->duration = packet->duration();
  media_packet->end_of_stream = packet->end_of_stream();
  media_packet->payload = region.Pass();

  return media_packet.Pass();
}

} // namespace media
} // namespace mojo
