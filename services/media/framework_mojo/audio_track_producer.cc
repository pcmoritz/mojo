// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework_mojo/audio_track_producer.h"

namespace mojo {
namespace media {

AudioTrackProducer::AudioTrackProducer(MediaPipePtr pipe) :
    pipe_(pipe.Pass()) {
  DCHECK(pipe_.is_bound());

  DCHECK(!mojo_allocator_.initialized());
  mojo_allocator_.InitNew(256 * 1024); // TODO(dalesat): Made up!

  pipe_->SetBuffer(
      mojo_allocator_.GetDuplicateHandle(),
      mojo_allocator_.size());
}

AudioTrackProducer::~AudioTrackProducer() {}

bool AudioTrackProducer::IsConnected() {
  return pipe_.is_bound();
}

void AudioTrackProducer::PushPacketInternal(
    Packet* packet_raw_ptr,
    MediaPacketPtr media_packet) {
  DCHECK(pipe_.is_bound());
  pipe_->SendPacket(
      media_packet.Pass(),
      [this, packet_raw_ptr](MediaPipe::SendResult result) {
        PacketPtr packet = PacketPtr(packet_raw_ptr);
        PushCompleted(packet);
      });
}

void AudioTrackProducer::FlushPipe(const FlushPipeCallback& callback) {
  DCHECK(pipe_.is_bound());
  pipe_->Flush(callback);
}

} // namespace media
} // namespace mojo
