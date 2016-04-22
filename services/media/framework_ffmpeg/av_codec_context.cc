// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/types/audio_stream_type.h"
#include "services/media/framework/types/subpicture_stream_type.h"
#include "services/media/framework/types/text_stream_type.h"
#include "services/media/framework/types/video_stream_type.h"
#include "services/media/framework_ffmpeg/av_codec_context.h"
#include "services/media/framework_ffmpeg/ffmpeg_init.h"
extern "C" {
#include "third_party/ffmpeg/libavformat/avformat.h"
}

// Ffmeg defines this...undefine.
#undef PixelFormat

namespace mojo {
namespace media {

namespace {

// Converts an AVSampleFormat into an AudioStreamType::SampleFormat.
AudioStreamType::SampleFormat Convert(AVSampleFormat av_sample_format) {
  switch (av_sample_format) {
    case AV_SAMPLE_FMT_U8:
    case AV_SAMPLE_FMT_U8P:
      return AudioStreamType::SampleFormat::kUnsigned8;
    case AV_SAMPLE_FMT_S16:
    case AV_SAMPLE_FMT_S16P:
      return AudioStreamType::SampleFormat::kSigned16;
    case AV_SAMPLE_FMT_S32:
    case AV_SAMPLE_FMT_S32P:
      return AudioStreamType::SampleFormat::kSigned24In32;
    case AV_SAMPLE_FMT_FLT:
    case AV_SAMPLE_FMT_FLTP:
      return AudioStreamType::SampleFormat::kFloat;
    case AV_SAMPLE_FMT_NONE:
    case AV_SAMPLE_FMT_DBL:
    case AV_SAMPLE_FMT_DBLP:
    case AV_SAMPLE_FMT_NB:
    default:
      LOG(ERROR) << "unsupported av_sample_format " << av_sample_format;
      abort();
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
  return AudioStreamType::Create(StreamType::kAudioEncodingLpcm, nullptr,
                                 Convert(from.sample_fmt), from.channels,
                                 from.sample_rate);
}

// Creates a StreamType from an AVCodecContext describing a compressed audio
// type.
std::unique_ptr<StreamType> StreamTypeFromCompressedAudioCodecContext(
    const AVCodecContext& from) {
  const char* encoding;
  switch (from.codec_id) {
    case CODEC_ID_VORBIS:
      encoding = StreamType::kAudioEncodingVorbis;
      break;
    default:
      LOG(ERROR) << "unsupported codec_id " << from.codec_id;
      abort();
  }

  return AudioStreamType::Create(
      encoding, from.extradata_size == 0
                    ? nullptr
                    : Bytes::Create(from.extradata, from.extradata_size),
      Convert(from.sample_fmt), from.channels, from.sample_rate);
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
  const char* encoding;
  switch (from.codec_id) {
    case AV_CODEC_ID_THEORA:
      encoding = StreamType::kVideoEncodingTheora;
      break;
    default:
      LOG(ERROR) << "unsupported codec_id " << from.codec_id;
      abort();
  }

  return VideoStreamType::Create(
      encoding, from.extradata_size == 0
                    ? nullptr
                    : Bytes::Create(from.extradata, from.extradata_size),
      VideoStreamType::VideoProfile::kNotApplicable,
      PixelFormatFromAVPixelFormat(from.pix_fmt),
      ColorSpaceFromAVColorSpaceAndRange(from.colorspace, from.color_range),
      from.width, from.height, from.coded_width, from.coded_height);
}

// Creates a StreamType from an AVCodecContext describing a data type.
std::unique_ptr<StreamType> StreamTypeFromDataCodecContext(
    const AVCodecContext& from) {
  // TODO(dalesat): Implement.
  LOG(ERROR) << "StreamTypeFromDataCodecContext not implemented";
  abort();
}

// Creates a StreamType from an AVCodecContext describing a subtitle type.
std::unique_ptr<StreamType> StreamTypeFromSubtitleCodecContext(
    const AVCodecContext& from) {
  // TODO(dalesat): Implement.
  LOG(ERROR) << "StreamTypeFromSubtitleCodecContext not implemented";
  abort();
}

// Creates an AVCodecContext from an AudioStreamType.
AvCodecContextPtr AVCodecContextFromAudioStreamType(
    const AudioStreamType& stream_type) {
  DCHECK(stream_type.medium() == StreamType::Medium::kAudio);

  AVCodecID codec_id;
  AVSampleFormat sample_format;

  if (stream_type.encoding() == StreamType::kAudioEncodingLpcm) {
    switch (stream_type.sample_format()) {
      case AudioStreamType::SampleFormat::kUnsigned8:
        codec_id = AV_CODEC_ID_PCM_U8;
        sample_format = AV_SAMPLE_FMT_U8;
        break;
      case AudioStreamType::SampleFormat::kSigned16:
        codec_id = AV_CODEC_ID_PCM_S16LE;
        sample_format = AV_SAMPLE_FMT_S16;
        break;
      case AudioStreamType::SampleFormat::kSigned24In32:
        codec_id = AV_CODEC_ID_PCM_S24LE;
        sample_format = AV_SAMPLE_FMT_S32;
        break;
      case AudioStreamType::SampleFormat::kFloat:
        codec_id = AV_CODEC_ID_PCM_F32LE;
        sample_format = AV_SAMPLE_FMT_FLT;
        break;
      default:
        LOG(ERROR) << "unsupported sample format";
        abort();
    }
  } else if (stream_type.encoding() == StreamType::kAudioEncodingVorbis) {
    codec_id = AV_CODEC_ID_VORBIS;
    sample_format = AV_SAMPLE_FMT_S16;
  } else {
    LOG(ERROR) << "unsupported encoding " << stream_type.encoding();
    abort();
  }

  AvCodecContextPtr context(avcodec_alloc_context3(nullptr));

  context->codec_type = AVMEDIA_TYPE_AUDIO;
  context->codec_id = codec_id;
  context->sample_fmt = sample_format;
  context->channels = stream_type.channels();
  context->sample_rate = stream_type.frames_per_second();

  if (stream_type.encoding_parameters()) {
    ExtraDataFromBytes(*stream_type.encoding_parameters(), context);
  }

  return context;
}

// Creats an AVCodecContext from a VideoStreamType.
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

  if (stream_type.encoding_parameters()) {
    ExtraDataFromBytes(*stream_type.encoding_parameters(), context);
  }

  return context;
}

// Creats an AVCodecContext from a TextStreamType.
AvCodecContextPtr AVCodecContextFromTextStreamType(
    const TextStreamType& stream_type) {
  // TODO(dalesat): Implement.
  LOG(ERROR) << "AVCodecContextFromTextStreamType not implemented";
  abort();
}

// Creats an AVCodecContext from a SubpictureStreamType.
AvCodecContextPtr AVCodecContextFromSubpictureStreamType(
    const SubpictureStreamType& stream_type) {
  // TODO(dalesat): Implement.
  LOG(ERROR) << "AVCodecContextFromSupictureStreamType not implemented";
  abort();
}

}  // namespace

// static
std::unique_ptr<StreamType> AvCodecContext::GetStreamType(
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
      LOG(ERROR) << "unsupported code type " << from.codec_type;
      abort();
  }
}

// static
AvCodecContextPtr AvCodecContext::Create(const StreamType& stream_type) {
  InitFfmpeg();

  switch (stream_type.medium()) {
    case StreamType::Medium::kAudio:
      return AVCodecContextFromAudioStreamType(*stream_type.audio());
    case StreamType::Medium::kVideo:
      return AVCodecContextFromVideoStreamType(*stream_type.video());
    case StreamType::Medium::kText:
      return AVCodecContextFromTextStreamType(*stream_type.text());
    case StreamType::Medium::kSubpicture:
      return AVCodecContextFromSubpictureStreamType(*stream_type.subpicture());
    default:
      return nullptr;
  }
}

}  // namespace media
}  // namespace mojo
