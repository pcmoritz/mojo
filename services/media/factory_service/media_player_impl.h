// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_MEDIA_PLAYER_IMPL_H_
#define MOJO_SERVICES_MEDIA_FACTORY_MEDIA_PLAYER_IMPL_H_

#include <deque>
#include <limits>
#include <vector>

#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"
#include "mojo/services/media/control/interfaces/media_factory.mojom.h"
#include "services/media/factory_service/factory_service.h"
#include "services/media/factory_service/watched.h"

namespace mojo {
namespace media {

// Mojo agent that renders streams from an origin specified by URL.
class MediaPlayerImpl : public MediaFactoryService::Product,
                        public MediaPlayer {
 public:
  static std::shared_ptr<MediaPlayerImpl> Create(
      const String& originUrl,
      InterfaceRequest<MediaPlayer> request,
      MediaFactoryService* owner);

  ~MediaPlayerImpl() override;

  // MediaPlayer implementation.
  void GetStatus(uint64_t version_last_seen,
                 const GetStatusCallback& callback) override;

  void Play() override;

  void Pause() override;

  void Seek(int64_t position) override;

 private:
  const int64_t kNotSeeking = std::numeric_limits<int64_t>::max();

  struct Stream {
    Stream();
    ~Stream();
    bool enabled_ = false;
    Watched<MediaState> state_;
    MediaSourceStreamDescriptorPtr descriptor_;
    MediaTypeConverterPtr decoder_;
    MediaSinkPtr sink_;
    MediaProducerPtr encoded_producer_;
    MediaProducerPtr decoded_producer_;
  };

  MediaPlayerImpl(const String& originUrl,
                  InterfaceRequest<MediaPlayer> request,
                  MediaFactoryService* owner);

  // Handles events in paused state.
  void WhenPaused();

  // Handles events in playing state.
  void WhenPlaying();

  // Handles events when seeking in paused state.
  void WhenPausedAndSeeking();

  // Handles events when seeking with flushed pipeline.
  void WhenFlushedAndSeeking();

  // Tells the sinks to change state and returns an Event that occurs when this
  // is accomplished.
  Event ChangeSinkStates(MediaState media_state);

  // Returns an Event the occurs when all sinks are in the indicated state.
  Event AllSinkStatesBecome(MediaState media_state);

  // Sets the reported_media_state_ field, calling StatusUpdated as needed.
  void SetReportedMediaState(MediaState media_state);

  // Prepares a stream.
  Event PrepareStream(const std::unique_ptr<Stream>& stream, const String& url);

  // Creates a sink for a stream.
  // TODO(dalesat): Use raw pointers rather than const std::unique_ptr<>&.
  void CreateSink(const std::unique_ptr<Stream>& stream,
                  const MediaTypePtr& input_media_type,
                  const String& url,
                  Event event);

  // Increments the status version and runs pending status request callbacks.
  void StatusUpdated();

  // Runs a status request callback.
  void RunStatusCallback(const GetStatusCallback& callback) const;

  // Handles a status update from the source. When called with the default
  // argument values, initiates source status updates.
  void HandleSourceStatusUpdates(uint64_t version = MediaSource::kInitialStatus,
                                 MediaSourceStatusPtr status = nullptr);

  // Handles a status update from a sink. When called with the default
  // argument values, initiates sink status updates.
  void HandleSinkStatusUpdates(const std::unique_ptr<Stream>& stream,
                               uint64_t version = MediaSink::kInitialStatus,
                               MediaSinkStatusPtr status = nullptr);

  Event event_;
  Binding<MediaPlayer> binding_;
  MediaFactoryPtr factory_;
  MediaSourcePtr source_;
  std::vector<std::unique_ptr<Stream>> streams_;
  uint64_t status_version_ = 1u;
  bool flushed_ = true;
  MediaState reported_media_state_ = MediaState::UNPREPARED;
  Watched<MediaState> target_state_;
  Watched<int64_t> target_position_;
  TimelineTransformPtr transform_;
  MediaMetadataPtr metadata_;
  std::deque<GetStatusCallback> pending_status_requests_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_MEDIA_PLAYER_IMPL_H_
