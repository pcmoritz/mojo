// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/factory_service/media_player_impl.h"
#include "services/media/framework/callback_joiner.h"
#include "services/media/framework/parts/reader.h"
#include "url/gurl.h"

namespace mojo {
namespace media {

// static
std::shared_ptr<MediaPlayerImpl> MediaPlayerImpl::Create(
    InterfaceHandle<SeekingReader> reader,
    InterfaceRequest<MediaPlayer> request,
    MediaFactoryService* owner) {
  return std::shared_ptr<MediaPlayerImpl>(
      new MediaPlayerImpl(reader.Pass(), request.Pass(), owner));
}

MediaPlayerImpl::MediaPlayerImpl(InterfaceHandle<SeekingReader> reader,
                                 InterfaceRequest<MediaPlayer> request,
                                 MediaFactoryService* owner)
    : MediaFactoryService::Product(owner), binding_(this, request.Pass()) {
  DCHECK(reader);

  state_ = State::kWaiting;

  // Go away when the client is no longer connected.
  binding_.set_connection_error_handler([this]() { ReleaseFromOwner(); });

  app()->ConnectToService("mojo:media_factory", &factory_);

  factory_->CreateSource(reader.Pass(),
                         nullptr,  // allowed_media_types
                         GetProxy(&source_));

  HandleSourceStatusUpdates();

  source_->GetStreams([this](
      mojo::Array<MediaSourceStreamDescriptorPtr> descriptors) {
    // Populate streams_ and enable the streams we want.
    std::shared_ptr<CallbackJoiner> callback_joiner = CallbackJoiner::Create();

    for (MediaSourceStreamDescriptorPtr& descriptor : descriptors) {
      streams_.push_back(std::unique_ptr<Stream>(new Stream()));
      Stream& stream = *streams_.back();
      stream.descriptor_ = descriptor.Pass();
      switch (stream.descriptor_->media_type->scheme) {
        case MediaTypeScheme::COMPRESSED_AUDIO:
        case MediaTypeScheme::LPCM:
          stream.enabled_ = true;
          PrepareStream(streams_.back(), "mojo:audio_server",
                        callback_joiner->NewCallback());
          break;
        // TODO(dalesat): Enable other stream types.
        default:
          break;
      }
    }

    callback_joiner->WhenJoined([this]() {
      // The enabled streams are prepared. Prepare the source.
      factory_.reset();
      PrepareSource();
    });
  });
}

MediaPlayerImpl::~MediaPlayerImpl() {}

void MediaPlayerImpl::PrepareSource() {
  source_->Prepare([this]() {
    SetReportedMediaState(MediaState::PAUSED);
    state_ = State::kPaused;
    Update();
  });
}

void MediaPlayerImpl::Update() {
  while (true) {
    switch (state_) {
      case State::kPaused:
        if (target_position_ != kNotSeeking) {
          WhenPausedAndSeeking();
          break;
        }

        if (target_state_ == MediaState::PLAYING) {
          if (!flushed_) {
            ChangeSinkStates(MediaState::PLAYING);
            state_ = State::kWaitingForSinksToPlay;
            break;
          }

          flushed_ = false;
          state_ = State::kWaiting;
          source_->Prime([this]() {
            ChangeSinkStates(MediaState::PLAYING);
            state_ = State::kWaitingForSinksToPlay;
            Update();
          });
        }
        return;

      case State::kWaitingForSinksToPlay:
        if (AllSinksAre(SinkState::kPlayingOrEnded)) {
          state_ = State::kPlaying;
          if (target_state_ == MediaState::PLAYING) {
            SetReportedMediaState(MediaState::PLAYING);
          }
        }
        return;

      case State::kPlaying:
        if (target_position_ != kNotSeeking ||
            target_state_ == MediaState::PAUSED) {
          ChangeSinkStates(MediaState::PAUSED);
          state_ = State::kWaitingForSinksToPause;
          break;
        }

        if (AllSinksAre(SinkState::kEnded)) {
          target_state_ = MediaState::ENDED;
          SetReportedMediaState(MediaState::ENDED);
          state_ = State::kPaused;
          break;
        }
        return;

      case State::kWaitingForSinksToPause:
        if (AllSinksAre(SinkState::kPausedOrEnded)) {
          if (target_state_ == MediaState::PAUSED) {
            if (AllSinksAre(SinkState::kEnded)) {
              SetReportedMediaState(MediaState::ENDED);
            } else {
              SetReportedMediaState(MediaState::PAUSED);
            }
          }

          state_ = State::kPaused;
          break;
        }
        return;

      case State::kWaiting:
        return;
    }
  }
}

void MediaPlayerImpl::WhenPausedAndSeeking() {
  if (!flushed_) {
    state_ = State::kWaiting;
    source_->Flush([this]() {
      flushed_ = true;
      WhenFlushedAndSeeking();
    });
  } else {
    WhenFlushedAndSeeking();
  }
}

void MediaPlayerImpl::WhenFlushedAndSeeking() {
  state_ = State::kWaiting;
  DCHECK(target_position_ != kNotSeeking);
  source_->Seek(target_position_, [this]() {
    target_position_ = kNotSeeking;
    state_ = State::kPaused;
    Update();
  });
}

void MediaPlayerImpl::ChangeSinkStates(MediaState media_state) {
  for (auto& stream : streams_) {
    if (stream->enabled_) {
      if (media_state == MediaState::PAUSED) {
        stream->sink_->Pause();
      } else {
        stream->sink_->Play();
      }
    }
  }
}

bool MediaPlayerImpl::AllSinksAre(SinkState sink_state) {
  for (auto& stream : streams_) {
    if (stream->enabled_) {
      switch (sink_state) {
        case SinkState::kPaused:
          if (stream->state_ != MediaState::PAUSED) {
            return false;
          }
          break;
        case SinkState::kPlaying:
          if (stream->state_ != MediaState::PLAYING) {
            return false;
          }
          break;
        case SinkState::kEnded:
          if (stream->state_ != MediaState::ENDED) {
            return false;
          }
          break;
        case SinkState::kPausedOrEnded:
          if (stream->state_ != MediaState::PAUSED &&
              stream->state_ != MediaState::ENDED) {
            return false;
          }
          break;
        case SinkState::kPlayingOrEnded:
          if (stream->state_ != MediaState::PLAYING &&
              stream->state_ != MediaState::ENDED) {
            return false;
          }
          break;
      }
    }
  }

  return true;
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
  target_state_ = MediaState::PLAYING;
  Update();
}

void MediaPlayerImpl::Pause() {
  target_state_ = MediaState::PAUSED;
  Update();
}

void MediaPlayerImpl::Seek(int64_t position) {
  target_position_ = position;
  Update();
}

void MediaPlayerImpl::PrepareStream(const std::unique_ptr<Stream>& stream,
                                    const String& url,
                                    const std::function<void()>& callback) {
  DCHECK(factory_);

  source_->GetProducer(stream->descriptor_->index,
                       GetProxy(&stream->encoded_producer_));

  if (stream->descriptor_->media_type->scheme ==
      MediaTypeScheme::COMPRESSED_AUDIO) {
    std::shared_ptr<CallbackJoiner> callback_joiner = CallbackJoiner::Create();

    // Compressed audio. Insert a decoder in front of the sink. The sink would
    // add its own internal decoder, but we want to test the decoder.
    factory_->CreateDecoder(stream->descriptor_->media_type.Clone(),
                            GetProxy(&stream->decoder_));

    MediaConsumerPtr decoder_consumer;
    stream->decoder_->GetConsumer(GetProxy(&decoder_consumer));

    callback_joiner->Spawn();
    stream->encoded_producer_->Connect(decoder_consumer.Pass(),
                                       [&stream, callback_joiner]() {
                                         stream->encoded_producer_.reset();
                                         callback_joiner->Complete();
                                       });

    callback_joiner->Spawn();
    stream->decoder_->GetOutputType(
        [this, &stream, url, callback_joiner](MediaTypePtr output_type) {
          stream->decoder_->GetProducer(GetProxy(&stream->decoded_producer_));
          CreateSink(stream, output_type, url, callback_joiner->NewCallback());
          callback_joiner->Complete();
        });

    callback_joiner->WhenJoined(callback);
  } else {
    // Uncompressed audio. Connect the source stream directly to the sink. This
    // would work for compressed audio as well (the sink would decode), but we
    // want to test the decoder.
    DCHECK(stream->descriptor_->media_type->scheme == MediaTypeScheme::LPCM);
    stream->decoded_producer_ = stream->encoded_producer_.Pass();
    CreateSink(stream, stream->descriptor_->media_type, url, callback);
  }
}

void MediaPlayerImpl::CreateSink(const std::unique_ptr<Stream>& stream,
                                 const MediaTypePtr& input_media_type,
                                 const String& url,
                                 const std::function<void()>& callback) {
  DCHECK(input_media_type);
  DCHECK(stream->decoded_producer_);
  DCHECK(factory_);

  factory_->CreateSink(url, input_media_type.Clone(), GetProxy(&stream->sink_));

  MediaConsumerPtr consumer;
  stream->sink_->GetConsumer(GetProxy(&consumer));

  stream->decoded_producer_->Connect(
      consumer.Pass(), [this, callback, &stream]() {
        stream->decoded_producer_.reset();

        DCHECK(stream->state_ == MediaState::UNPREPARED);
        DCHECK(reported_media_state_ == MediaState::UNPREPARED ||
               reported_media_state_ == MediaState::FAULT);

        stream->state_ = MediaState::PAUSED;

        HandleSinkStatusUpdates(stream);

        callback();
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
    stream->state_ = status->state;
    transform_ = status->timeline_transform.Pass();
    StatusUpdated();
    Update();
  }

  stream->sink_->GetStatus(
      version, [this, &stream](uint64_t version, MediaSinkStatusPtr status) {
        HandleSinkStatusUpdates(stream, version, status.Pass());
      });
}

MediaPlayerImpl::Stream::Stream() {}

MediaPlayerImpl::Stream::~Stream() {}

}  // namespace media
}  // namespace mojo
