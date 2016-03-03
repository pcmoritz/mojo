// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework_ffmpeg/ffmpeg_type_converters.h"
extern "C" {
#include "third_party/ffmpeg/libavformat/avformat.h"
}

// Ffmeg defines this...undefine.
#undef PixelFormat

namespace mojo {
namespace media {

namespace {

// Converts an AVSampleFormat into an LpcmStreamType::SampleFormat.
LpcmStreamType::SampleFormat Convert(AVSampleFormat av_sample_format) {
  switch (av_sample_format) {
    case AV_SAMPLE_FMT_U8:
    case AV_SAMPLE_FMT_U8P:
      return LpcmStreamType::SampleFormat::kUnsigned8;
    case AV_SAMPLE_FMT_S16:
    case AV_SAMPLE_FMT_S16P:
      return LpcmStreamType::SampleFormat::kSigned16;
    case AV_SAMPLE_FMT_S32:
    case AV_SAMPLE_FMT_S32P:
      return LpcmStreamType::SampleFormat::kSigned24In32;
    case AV_SAMPLE_FMT_FLT:
    case AV_SAMPLE_FMT_FLTP:
      return LpcmStreamType::SampleFormat::kFloat;
    case AV_SAMPLE_FMT_NONE:
    case AV_SAMPLE_FMT_DBL:
    case AV_SAMPLE_FMT_DBLP:
    case AV_SAMPLE_FMT_NB:
    default:
      NOTREACHED() << "unsupported av_sample_format " << av_sample_format;
      return LpcmStreamType::SampleFormat::kUnknown;
  }
}

// Copies a buffer from Bytes into context->extradata. The result is malloc'ed
// and must be freed.
void ExtraDataFromBytes(const Bytes& bytes, const AvCodecContextPtr& context) {
  size_t byte_count = bytes.size();
  uint8_t* copy = reinterpret_cast<uint8_t*>(malloc(byte_count));
  std::memcpy(copy, bytes.data(), byte_count);
  context->extradata = copy;
  context->extradata_size = byte_count;
}

// Creates a StreamType from an AVCodecContext describing an LPCM type.
std::unique_ptr<StreamType> StreamTypeFromLpcmCodecContext(
    const AVCodecContext& from) {
  return LpcmStreamType::Create(
      Convert(from.sample_fmt),
      from.channels,
      from.sample_rate);
}

// Creates a StreamType from an AVCodecContext describing a compressed audio
// type.
std::unique_ptr<StreamType>
StreamTypeFromCompressedAudioCodecContext(const AVCodecContext& from) {
  CompressedAudioStreamType::AudioEncoding encoding;
  switch (from.codec_id) {
    case CODEC_ID_VORBIS:
      encoding = CompressedAudioStreamType::AudioEncoding::kVorbis;
      break;
    default:
      encoding = CompressedAudioStreamType::AudioEncoding::kUnknown;
      break;
  }

  return CompressedAudioStreamType::Create(
      encoding,
      Convert(from.sample_fmt),
      from.channels,
      from.sample_rate,
      from.extradata_size == 0 ?
          nullptr :
          Bytes::Create(from.extradata, from.extradata_size));
}

// Converts AVColorSpace and AVColorRange to ColorSpace.
VideoStreamType::ColorSpace ColorSpaceFromAVColorSpaceAndRange(
    AVColorSpace color_space,
    AVColorRange color_range) {
  // TODO(dalesat): Blindly copied from Chromium.
  if (color_range == AVCOL_RANGE_JPEG) {
    return VideoStreamType::ColorSpace::kJpeg;
  }

  switch (color_space) {
    case AVCOL_SPC_UNSPECIFIED:
      return VideoStreamType::ColorSpace::kNotApplicable;
    case AVCOL_SPC_BT709:
      return VideoStreamType::ColorSpace::kHdRec709;
    case AVCOL_SPC_SMPTE170M:
    case AVCOL_SPC_BT470BG:
      return VideoStreamType::ColorSpace::kSdRec601;
    default:
      return VideoStreamType::ColorSpace::kUnknown;
  }
}

// Converts VideoProfile to an ffmpeg profile.
int FfmpegProfileFromVideoProfile(VideoStreamType::VideoProfile video_profile) {
  // TODO(dalesat): Blindly copied from Chromium.
  switch (video_profile) {
    case VideoStreamType::VideoProfile::kH264Baseline:
      return FF_PROFILE_H264_BASELINE;
    case VideoStreamType::VideoProfile::kH264Main:
      return FF_PROFILE_H264_MAIN;
    case VideoStreamType::VideoProfile::kH264Extended:
      return FF_PROFILE_H264_EXTENDED;
    case VideoStreamType::VideoProfile::kH264High:
      return FF_PROFILE_H264_HIGH;
    case VideoStreamType::VideoProfile::kH264High10:
      return FF_PROFILE_H264_HIGH_10;
    case VideoStreamType::VideoProfile::kH264High422:
      return FF_PROFILE_H264_HIGH_422;
    case VideoStreamType::VideoProfile::kH264High444Predictive:
      return FF_PROFILE_H264_HIGH_444_PREDICTIVE;
    case VideoStreamType::VideoProfile::kUnknown:
    case VideoStreamType::VideoProfile::kNotApplicable:
    case VideoStreamType::VideoProfile::kH264ScalableBaseline:
    case VideoStreamType::VideoProfile::kH264ScalableHigh:
    case VideoStreamType::VideoProfile::kH264StereoHigh:
    case VideoStreamType::VideoProfile::kH264MultiviewHigh:
    default:
      return FF_PROFILE_UNKNOWN;
   }
}

// Converts an AVPixelFormat to a PixelFormat.
VideoStreamType::PixelFormat PixelFormatFromAVPixelFormat(
    AVPixelFormat av_pixel_format) {
  // TODO(dalesat): Blindly copied from Chromium.
  switch (av_pixel_format) {
    case AV_PIX_FMT_YUV422P:
    case AV_PIX_FMT_YUVJ422P:
      return VideoStreamType::PixelFormat::kYv16;
    case AV_PIX_FMT_YUV444P:
    case AV_PIX_FMT_YUVJ444P:
      return VideoStreamType::PixelFormat::kYv24;
    case AV_PIX_FMT_YUV420P:
    case AV_PIX_FMT_YUVJ420P:
      return VideoStreamType::PixelFormat::kYv12;
    case AV_PIX_FMT_YUVA420P:
      return VideoStreamType::PixelFormat::kYv12A;
    default:
    return VideoStreamType::PixelFormat::kUnknown;
  }
}

// Converts a PixelFormat to an AVPixelFormat.
AVPixelFormat AVPixelFormatFromPixelFormat(
    VideoStreamType::PixelFormat pixel_format) {
  // TODO(dalesat): Blindly copied from Chromium.
  switch (pixel_format) {
    case VideoStreamType::PixelFormat::kYv12:
      return AV_PIX_FMT_YUV420P;
    case VideoStreamType::PixelFormat::kYv16:
      return AV_PIX_FMT_YUV422P;
    case VideoStreamType::PixelFormat::kYv12A:
      return AV_PIX_FMT_YUVA420P;
    case VideoStreamType::PixelFormat::kYv24:
      return AV_PIX_FMT_YUV444P;
    case VideoStreamType::PixelFormat::kUnknown:
    case VideoStreamType::PixelFormat::kI420:
    case VideoStreamType::PixelFormat::kNv12:
    case VideoStreamType::PixelFormat::kNv21:
    case VideoStreamType::PixelFormat::kUyvy:
    case VideoStreamType::PixelFormat::kYuy2:
    case VideoStreamType::PixelFormat::kArgb:
    case VideoStreamType::PixelFormat::kXrgb:
    case VideoStreamType::PixelFormat::kRgb24:
    case VideoStreamType::PixelFormat::kRgb32:
    case VideoStreamType::PixelFormat::kMjpeg:
    case VideoStreamType::PixelFormat::kMt21:
    default:
      return AV_PIX_FMT_NONE;
  }
}

// Creates a StreamType from an AVCodecContext describing a video type.
std::unique_ptr<StreamType> StreamTypeFromVideoCodecContext(
    const AVCodecContext& from) {
  VideoStreamType::VideoEncoding encoding;
  switch (from.codec_id) {
    case AV_CODEC_ID_THEORA :
      encoding = VideoStreamType::VideoEncoding::kTheora;
      break;
    case CODEC_ID_VP8:
      encoding = VideoStreamType::VideoEncoding::kVp8;
      break;
    default:
      encoding = VideoStreamType::VideoEncoding::kUnknown;
      break;
  }

  return VideoStreamType::Create(
      encoding,
      VideoStreamType::VideoProfile::kNotApplicable,
      PixelFormatFromAVPixelFormat(from.pix_fmt),
      ColorSpaceFromAVColorSpaceAndRange(from.colorspace, from.color_range),
      from.width,
      from.height,
      from.coded_width,
      from.coded_height,
      from.extradata_size == 0 ?
          nullptr :
          Bytes::Create(from.extradata, from.extradata_size));
}

// Creates a StreamType from an AVCodecContext describing a data type.
std::unique_ptr<StreamType> StreamTypeFromDataCodecContext(
    const AVCodecContext& from) {
  // TODO(dalesat): Implement.
  return StreamType::Create(StreamType::Scheme::kUnknown);
}

// Creates a StreamType from an AVCodecContext describing a subtitle type.
std::unique_ptr<StreamType> StreamTypeFromSubtitleCodecContext(
    const AVCodecContext& from) {
  // TODO(dalesat): Implement.
  return StreamType::Create(StreamType::Scheme::kUnknown);
}

// Creates an AVCodecContext from LpcmStreamType.
AvCodecContextPtr CodecContextFromLpcmDetails(
    const LpcmStreamType& stream_type) {
  AVCodecID codec_id;
  AVSampleFormat sample_format;

  switch (stream_type.sample_format()) {
    case LpcmStreamType::SampleFormat::kUnsigned8:
      codec_id = AV_CODEC_ID_PCM_U8;
      sample_format = AV_SAMPLE_FMT_U8;
      break;
    case LpcmStreamType::SampleFormat::kSigned16:
      codec_id = AV_CODEC_ID_PCM_S16LE;
      sample_format = AV_SAMPLE_FMT_S16;
      break;
    case LpcmStreamType::SampleFormat::kSigned24In32:
      codec_id = AV_CODEC_ID_PCM_S24LE;
      sample_format = AV_SAMPLE_FMT_S32;
      break;
    case LpcmStreamType::SampleFormat::kFloat:
      codec_id = AV_CODEC_ID_PCM_F32LE;
      sample_format = AV_SAMPLE_FMT_FLT;
      break;
    default:
      return nullptr;
  }

  AvCodecContextPtr context(avcodec_alloc_context3(nullptr));

  context->codec_type = AVMEDIA_TYPE_AUDIO;
  context->codec_id = codec_id;
  context->sample_fmt = sample_format;
  context->channels = stream_type.channels();
  context->sample_rate = stream_type.frames_per_second();

  return context;
}

// Creates an AVCodecContext from CompressedAudioStreamType.
AvCodecContextPtr AVCodecContextFromCompressedAudioStreamType(
    const CompressedAudioStreamType& stream_type) {
  AVCodecID codec_id = AV_CODEC_ID_NONE;
  AVSampleFormat sample_format;

  switch (stream_type.encoding()) {
    case CompressedAudioStreamType::AudioEncoding::kVorbis:
      codec_id = AV_CODEC_ID_VORBIS;
      sample_format = AV_SAMPLE_FMT_S16;
      break;
    default:
      return nullptr;
  }

  if (codec_id == AV_CODEC_ID_NONE) {
    return nullptr;
  }

  AvCodecContextPtr context(avcodec_alloc_context3(nullptr));

  context->codec_type = AVMEDIA_TYPE_AUDIO;
  context->codec_id = codec_id;
  context->sample_fmt = sample_format;
  context->channels = stream_type.channels();
  context->sample_rate = stream_type.frames_per_second();

  if (stream_type.encoding_details()) {
    ExtraDataFromBytes(*stream_type.encoding_details(), context);
  }

  return context;
}

// Creats an AVCodecContext from VideoStreamTypeDetails.
AvCodecContextPtr AVCodecContextFromVideoStreamType(
    const VideoStreamType& stream_type) {
  AVCodecID codec_id = AV_CODEC_ID_NONE;

  // TODO(dalesat): codec_id

  if (codec_id == AV_CODEC_ID_NONE) {
    return nullptr;
  }

  AvCodecContextPtr context(avcodec_alloc_context3(nullptr));

  context->codec_type = AVMEDIA_TYPE_VIDEO;
  context->codec_id = codec_id;
  context->profile = FfmpegProfileFromVideoProfile(stream_type.profile());
  context->pix_fmt = AVPixelFormatFromPixelFormat(stream_type.pixel_format());
  if (stream_type.color_space() == VideoStreamType::ColorSpace::kJpeg) {
    context->color_range = AVCOL_RANGE_JPEG;
  }
  context->coded_width = stream_type.coded_width();
  context->coded_height = stream_type.coded_height();

  if (stream_type.encoding_details()) {
    ExtraDataFromBytes(*stream_type.encoding_details(), context);
  }

  return context;
}

}  // namespace

std::unique_ptr<StreamType> StreamTypeFromAVCodecContext(
    const AVCodecContext& from) {
  switch (from.codec_type) {
    case AVMEDIA_TYPE_AUDIO:
      switch (from.codec_id) {
        case CODEC_ID_PCM_S16BE:
        case CODEC_ID_PCM_S16LE:
        case CODEC_ID_PCM_S24BE:
        case CODEC_ID_PCM_S24LE:
        case CODEC_ID_PCM_U8:
          return StreamTypeFromLpcmCodecContext(from);
        default:
          if (from.codec == nullptr) {
            return StreamTypeFromCompressedAudioCodecContext(from);
          } else {
            return StreamTypeFromLpcmCodecContext(from);
          }
      }
    case AVMEDIA_TYPE_VIDEO:
      return StreamTypeFromVideoCodecContext(from);
    case AVMEDIA_TYPE_UNKNOWN:
      // Treated as AVMEDIA_TYPE_DATA.
    case AVMEDIA_TYPE_DATA:
      return StreamTypeFromDataCodecContext(from);
    case AVMEDIA_TYPE_SUBTITLE:
      return StreamTypeFromSubtitleCodecContext(from);
    case AVMEDIA_TYPE_ATTACHMENT:
    case AVMEDIA_TYPE_NB:
    default:
      return StreamType::Create(StreamType::Scheme::kUnknown);
  }
}

AvCodecContextPtr AVCodecContextFromStreamType(const StreamType& stream_type) {
  switch (stream_type.scheme()) {
    case StreamType::Scheme::kLpcm:
      return CodecContextFromLpcmDetails(*stream_type.lpcm());
    case StreamType::Scheme::kCompressedAudio:
      return AVCodecContextFromCompressedAudioStreamType(
          *stream_type.compressed_audio());
    case StreamType::Scheme::kVideo:
      return AVCodecContextFromVideoStreamType(*stream_type.video());
    default:
      return nullptr;
  }
}

} // namespace media
} // namespace mojo
