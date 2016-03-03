// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework_ffmpeg/ffmpeg_video_decoder.h"

namespace mojo {
namespace media {

FfmpegVideoDecoder::FfmpegVideoDecoder(AvCodecContextPtr av_codec_context) :
    FfmpegDecoderBase(std::move(av_codec_context)) {
  DCHECK(context());
}

FfmpegVideoDecoder::~FfmpegVideoDecoder() {}

int FfmpegVideoDecoder::Decode(
    PayloadAllocator* allocator,
    bool* frame_decoded_out) {
  DCHECK(allocator);
  DCHECK(frame_decoded_out);
  DCHECK(context());
  DCHECK(frame());

  int frame_decoded = 0;
  int input_bytes_used = avcodec_decode_video2(
    context().get(),
    frame().get(),
    &frame_decoded,
    &packet());
  *frame_decoded_out = frame_decoded != 0;
  return input_bytes_used;
}

PacketPtr FfmpegVideoDecoder::CreateOutputPacket(PayloadAllocator* allocator) {
  DCHECK(allocator);
  DCHECK(frame());

  // End of stream is indicated when we're draining and produce no packet.
  // TODO(dalesat): This is just a copy of the audio version.
  return Packet::Create(
      frame()->pts,
      frame()->pkt_duration,
      false,
      packet_size_,
      frame()->data[0],
      allocator);
}

PacketPtr FfmpegVideoDecoder::CreateOutputEndOfStreamPacket() {
  // TODO(dalesat): Presentation time for this packet.
  return Packet::CreateEndOfStream(0);
}

int FfmpegVideoDecoder::AllocateBufferForAvFrame(
    AVCodecContext* av_codec_context,
    AVFrame* av_frame,
    int flags) {
  // It's important to use av_codec_context here rather than context(),
  // because av_codec_context is different for different threads when we're
  // decoding on multiple threads. If this code is moved to an instance method,
  // be sure to avoid using context().

  // TODO(dalesat): Not sure why/if this is needed.
  //int result = av_image_check_size(
  //    av_codec_context->width,
  //    av_codec_context->height,
  //    0,
  //    NULL);
  //if (result < 0) {
  //  DCHECK(false) << "av_image_check_size failed";
  //  return result;
  //}

  // TODO(dalesat): Not sure why this is needed.
  int coded_width =
      std::max(av_codec_context->width, av_codec_context->coded_width);
  int coded_height =
      std::max(av_codec_context->height, av_codec_context->coded_height);
  DCHECK_EQ(coded_width, av_codec_context->coded_width) <<
      "coded width is less than width";
  DCHECK_EQ(coded_height, av_codec_context->coded_height) <<
      "coded height is less than height";

  // TODO(dalesat): Fill in av_frame->data and av_frame->data for each plane.

  av_frame->width = coded_width;
  av_frame->height = coded_height;
  av_frame->format = av_codec_context->pix_fmt;
  av_frame->reordered_opaque = av_codec_context->reordered_opaque;

  av_frame->buf[0] = av_buffer_create(
      av_frame->data[0], // Because this is the first chunk in the buffer.
      0, // TODO(dalesat): Provide this.
      ReleaseBufferForAvFrame,
      nullptr, // opaque
      0); // flags

  return 0;
}

void FfmpegVideoDecoder::ReleaseBufferForAvFrame(
  void* opaque, uint8_t* buffer) {
  // Nothing to do.
  // TODO(dalesat): Can we get rid of this method altogether?
}

} // namespace media
} // namespace mojo
