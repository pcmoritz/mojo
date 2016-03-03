// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_DECODER_BASE_H_
#define SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_DECODER_BASE_H_

#include "services/media/framework/parts/decoder.h"
#include "services/media/framework_ffmpeg/ffmpeg_type_converters.h"
extern "C" {
#include "third_party/ffmpeg/libavcodec/avcodec.h"
}

namespace mojo {
namespace media {

// Abstract base class for ffmpeg-based decoders.
class FfmpegDecoderBase : public Decoder {
 public:
  FfmpegDecoderBase(AvCodecContextPtr av_codec_context);

  ~FfmpegDecoderBase() override;

  // Decoder implementation.
  std::unique_ptr<StreamType> output_stream_type() override;

  // Transform implementation.
  void Flush() override;

  bool TransformPacket(
      const PacketPtr& input,
      bool new_input,
      PayloadAllocator* allocator,
      PacketPtr* output) override;

 protected:
  struct AVFrameDeleter {
    inline void operator()(AVFrame* ptr) const {
      av_frame_free(&ptr);
    }
  };

  // Decodes from av_packet_ into av_frame_. The result indicates how many
  // bytes were consumed from av_packet_. *frame_decoded_out indicates whether
  // av_frame_ contains a complete frame.
  virtual int Decode(PayloadAllocator* allocator, bool* frame_decoded_out) = 0;

  // Creates a Packet from av_frame_.
  virtual PacketPtr CreateOutputPacket(PayloadAllocator* allocator) = 0;

  // Creates an end-of-stream packet with no payload.
  virtual PacketPtr CreateOutputEndOfStreamPacket() = 0;

 protected:
  // The ffmpeg codec context.
  const AvCodecContextPtr& context() {
    return av_codec_context_;
  }

  // Ffmpeg's representation of the input packet.
  const AVPacket& packet() {
    return av_packet_;
  }

  // Ffmpeg's representation of the output packet.
  const std::unique_ptr<AVFrame, AVFrameDeleter>& frame() {
    return av_frame_;
  }

 private:
  // Prepares to process a new input packet.
  void PrepareInputPacket(const PacketPtr& input);

  // Finishes up after processing of an input packet has completed, possibly
  // producing a zero-size end-of-stream packet. Returns true to indicate that
  // a new input packet is required.
  bool UnprepareInputPacket(const PacketPtr& input, PacketPtr* output);

  AvCodecContextPtr av_codec_context_;
  AVPacket av_packet_;
  std::unique_ptr<AVFrame, AVFrameDeleter> av_frame_;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_DECODER_BASE_H_
