// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_MEDIA_SINK_IMPL_H_
#define MOJO_SERVICES_MEDIA_FACTORY_MEDIA_SINK_IMPL_H_

#include <deque>
#include <memory>

#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/media/common/cpp/linear_transform.h"
#include "mojo/services/media/control/interfaces/media_sink.mojom.h"
#include "services/media/factory_service/audio_track_controller.h"
#include "services/media/factory_service/event.h"
#include "services/media/factory_service/factory_service.h"
#include "services/media/framework/graph.h"
#include "services/media/framework/parts/decoder.h"
#include "services/media/framework_mojo/mojo_consumer.h"
#include "services/media/framework_mojo/mojo_producer.h"

namespace mojo {
namespace media {

// Mojo agent that consumes a stream and delivers it to a destination specified
// by URL.
class MediaSinkImpl : public MediaFactoryService::Product, public MediaSink {
 public:
  static std::shared_ptr<MediaSinkImpl> Create(
      const String& destination_url,
      MediaTypePtr media_type,
      InterfaceRequest<MediaSink> request,
      MediaFactoryService* owner);

  ~MediaSinkImpl() override;

  // MediaSink implementation.
  void GetClockDisposition(
      const GetClockDispositionCallback& callback) override;

  void GetMasterClock(InterfaceRequest<Clock> master_clock) override;

  void SetMasterClock(InterfaceHandle<Clock> master_clock) override;

  void GetConsumer(InterfaceRequest<MediaConsumer> consumer) override;

  void GetStatus(uint64_t version_last_seen,
                 const GetStatusCallback& callback) override;

  void Play() override;

  void Pause() override;

 private:
  MediaSinkImpl(const String& destination_url,
                MediaTypePtr media_type,
                InterfaceRequest<MediaSink> request,
                MediaFactoryService* owner);

  // Increments the status version and runs pending status request callbacks.
  void StatusUpdated();

  // Runs status request callback.
  void RunStatusCallback(const GetStatusCallback& callback) const;

  // Sets the rate if the producer is ready and the target rate differs from
  // the current rate.
  void MaybeSetRate();

  Event ready_ = Event::Create();
  Binding<MediaSink> binding_;
  Graph graph_;
  std::shared_ptr<MojoConsumer> consumer_;
  std::shared_ptr<MojoProducer> producer_;
  std::unique_ptr<AudioTrackController> controller_;
  RateControlPtr rate_control_;
  float rate_ = 0.0f;
  float target_rate_ = 0.0f;
  uint64_t status_version_ = 1u;
  MediaState producer_state_ = MediaState::UNPREPARED;
  LinearTransform transform_ = LinearTransform(0, 0, 1, 0);
  TimelineTransformPtr status_transform_;
  std::deque<GetStatusCallback> pending_status_requests_;
  uint32_t frames_per_second_ = 0u;
  bool flushed_ = true;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_MEDIA_SINK_IMPL_H_
