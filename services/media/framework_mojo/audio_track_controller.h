// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_AUDIO_TRACK_CONTROLLER_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_AUDIO_TRACK_CONTROLLER_H_

#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/media/audio/interfaces/audio_track.mojom.h"
#include "mojo/services/media/common/interfaces/media_pipe.mojom.h"
#include "services/media/framework/graph.h"
#include "services/media/framework/stream_type.h"
#include "services/media/framework_mojo/audio_track_producer.h"

namespace mojo {
namespace media {

// Controls an audio track.
class AudioTrackController {
 public:
  using ConstructorCallback =
      Callback<void(std::shared_ptr<AudioTrackProducer>)>;
  using SetRateCallback = std::function<void(TimelineTransformPtr)>;

  AudioTrackController(
      const String& url,
      std::unique_ptr<StreamType> stream_type,
      Graph* graph,
      OutputRef output,
      ApplicationImpl* app,
      const ConstructorCallback& callback);

  ~AudioTrackController();

  // Sets the rate.
  void SetRate(float rate_factor, const SetRateCallback& callback);

 private:
  AudioTrackPtr audio_track_;
  RateControlPtr rate_control_;
  MediaPipePtr pipe_;
  uint32_t frames_per_second_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_MOJO_AUDIO_TRACK_CONTROLLER_H_
