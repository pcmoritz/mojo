// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/factory_service/media_source_impl.h"
#include "services/media/framework/callback_joiner.h"
#include "services/media/framework/conversion_pipeline_builder.h"
#include "services/media/framework/formatting.h"
#include "services/media/framework/parts/reader.h"
#include "services/media/framework_mojo/mojo_type_conversions.h"
#include "url/gurl.h"

namespace mojo {
namespace media {

// static
std::shared_ptr<MediaSourceImpl> MediaSourceImpl::Create(
    const String& origin_url,
    const Array<MediaTypeSetPtr>& allowed_media_types,
    InterfaceRequest<MediaSource> request,
    MediaFactoryService* owner) {
  return std::shared_ptr<MediaSourceImpl>(new MediaSourceImpl(
      origin_url, allowed_media_types, request.Pass(), owner));
}

MediaSourceImpl::MediaSourceImpl(
    const String& origin_url,
    const Array<MediaTypeSetPtr>& allowed_media_types,
    InterfaceRequest<MediaSource> request,
    MediaFactoryService* owner)
    : MediaFactoryService::Product(owner), binding_(this, request.Pass()) {
  DCHECK(origin_url);

  // Go away when the client is no longer connected.
  binding_.set_connection_error_handler([this]() { ReleaseFromOwner(); });

  GURL gurl = GURL(origin_url);

  // TODO(dalesat): Support mojo urls for capture scenarios.

  Result result = Reader::Create(gurl, &reader_);
  if (result != Result::kOk) {
    NOTREACHED() << "couldn't create reader: " << result;
    state_ = MediaState::FAULT;
    return;
  }

  result = Demux::Create(reader_, &demux_);
  if (result != Result::kOk) {
    NOTREACHED() << "couldn't create demux: " << result;
    state_ = MediaState::FAULT;
    return;
  }

  demux_part_ = graph_.Add(demux_);

  auto demux_streams = demux_->streams();
  for (auto demux_stream : demux_streams) {
    streams_.push_back(std::unique_ptr<Stream>(new Stream(
        demux_part_.output(demux_stream->index()), demux_stream->stream_type(),
        Convert(allowed_media_types), &graph_)));
  }
}

MediaSourceImpl::~MediaSourceImpl() {}

void MediaSourceImpl::GetStreams(const GetStreamsCallback& callback) {
  auto result = Array<MediaSourceStreamDescriptorPtr>::New(streams_.size());
  for (size_t i = 0; i < streams_.size(); i++) {
    MediaSourceStreamDescriptorPtr descriptor =
        MediaSourceStreamDescriptor::New();
    descriptor->index = i;
    descriptor->media_type = streams_[i]->media_type();
    descriptor->original_media_type = streams_[i]->original_media_type();
    result[i] = descriptor.Pass();
  }
  callback.Run(result.Pass());
}

void MediaSourceImpl::GetClockDisposition(
    const GetClockDispositionCallback& callback) {
  callback.Run(ClockDisposition::PASSIVE);
  // TODO(dalesat): Varies by origin type.
}

void MediaSourceImpl::GetMasterClock(InterfaceRequest<Clock> master_clock) {
  // TODO(dalesat): Produce master clock as appropriate.
}

void MediaSourceImpl::SetMasterClock(InterfaceHandle<Clock> master_clock) {
  // TODO(dalesat): Is this needed?
}

void MediaSourceImpl::GetProducer(uint32_t stream_index,
                                  InterfaceRequest<MediaProducer> producer) {
  if (stream_index >= streams_.size()) {
    return;
  }

  streams_[stream_index]->GetProducer(producer.Pass());
}

void MediaSourceImpl::GetPullModeProducer(
    uint32_t stream_index,
    InterfaceRequest<MediaPullModeProducer> producer) {
  if (stream_index >= streams_.size()) {
    return;
  }

  streams_[stream_index]->GetPullModeProducer(producer.Pass());
}

void MediaSourceImpl::GetStatus(uint64_t version_last_seen,
                                const GetStatusCallback& callback) {
  if (version_last_seen < status_version_) {
    RunStatusCallback(callback);
  } else {
    pending_status_requests_.push_back(callback);
  }
}

void MediaSourceImpl::Prepare(const PrepareCallback& callback) {
  for (auto& stream : streams_) {
    stream->EnsureSink();
  }
  graph_.Prepare();
  state_ = MediaState::PAUSED;
  callback.Run();
  StatusUpdated();
}

void MediaSourceImpl::Prime(const PrimeCallback& callback) {
  std::shared_ptr<CallbackJoiner> callback_joiner = CallbackJoiner::Create();

  for (auto& stream : streams_) {
    stream->PrimeConnection(callback_joiner->NewCallback());
  }

  callback_joiner->WhenJoined(callback);
}

void MediaSourceImpl::Flush(const FlushCallback& callback) {
  graph_.FlushAllOutputs(demux_part_);

  std::shared_ptr<CallbackJoiner> callback_joiner = CallbackJoiner::Create();

  for (auto& stream : streams_) {
    stream->FlushConnection(callback_joiner->NewCallback());
  }

  callback_joiner->WhenJoined(callback);
}

void MediaSourceImpl::Seek(int64_t position, const FlushCallback& callback) {
  demux_->Seek(position);
  callback.Run();
}

void MediaSourceImpl::StatusUpdated() {
  ++status_version_;
  while (!pending_status_requests_.empty()) {
    RunStatusCallback(pending_status_requests_.front());
    pending_status_requests_.pop_front();
  }
}

void MediaSourceImpl::RunStatusCallback(
    const GetStatusCallback& callback) const {
  MediaSourceStatusPtr status = MediaSourceStatus::New();
  status->state = state_;
  status->metadata = demux_ ? Convert(demux_->metadata()) : nullptr;
  callback.Run(status_version_, status.Pass());
}

MediaSourceImpl::Stream::Stream(
    OutputRef output,
    std::unique_ptr<StreamType> stream_type,
    const std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>&
        allowed_stream_types,
    Graph* graph)
    : original_stream_type_(std::move(stream_type)), graph_(graph) {
  DCHECK(original_stream_type_);
  DCHECK(graph);

  output_ = output;

  if (allowed_stream_types == nullptr) {
    // No conversion requested.
    stream_type_ = SafeClone(original_stream_type_);
  } else if (!BuildConversionPipeline(*original_stream_type_,
                                      *allowed_stream_types, graph, &output_,
                                      &stream_type_)) {
    // Can't convert to any allowed type.
    stream_type_ = StreamType::Create(StreamType::Scheme::kNone);
  }
}

MediaSourceImpl::Stream::~Stream() {}

MediaTypePtr MediaSourceImpl::Stream::media_type() const {
  return Convert(stream_type_);
}

MediaTypePtr MediaSourceImpl::Stream::original_media_type() const {
  return Convert(original_stream_type_);
}

void MediaSourceImpl::Stream::GetProducer(
    InterfaceRequest<MediaProducer> producer) {
  if (pull_mode_producer_) {
    // Can't have both push mode and pull mode producers.
    return;
  }

  if (!producer_) {
    producer_ = MojoProducer::Create();
    graph_->ConnectOutputToPart(output_, graph_->Add(producer_));
  }

  producer_->AddBinding(producer.Pass());
}

void MediaSourceImpl::Stream::GetPullModeProducer(
    InterfaceRequest<MediaPullModeProducer> producer) {
  if (producer_) {
    // Can't have both push mode and pull mode producers.
    return;
  }

  if (!pull_mode_producer_) {
    pull_mode_producer_ = MojoPullModeProducer::Create();
    graph_->ConnectOutputToPart(output_, graph_->Add(pull_mode_producer_));
  }

  pull_mode_producer_->AddBinding(producer.Pass());
}

void MediaSourceImpl::Stream::EnsureSink() {
  if (producer_ == nullptr && pull_mode_producer_ == nullptr) {
    null_sink_ = NullSink::Create();
    graph_->ConnectOutputToPart(output_, graph_->Add(null_sink_));
  }
}

void MediaSourceImpl::Stream::PrimeConnection(
    const MojoProducer::PrimeConnectionCallback callback) {
  if (producer_ != nullptr) {
    producer_->PrimeConnection(callback);
  } else {
    callback.Run();
  }
}

void MediaSourceImpl::Stream::FlushConnection(
    const MojoProducer::FlushConnectionCallback callback) {
  if (producer_ != nullptr) {
    producer_->FlushConnection(callback);
  } else {
    callback.Run();
  }
}

}  // namespace media
}  // namespace mojo
