// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <list>

#include "base/bind_helpers.h"
#include "base/logging.h"
#include "mojo/services/media/audio/interfaces/audio_server.mojom.h"
#include "mojo/services/media/audio/interfaces/audio_track.mojom.h"
#include "mojo/services/media/common/cpp/linear_transform.h"
#include "mojo/services/media/common/cpp/local_time.h"
#include "services/media/framework/conversion_pipeline_builder.h"
#include "services/media/framework_mojo/audio_track_controller.h"
#include "services/media/framework_mojo/mojo_type_conversions.h"

namespace mojo {
namespace media {

AudioTrackController::AudioTrackController(
    const String& url,
    std::unique_ptr<StreamType> stream_type,
    Graph* graph,
    OutputRef output,
    ApplicationImpl* app,
    const ConstructorCallback& callback) {
  DCHECK(stream_type);
  DCHECK(graph);
  DCHECK(output);
  DCHECK(app);

  AudioServerPtr audio_server;
  app->ConnectToService(url, &audio_server);
  audio_server->CreateTrack(GetProxy(&audio_track_));

  // TODO(dalesat): Remove capture hack once c++14 is happening.
  std::shared_ptr<StreamType> captured_stream_type(stream_type.release());

  // Query the track's format capabilities.
  audio_track_->Describe(
    [this, callback, captured_stream_type, graph, output]
    (AudioTrackDescriptorPtr descriptor) {
      std::unique_ptr<StreamType> producer_stream_type;

      // Add transforms to the pipeline to convert from stream_type to a type
      // supported by the track.
      OutputRef out = output;
      bool result = BuildConversionPipeline(
          *captured_stream_type,
          *Convert(descriptor->supported_media_types),
          graph,
          &out,
          &producer_stream_type);
      if (!result) {
        // Failed to build conversion pipeline.
        callback.Run(nullptr);
        return;
      }

      switch (producer_stream_type->scheme()) {
        case StreamType::Scheme::kLpcm:
          frames_per_second_ =
              producer_stream_type->lpcm()->frames_per_second();
          break;
        case StreamType::Scheme::kCompressedAudio:
          frames_per_second_ =
              producer_stream_type->compressed_audio()->frames_per_second();
          break;
        default:
          // Unsupported producer stream type.
          callback.Run(nullptr);
          return;
      }

      AudioTrackConfigurationPtr config = AudioTrackConfiguration::New();
      config->media_type = Convert(std::move(producer_stream_type));

      audio_track_->Configure(config.Pass(), GetProxy(&pipe_));

      std::shared_ptr<AudioTrackProducer> sink =
          AudioTrackProducer::Create(pipe_.Pass());
      graph->ConnectOutputToPart(out, graph->Add(sink));
      callback.Run(sink);
    });
}

AudioTrackController::~AudioTrackController() {}

void AudioTrackController::SetRate(
    float rate_factor,
    const SetRateCallback& callback) {
  // TODO(dalesat): Set the rate at a particular local time to coordinate rate
  // changes for multiple outputs.
  // TODO(dalesat): Need to specify the starting media time for seek and for
  // sources that don't start at zero.
  if (!rate_control_.is_bound()) {
    audio_track_->GetRateControl(GetProxy(&rate_control_));
  }

  LinearTransform::Ratio audio_rate(
      static_cast<uint32_t>(frames_per_second_ * rate_factor), 1);
  LinearTransform::Ratio local_time_rate(
      LocalDuration::period::num,
      LocalDuration::period::den);

  LinearTransform::Ratio rate;
  bool success =
      LinearTransform::Ratio::Compose(local_time_rate, audio_rate, &rate);
  DCHECK(success)
      << "LinearTransform::Ratio::Compose reports loss of precision";

  rate_control_->SetRate(rate.numerator, rate.denominator);

  // TODO(dalesat): Replace this with a clock.
  // The code below produces a transform that translates local time into media
  // time in nanosecond units. That transform is delivered to the application,
  // which uses it to implement a progress bar. This is OK for demo purposes,
  // but we really need a clock rather than this static transform.
  rate_control_->GetCurrentTransform(
    [this, callback](TimelineTransformPtr transform) {
      // Get the frame rate in local duration units.
      LinearTransform::Ratio audio_rate(frames_per_second_, 1);
      LinearTransform::Ratio local_time_rate(
          LocalDuration::period::num,
          LocalDuration::period::den);
      LinearTransform::Ratio presentation_rate;
      bool success = LinearTransform::Ratio::Compose(
          local_time_rate,
          audio_rate,
          &presentation_rate);
      DCHECK(success)
          << "LinearTransform::Ratio::Compose reports loss of precision";

      // Create a LinearTransform to translate from presentation units to
      // local duration units.
      LinearTransform local_to_presentation(0, presentation_rate, 0);

      // Translate the current transform quad so the presentation time units
      // are the same as the local time units.
      success = local_to_presentation.DoReverseTransform(
          transform->quad->reference_offset,
          &transform->quad->reference_offset);
      DCHECK(success)
          << "LinearTransform::DoReverseTransform reports loss of precision";
      int64_t presentation_delta;
      success = local_to_presentation.DoReverseTransform(
          static_cast<int64_t>(transform->quad->reference_delta),
          &presentation_delta);
      DCHECK(success)
          << "LinearTransform::DoReverseTransform reports loss of precision";
      transform->quad->reference_delta =
          static_cast<int32_t>(presentation_delta);
      LinearTransform::Ratio::Reduce(
          &transform->quad->reference_delta,
          &transform->quad->target_delta);

      callback(transform.Clone());
    });
}

} // namespace media
} // namespace mojo
