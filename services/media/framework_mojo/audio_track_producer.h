// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_AUDIO_TRACK_PRODUCER_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_AUDIO_TRACK_PRODUCER_H_

#include "services/media/framework_mojo/push_producer_base.h"

namespace mojo {
namespace media {

// Delivers a stream to an audio track's MediaPipe.
class AudioTrackProducer : public PushProducerBase {
 public:
  using FlushPipeCallback = mojo::Callback<void()>;

  static std::shared_ptr<AudioTrackProducer> Create(
      MediaPipePtr pipe) {
    return std::shared_ptr<AudioTrackProducer>(
        new AudioTrackProducer(pipe.Pass()));
  }

  ~AudioTrackProducer() override;

  // Tells the connected pipe to flush.
  void FlushPipe(const FlushPipeCallback& callback);

 protected:
  // PushProducerBase overrrides.
  bool IsConnected() override;

  void PushPacketInternal(Packet* packet_raw_ptr, MediaPacketPtr media_packet)
      override;

 private:
  AudioTrackProducer(MediaPipePtr pipe);

  MediaPipePtr pipe_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_MOJO_AUDIO_TRACK_PRODUCER_SINK_H_
