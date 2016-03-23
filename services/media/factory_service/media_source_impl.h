// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_MEDIA_SOURCE_IMPL_H_
#define MOJO_SERVICES_MEDIA_FACTORY_MEDIA_SOURCE_IMPL_H_

#include <vector>

#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/media/control/interfaces/media_source.mojom.h"
#include "services/media/factory_service/factory_service.h"
#include "services/media/framework/graph.h"
#include "services/media/framework/parts/decoder.h"
#include "services/media/framework/parts/demux.h"
#include "services/media/framework/parts/null_sink.h"
#include "services/media/framework/parts/reader.h"
#include "services/media/framework_mojo/mojo_producer.h"
#include "services/media/framework_mojo/mojo_pull_mode_producer.h"

namespace mojo {
namespace media {

// Mojo agent that produces streams from an origin specified by URL.
class MediaSourceImpl : public MediaFactoryService::Product,
                        public MediaSource {
 public:
  static std::shared_ptr<MediaSourceImpl> Create(
      const String& origin_url,
      const Array<MediaTypeSetPtr>& allowed_media_types,
      InterfaceRequest<MediaSource> request,
      MediaFactoryService* owner);

  ~MediaSourceImpl() override;

  // MediaSource implementation.
  void GetStreams(const GetStreamsCallback& callback) override;

  void GetClockDisposition(
      const GetClockDispositionCallback& callback) override;

  void GetMasterClock(InterfaceRequest<Clock> master_clock) override;

  void SetMasterClock(InterfaceHandle<Clock> master_clock) override;

  void GetProducer(uint32_t stream_index,
                   InterfaceRequest<MediaProducer> producer) override;

  void GetPullModeProducer(
      uint32_t stream_index,
      InterfaceRequest<MediaPullModeProducer> producer) override;

  void GetStatus(uint64_t version_last_seen,
                 const GetStatusCallback& callback) override;

  void Prepare(const PrepareCallback& callback) override;

  void Prime(const PrimeCallback& callback) override;

  void Flush(const FlushCallback& callback) override;

  void Seek(int64_t position, const SeekCallback& callback) override;

 private:
  MediaSourceImpl(const String& origin_url,
                  const Array<MediaTypeSetPtr>& allowed_media_types,
                  InterfaceRequest<MediaSource> request,
                  MediaFactoryService* owner);

  class Stream {
   public:
    Stream(OutputRef output,
           std::unique_ptr<StreamType> stream_type,
           const std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>&
               allowed_stream_types,
           Graph* graph);

    ~Stream();

    // Gets the stream type of the stream.
    MediaTypePtr media_type() const;

    // Gets the original stream type of the stream.
    MediaTypePtr original_media_type() const;

    // Gets the producer.
    void GetProducer(InterfaceRequest<MediaProducer> producer);

    // Gets the pull mode producer.
    void GetPullModeProducer(InterfaceRequest<MediaPullModeProducer> producer);

    // Makes sure the stream has a sink.
    void EnsureSink();

    // Tells the producer to prime its connection.
    void PrimeConnection(const MojoProducer::PrimeConnectionCallback callback);

    // Tells the producer to flush its connection.
    void FlushConnection(const MojoProducer::FlushConnectionCallback callback);

   private:
    std::unique_ptr<StreamType> stream_type_;
    std::unique_ptr<StreamType> original_stream_type_;
    Graph* graph_;
    OutputRef output_;
    std::shared_ptr<MojoProducer> producer_;
    std::shared_ptr<MojoPullModeProducer> pull_mode_producer_;
    std::shared_ptr<NullSink> null_sink_;
  };

  // Increments the status version and runs pending status request callbacks.
  void StatusUpdated();

  // Runs status request callback.
  void RunStatusCallback(const GetStatusCallback& callback) const;

  Binding<MediaSource> binding_;
  Graph graph_;
  PartRef demux_part_;
  std::shared_ptr<Reader> reader_;
  std::shared_ptr<Demux> demux_;
  std::vector<std::unique_ptr<Stream>> streams_;
  uint64_t status_version_ = 1;
  MediaState state_ = MediaState::UNPREPARED;
  std::deque<GetStatusCallback> pending_status_requests_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_MEDIA_SOURCE_IMPL_H_
