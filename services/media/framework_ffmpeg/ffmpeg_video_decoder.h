// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_VIDEO_DECODER_H_
#define SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_VIDEO_DECODER_H_

#include "services/media/framework_ffmpeg/ffmpeg_decoder_base.h"

namespace mojo {
namespace media {

// Decoder implementation employing and ffmpeg video decoder.
// TODO(dalesat): Complete this.
class FfmpegVideoDecoder : public FfmpegDecoderBase {
 public:
  FfmpegVideoDecoder(AvCodecContextPtr av_codec_context);

  ~FfmpegVideoDecoder() override;

 protected:
  // FfmpegDecoderBase overrides.
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
  // Callback used by the ffmpeg decoder to acquire a buffer.
  static int AllocateBufferForAvFrame(
      AVCodecContext* av_codec_context,
      AVFrame* av_frame,
      int flags);

  // Callback used by the ffmpeg decoder to release a buffer.
  static void ReleaseBufferForAvFrame(void* opaque, uint8_t* buffer);

  // AllocateBufferForAvFrame deposits the packet size here, because there's
  // no good evidence of it after avcodec_decode_audio4 completes.
  uint64_t packet_size_;

  // This is used to verify that an allocated buffer is being used as expected
  // by ffmpeg avcodec_decode_audio4. AllocateBufferForAvFrame sets it.
  //void* packet_buffer_;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_VIDEO_DECODER_H_
