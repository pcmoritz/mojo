// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework_mojo/mojo_producer.h"

namespace mojo {
namespace media {

MojoProducer::MojoProducer() {}

MojoProducer::~MojoProducer() {}

void MojoProducer::AddBinding(InterfaceRequest<MediaProducer> producer) {
  bindings_.AddBinding(this, producer.Pass());
}

void MojoProducer::FlushConsumer(const FlushConsumerCallback& callback) {
  DCHECK(consumer_.is_bound());
  consumer_->Flush(callback);
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
  OnConnectionLost();
  consumer_.reset();
}

bool MojoProducer::IsConnected() {
  return consumer_.is_bound();
}

void MojoProducer::PushPacketInternal(
    Packet* packet_raw_ptr,
    MediaPacketPtr media_packet) {
  consumer_->PushPacket(
    media_packet.Pass(),
    [this, packet_raw_ptr]() {
      PacketPtr packet = PacketPtr(packet_raw_ptr);
      PushCompleted(packet);
    });
}

} // namespace media
} // namespace mojo
