// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/factory_service/media_player_impl.h"
#include "services/media/factory_service/watched.h"
#include "services/media/framework/parts/reader.h"
#include "url/gurl.h"

namespace mojo {
namespace media {

// static
std::shared_ptr<MediaPlayerImpl> MediaPlayerImpl::Create(
    const String& origin_url,
    InterfaceRequest<MediaPlayer> request,
    MediaFactoryService* owner) {
  return std::shared_ptr<MediaPlayerImpl>(
      new MediaPlayerImpl(origin_url, request.Pass(), owner));
}

MediaPlayerImpl::MediaPlayerImpl(const String& origin_url,
                                 InterfaceRequest<MediaPlayer> request,
                                 MediaFactoryService* owner)
    : MediaFactoryService::Product(owner), binding_(this, request.Pass()) {
  DCHECK(origin_url);

  target_state_.SetWithConsequences(MediaState::PAUSED);
  target_position_.SetWithConsequences(kNotSeeking);

  // Go away when the client is no longer connected.
  binding_.set_connection_error_handler([this]() { ReleaseFromOwner(); });

  app()->ConnectToService("mojo:media_factory", &factory_);

  factory_->CreateSource(origin_url,
                         nullptr,  // allowed_media_types
                         GetProxy(&source_));

  HandleSourceStatusUpdates();

  source_->GetStreams(
      [this](mojo::Array<MediaSourceStreamDescriptorPtr> descriptors) {
        // Populate streams_ and enable the streams we want.
        std::vector<Event> stream_prepared_events;

        for (MediaSourceStreamDescriptorPtr& descriptor : descriptors) {
          streams_.push_back(std::unique_ptr<Stream>(new Stream()));
          Stream& stream = *streams_.back();
          stream.descriptor_ = descriptor.Pass();
          switch (stream.descriptor_->media_type->scheme) {
            case MediaTypeScheme::COMPRESSED_AUDIO:
            case MediaTypeScheme::LPCM:
              stream.enabled_ = true;
              stream_prepared_events.push_back(
                  PrepareStream(streams_.back(), "mojo:audio_server"));
              break;
            // TODO(dalesat): Enable other stream types.
            default:
              break;
          }
        }

        event_ = Event::All(stream_prepared_events).When([this]() {
          // The enabled streams are prepared. Prepare the source.
          factory_.reset();
          source_->Prepare([this]() {
            SetReportedMediaState(MediaState::PAUSED);
            WhenPaused();
          });
        });
      });
}

MediaPlayerImpl::~MediaPlayerImpl() {
  event_.Cancel();
}

void MediaPlayerImpl::WhenPaused() {
  Event seek_requested = target_position_.BecomesOtherThan(kNotSeeking);
  Event play_requested = target_state_.Becomes(MediaState::PLAYING);

  event_ = Event::First({seek_requested, play_requested});

  seek_requested.When([this]() { WhenPausedAndSeeking(); });

  play_requested.When([this]() {
    flushed_ = false;

    source_->Prime([this]() {
      event_ = ChangeSinkStates(MediaState::PLAYING).When([this]() {
        WhenPlaying();
      });
    });
  });
}

void MediaPlayerImpl::WhenPlaying() {
  SetReportedMediaState(MediaState::PLAYING);

  Event seek_requested = target_position_.BecomesOtherThan(kNotSeeking);
  Event pause_requested = target_state_.Becomes(MediaState::PAUSED);
  Event sinks_ended = AllSinkStatesBecome(MediaState::ENDED);

  event_ = Event::First({seek_requested, pause_requested, sinks_ended});

  seek_requested.When([this]() {
    event_ = ChangeSinkStates(MediaState::PAUSED).When([this]() {
      WhenPausedAndSeeking();
    });
  });

  pause_requested.When([this]() {
    event_ = ChangeSinkStates(MediaState::PAUSED).When([this]() {
      SetReportedMediaState(MediaState::PAUSED);
      WhenPaused();
    });
  });

  sinks_ended.When([this]() {
    target_state_.SetWithConsequences(MediaState::ENDED);
    SetReportedMediaState(MediaState::ENDED);
    WhenPaused();
  });
}

void MediaPlayerImpl::WhenPausedAndSeeking() {
  if (!flushed_) {
    source_->Flush([this]() {
      flushed_ = true;
      WhenFlushedAndSeeking();
    });
  } else {
    WhenFlushedAndSeeking();
  }
}

void MediaPlayerImpl::WhenFlushedAndSeeking() {
  source_->Seek(target_position_, [this]() {
    target_position_.SetWithConsequences(kNotSeeking);
    WhenPaused();
  });
}

Event MediaPlayerImpl::ChangeSinkStates(MediaState media_state) {
  for (auto& stream : streams_) {
    if (stream->enabled_) {
      if (media_state == MediaState::PAUSED) {
        stream->sink_->Pause();
      } else {
        stream->sink_->Play();
      }
    }
  }

  return AllSinkStatesBecome(media_state);
}

Event MediaPlayerImpl::AllSinkStatesBecome(MediaState media_state) {
  std::vector<Event> precursors;

  for (auto& stream : streams_) {
    if (stream->enabled_) {
      precursors.push_back(stream->state_.Becomes(media_state));
    }
  }

  return Event::All(precursors);
}

void MediaPlayerImpl::SetReportedMediaState(MediaState media_state) {
  if (reported_media_state_ != media_state) {
    reported_media_state_ = media_state;
    StatusUpdated();
  }
}

void MediaPlayerImpl::GetStatus(uint64_t version_last_seen,
                                const GetStatusCallback& callback) {
  if (version_last_seen < status_version_) {
    RunStatusCallback(callback);
  } else {
    pending_status_requests_.push_back(callback);
  }
}

void MediaPlayerImpl::Play() {
  target_state_.SetWithConsequences(MediaState::PLAYING);
}

void MediaPlayerImpl::Pause() {
  target_state_.SetWithConsequences(MediaState::PAUSED);
}

void MediaPlayerImpl::Seek(int64_t position) {
  DCHECK(position != kNotSeeking);
  target_position_.SetWithConsequences(position);
}

Event MediaPlayerImpl::PrepareStream(const std::unique_ptr<Stream>& stream,
                                     const String& url) {
  DCHECK(factory_);

  Event event = Event::Create();

  source_->GetProducer(stream->descriptor_->index,
                       GetProxy(&stream->encoded_producer_));

  if (stream->descriptor_->media_type->scheme ==
      MediaTypeScheme::COMPRESSED_AUDIO) {
    // Compressed audio. Insert a decoder in front of the sink. The sink would
    // add its own internal decoder, but we want to test the decoder.
    factory_->CreateDecoder(stream->descriptor_->media_type.Clone(),
                            GetProxy(&stream->decoder_));

    MediaConsumerPtr decoder_consumer;
    stream->decoder_->GetConsumer(GetProxy(&decoder_consumer));

    Event connect_complete = Event::Create();
    stream->encoded_producer_->Connect(decoder_consumer.Pass(),
                                       [&stream, connect_complete]() {
                                         stream->encoded_producer_.reset();
                                         connect_complete.Occur();
                                       });

    stream->decoder_->GetOutputType(
        [this, &stream, url, event](MediaTypePtr output_type) {
          stream->decoder_->GetProducer(GetProxy(&stream->decoded_producer_));

          CreateSink(stream, output_type, url, event);
        });

    return Event::All({connect_complete, event});
  } else {
    // Uncompressed audio. Connect the source stream directly to the sink. This
    // would work for compressed audio as well (the sink would decode), but we
    // want to test the decoder.
    DCHECK(stream->descriptor_->media_type->scheme == MediaTypeScheme::LPCM);
    stream->decoded_producer_ = stream->encoded_producer_.Pass();
    CreateSink(stream, stream->descriptor_->media_type, url, event);
    return event;
  }
}

void MediaPlayerImpl::CreateSink(const std::unique_ptr<Stream>& stream,
                                 const MediaTypePtr& input_media_type,
                                 const String& url,
                                 Event event) {
  DCHECK(input_media_type);
  DCHECK(stream->decoded_producer_);
  DCHECK(factory_);

  factory_->CreateSink(url, input_media_type.Clone(), GetProxy(&stream->sink_));

  MediaConsumerPtr consumer;
  stream->sink_->GetConsumer(GetProxy(&consumer));

  stream->decoded_producer_->Connect(consumer.Pass(), [this, event, &stream]() {
    stream->decoded_producer_.reset();

    DCHECK(stream->state_ == MediaState::UNPREPARED);
    DCHECK(reported_media_state_ == MediaState::UNPREPARED ||
           reported_media_state_ == MediaState::FAULT);

    stream->state_.SetWithConsequences(MediaState::PAUSED);

    HandleSinkStatusUpdates(stream);

    event.Occur();
  });
}

void MediaPlayerImpl::StatusUpdated() {
  ++status_version_;
  while (!pending_status_requests_.empty()) {
    RunStatusCallback(pending_status_requests_.front());
    pending_status_requests_.pop_front();
  }
}

void MediaPlayerImpl::RunStatusCallback(
    const GetStatusCallback& callback) const {
  MediaPlayerStatusPtr status = MediaPlayerStatus::New();
  status->state = reported_media_state_;
  status->timeline_transform = transform_.Clone();
  status->metadata = metadata_.Clone();
  callback.Run(status_version_, status.Pass());
}

void MediaPlayerImpl::HandleSourceStatusUpdates(uint64_t version,
                                                MediaSourceStatusPtr status) {
  if (status) {
    metadata_ = status->metadata.Pass();
    StatusUpdated();
  }

  source_->GetStatus(version,
                     [this](uint64_t version, MediaSourceStatusPtr status) {
                       HandleSourceStatusUpdates(version, status.Pass());
                     });
}

void MediaPlayerImpl::HandleSinkStatusUpdates(
    const std::unique_ptr<Stream>& stream,
    uint64_t version,
    MediaSinkStatusPtr status) {
  if (status && status->state > MediaState::UNPREPARED) {
    // We transition to PAUSED when Connect completes.
    DCHECK(stream->state_ > MediaState::UNPREPARED);
    stream->state_.SetWithConsequences(status->state);
    transform_ = status->timeline_transform.Pass();
    StatusUpdated();
  }

  stream->sink_->GetStatus(
      version, [this, &stream](uint64_t version, MediaSinkStatusPtr status) {
        HandleSinkStatusUpdates(stream, version, status.Pass());
      });
}

MediaPlayerImpl::Stream::Stream() {
  state_.SetWithConsequences(MediaState::UNPREPARED);
}

MediaPlayerImpl::Stream::~Stream() {}

}  // namespace media
}  // namespace mojo
