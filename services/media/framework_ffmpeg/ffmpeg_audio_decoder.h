// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_AUDIO_DECODER_H_
#define SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_AUDIO_DECODER_H_

#include "services/media/framework/lpcm_util.h"
#include "services/media/framework_ffmpeg/ffmpeg_decoder_base.h"

namespace mojo {
namespace media {

// Decoder implementation employing an ffmpeg audio decoder.
class FfmpegAudioDecoder : public FfmpegDecoderBase {
 public:
  FfmpegAudioDecoder(AvCodecContextPtr av_codec_context);

  ~FfmpegAudioDecoder() override;

 protected:
  // FfmpegDecoderBase overrides.
  void Flush() override;

  int Decode(
      const AVPacket& av_packet,
      const AvFramePtr& av_frame_ptr,
      PayloadAllocator* allocator,
      bool* frame_decoded_out) override;

  PacketPtr CreateOutputPacket(
      const AVFrame& av_frame,
      PayloadAllocator* allocator) override;

  PacketPtr CreateOutputEndOfStreamPacket() override;

 private:
  // Used to control deallocation of buffers.
  class AvBufferContext {
   public:
    AvBufferContext(size_t size, PayloadAllocator* allocator) :
        size_(size),
        allocator_(allocator) {
      DCHECK(allocator_);
      if (size_ == 0) {
        buffer_ = nullptr;
      } else {
        buffer_ = static_cast<uint8_t*>(
            allocator_->AllocatePayloadBuffer(size_));
      }
    }

    ~AvBufferContext() {
      if (allocator_ == nullptr) {
        // Previously released.
        return;
      }

      if (size_ != 0) {
        DCHECK(buffer_ != nullptr);
        allocator_->ReleasePayloadBuffer(size_, buffer_);
        return;
      }

      DCHECK(buffer_ == nullptr);
    }

    uint8_t* buffer() { return buffer_; }

    size_t size() { return size_; }

    // Releases ownership of the buffer.
    uint8_t* Release() {
      DCHECK(allocator_) << "AvBufferContext released twice";
      uint8_t* result = buffer_;
      buffer_ = nullptr;
      size_ = 0;
      allocator_ = nullptr;
      return result;
    }

   private:
    uint8_t* buffer_;
    size_t size_;
    PayloadAllocator* allocator_;
  };

  // Align sample buffers on 32-byte boundaries. This is the value that Chromium
  // uses and is supposed to work for all processor architectures. Strangely, if
  // we were to tell ffmpeg to use the default (by passing 0), it aligns on 32
  // sample (not byte) boundaries.
  static const int kChannelAlign = 32;

  // Callback used by the ffmpeg decoder to acquire a buffer.
  static int AllocateBufferForAvFrame(
      AVCodecContext* av_codec_context,
      AVFrame* av_frame,
      int flags);

  // Callback used by the ffmpeg decoder to release a buffer.
  static void ReleaseBufferForAvFrame(void* opaque, uint8_t* buffer);

  // The allocator used by avcodec_decode_audio4 to provide context for
  // AllocateBufferForAvFrame. This is set only during the call to
  // avcodec_decode_audio4.
  PayloadAllocator* allocator_;

  // For interleaving, if needed.
  std::unique_ptr<LpcmUtil> lpcm_util_;

  // For interleaving, if needed.
  std::unique_ptr<StreamType> stream_type_;

  // Used to supply missing PTS.
  int64_t next_presentation_time_= Packet::kUnknownPresentationTime;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_AUDIO_DECODER_H_
