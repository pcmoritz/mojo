// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework_mojo/mojo_type_conversions.h"
#include "third_party/modp_b64/modp_b64.h"

namespace mojo {
namespace media {

StreamType::Scheme Convert(MediaTypeScheme media_type_scheme) {
  switch (media_type_scheme) {
    case MediaTypeScheme::UNKNOWN:
      return StreamType::Scheme::kUnknown;
    case MediaTypeScheme::NONE:
      return StreamType::Scheme::kNone;
    case MediaTypeScheme::ANY_ELEMENTARY:
      return StreamType::Scheme::kAnyElementary;
    case MediaTypeScheme::ANY_AUDIO:
      return StreamType::Scheme::kAnyAudio;
    case MediaTypeScheme::ANY_VIDEO:
      return StreamType::Scheme::kAnyVideo;
    case MediaTypeScheme::ANY_SUBPICTURE:
      return StreamType::Scheme::kAnySubpicture;
    case MediaTypeScheme::ANY_TEXT:
      return StreamType::Scheme::kAnyText;
    case MediaTypeScheme::ANY_MULTIPLEXED:
      return StreamType::Scheme::kAnyMultiplexed;
    case MediaTypeScheme::ANY:
      return StreamType::Scheme::kAny;
    case MediaTypeScheme::MULTIPLEXED:
      return StreamType::Scheme::kMultiplexed;
    case MediaTypeScheme::LPCM:
      return StreamType::Scheme::kLpcm;
    case MediaTypeScheme::COMPRESSED_AUDIO:
      return StreamType::Scheme::kCompressedAudio;
    case MediaTypeScheme::VIDEO:
      return StreamType::Scheme::kVideo;
  }
  return StreamType::Scheme::kUnknown;
}

LpcmStreamType::SampleFormat Convert(LpcmSampleFormat lpcm_sample_format) {
  switch (lpcm_sample_format) {
    case LpcmSampleFormat::UNKNOWN:
      return LpcmStreamType::SampleFormat::kUnknown;
    case LpcmSampleFormat::ANY:
      return LpcmStreamType::SampleFormat::kAny;
    case LpcmSampleFormat::UNSIGNED_8:
      return LpcmStreamType::SampleFormat::kUnsigned8;
    case LpcmSampleFormat::SIGNED_16:
      return LpcmStreamType::SampleFormat::kSigned16;
    case LpcmSampleFormat::SIGNED_24_IN_32:
      return LpcmStreamType::SampleFormat::kSigned24In32;
    case LpcmSampleFormat::FLOAT:
      return LpcmStreamType::SampleFormat::kFloat;
  }
  return LpcmStreamType::SampleFormat::kUnknown;
}

CompressedAudioStreamType::AudioEncoding Convert(AudioEncoding audio_encoding) {
  switch (audio_encoding) {
    case AudioEncoding::UNKNOWN:
      return CompressedAudioStreamType::AudioEncoding::kUnknown;
    case AudioEncoding::ANY:
      return CompressedAudioStreamType::AudioEncoding::kAny;
    case AudioEncoding::VORBIS:
      return CompressedAudioStreamType::AudioEncoding::kVorbis;
  }
  return CompressedAudioStreamType::AudioEncoding::kUnknown;
}

VideoStreamType::VideoEncoding Convert(VideoEncoding video_encoding) {
  switch (video_encoding) {
    case VideoEncoding::UNKNOWN:
      return VideoStreamType::VideoEncoding::kUnknown;
    case VideoEncoding::ANY:
      return VideoStreamType::VideoEncoding::kAny;
    case VideoEncoding::THEORA:
      return VideoStreamType::VideoEncoding::kTheora;
    case VideoEncoding::VP8:
      return VideoStreamType::VideoEncoding::kVp8;
  }
  return VideoStreamType::VideoEncoding::kUnknown;
}

VideoStreamType::VideoProfile Convert(VideoProfile video_profile) {
  switch (video_profile) {
    case VideoProfile::UNKNOWN:
      return VideoStreamType::VideoProfile::kUnknown;
    case VideoProfile::NOT_APPLICABLE:
      return VideoStreamType::VideoProfile::kNotApplicable;
    case VideoProfile::H264_BASELINE:
      return VideoStreamType::VideoProfile::kH264Baseline;
    case VideoProfile::H264_MAIN:
      return VideoStreamType::VideoProfile::kH264Main;
    case VideoProfile::H264_EXTENDED:
      return VideoStreamType::VideoProfile::kH264Extended;
    case VideoProfile::H264_HIGH:
      return VideoStreamType::VideoProfile::kH264High;
    case VideoProfile::H264_HIGH10:
      return VideoStreamType::VideoProfile::kH264High10;
    case VideoProfile::H264_HIGH422:
      return VideoStreamType::VideoProfile::kH264High422;
    case VideoProfile::H264_HIGH444_PREDICTIVE:
      return VideoStreamType::VideoProfile::kH264High444Predictive;
    case VideoProfile::H264_SCALABLE_BASELINE:
      return VideoStreamType::VideoProfile::kH264ScalableBaseline;
    case VideoProfile::H264_SCALABLE_HIGH:
      return VideoStreamType::VideoProfile::kH264ScalableHigh;
    case VideoProfile::H264_STEREO_HIGH:
      return VideoStreamType::VideoProfile::kH264StereoHigh;
    case VideoProfile::H264_MULTIVIEW_HIGH:
      return VideoStreamType::VideoProfile::kH264MultiviewHigh;
  }
  return VideoStreamType::VideoProfile::kUnknown;
}

VideoStreamType::PixelFormat Convert(PixelFormat pixel_format) {
  switch (pixel_format) {
    case PixelFormat::UNKNOWN:
      return VideoStreamType::PixelFormat::kUnknown;
    case PixelFormat::I420:
      return VideoStreamType::PixelFormat::kI420;
    case PixelFormat::YV12:
      return VideoStreamType::PixelFormat::kYv12;
    case PixelFormat::YV16:
      return VideoStreamType::PixelFormat::kYv16;
    case PixelFormat::YV12A:
      return VideoStreamType::PixelFormat::kYv12A;
    case PixelFormat::YV24:
      return VideoStreamType::PixelFormat::kYv24;
    case PixelFormat::NV12:
      return VideoStreamType::PixelFormat::kNv12;
    case PixelFormat::NV21:
      return VideoStreamType::PixelFormat::kNv21;
    case PixelFormat::UYVY:
      return VideoStreamType::PixelFormat::kUyvy;
    case PixelFormat::YUY2:
      return VideoStreamType::PixelFormat::kYuy2;
    case PixelFormat::ARGB:
      return VideoStreamType::PixelFormat::kArgb;
    case PixelFormat::XRGB:
      return VideoStreamType::PixelFormat::kXrgb;
    case PixelFormat::RGB24:
      return VideoStreamType::PixelFormat::kRgb24;
    case PixelFormat::RGB32:
      return VideoStreamType::PixelFormat::kRgb32;
    case PixelFormat::MJPEG:
      return VideoStreamType::PixelFormat::kMjpeg;
    case PixelFormat::MT21:
      return VideoStreamType::PixelFormat::kMt21;
  }
  return VideoStreamType::PixelFormat::kUnknown;
}

VideoStreamType::ColorSpace Convert(ColorSpace color_space) {
  switch (color_space) {
    case ColorSpace::UNKNOWN:
      return VideoStreamType::ColorSpace::kUnknown;
    case ColorSpace::NOT_APPLICABLE:
      return VideoStreamType::ColorSpace::kNotApplicable;
    case ColorSpace::JPEG:
      return VideoStreamType::ColorSpace::kJpeg;
    case ColorSpace::HD_REC709:
      return VideoStreamType::ColorSpace::kHdRec709;
    case ColorSpace::SD_REC601:
      return VideoStreamType::ColorSpace::kSdRec601;
  }
  return VideoStreamType::ColorSpace::kUnknown;
}

std::unique_ptr<StreamType> Convert(const MediaTypePtr& media_type) {
  if (!media_type) {
    return nullptr;
  }

  switch (media_type->scheme) {
    case MediaTypeScheme::MULTIPLEXED:
      return MultiplexedStreamType::Create(
          Convert(media_type->details->get_multiplexed()->multiplex_type),
          Convert(media_type->details->get_multiplexed()->substream_types));
    case MediaTypeScheme::LPCM:
      return LpcmStreamType::Create(
          Convert(media_type->details->get_lpcm()->sample_format),
          media_type->details->get_lpcm()->channels,
          media_type->details->get_lpcm()->frames_per_second);
    case MediaTypeScheme::COMPRESSED_AUDIO:
      return CompressedAudioStreamType::Create(
          Convert(media_type->details->get_compressed_audio()->encoding),
          Convert(media_type->details->get_compressed_audio()->sample_format),
          media_type->details->get_compressed_audio()->channels,
          media_type->details->get_compressed_audio()->frames_per_second,
          Convert(
              media_type->details->get_compressed_audio()->extra_data_base64));
    case MediaTypeScheme::VIDEO:
      return VideoStreamType::Create(
          Convert(media_type->details->get_video()->encoding),
          Convert(media_type->details->get_video()->profile),
          Convert(media_type->details->get_video()->pixel_format),
          Convert(media_type->details->get_video()->color_space),
          media_type->details->get_video()->width,
          media_type->details->get_video()->height,
          media_type->details->get_video()->coded_width,
          media_type->details->get_video()->coded_height,
          Convert(media_type->details->get_video()->extra_data_base64));
    default:
      return StreamType::Create(Convert(media_type->scheme));
  }
  return nullptr;
}

std::unique_ptr<std::vector<std::unique_ptr<StreamType>>> Convert(
    const Array<MediaTypePtr>& media_types) {
  if (!media_types) {
    return nullptr;
  }

  std::unique_ptr<std::vector<std::unique_ptr<StreamType>>> result =
      std::unique_ptr<std::vector<std::unique_ptr<StreamType>>>(
          new std::vector<std::unique_ptr<StreamType>>(media_types.size()));
  for (size_t i = 0; i < media_types.size(); i++) {
    (*result)[i] = Convert(media_types[i]);
  }
  return result;
}

std::unique_ptr<StreamTypeSet> Convert(const MediaTypeSetPtr& media_type_set) {
  if (!media_type_set) {
    return nullptr;
  }

  switch (media_type_set->scheme) {
    case MediaTypeScheme::MULTIPLEXED:
      return MultiplexedStreamTypeSet::Create(
          Convert(
              media_type_set->details->get_multiplexed()->multiplex_type_set),
          Convert(
              media_type_set->details->get_multiplexed()->substream_type_sets));
    case MediaTypeScheme::LPCM:
      return LpcmStreamTypeSet::Create(
          Convert(media_type_set->details->get_lpcm()->sample_format),
          Range<uint32_t>(media_type_set->details->get_lpcm()->min_channels,
                          media_type_set->details->get_lpcm()->max_channels),
          Range<uint32_t>(
              media_type_set->details->get_lpcm()->min_frames_per_second,
              media_type_set->details->get_lpcm()->max_frames_per_second));
    case MediaTypeScheme::COMPRESSED_AUDIO:
      return CompressedAudioStreamTypeSet::Create(
          Convert(media_type_set->details->get_compressed_audio()->encoding),
          Convert(
              media_type_set->details->get_compressed_audio()->sample_format),
          Range<uint32_t>(media_type_set->details->get_lpcm()->min_channels,
                          media_type_set->details->get_lpcm()->max_channels),
          Range<uint32_t>(
              media_type_set->details->get_lpcm()->min_frames_per_second,
              media_type_set->details->get_lpcm()->max_frames_per_second));
    case MediaTypeScheme::VIDEO:
      return VideoStreamTypeSet::Create(
          Convert(media_type_set->details->get_video()->encoding),
          Range<uint32_t>(media_type_set->details->get_video()->min_width,
                          media_type_set->details->get_video()->max_width),
          Range<uint32_t>(media_type_set->details->get_video()->min_height,
                          media_type_set->details->get_video()->max_height));
    default:
      return StreamTypeSet::Create(Convert(media_type_set->scheme));
  }

  return nullptr;
}

std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>> Convert(
    const Array<MediaTypeSetPtr>& media_type_sets) {
  if (!media_type_sets) {
    return nullptr;
  }

  std::vector<std::unique_ptr<StreamTypeSet>>* result =
      new std::vector<std::unique_ptr<StreamTypeSet>>(media_type_sets.size());
  for (size_t i = 0; i < media_type_sets.size(); i++) {
    (*result)[i] = Convert(media_type_sets[i]);
  }
  return std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>(result);
}

std::unique_ptr<Bytes> Convert(const String& base64) {
  if (base64.is_null()) {
    return nullptr;
  }

  size_t base64_size = base64.size();
  size_t byte_count = modp_b64_decode_len(base64_size);
  std::unique_ptr<Bytes> bytes = Bytes::Create(byte_count);

  byte_count = modp_b64_decode(reinterpret_cast<char*>(bytes->data()),
                               base64.data(), base64_size);

  if (byte_count == MODP_B64_ERROR) {
    return nullptr;
  }

  return bytes;
}

std::unique_ptr<Metadata> Convert(const MediaMetadataPtr& media_metadata) {
  if (!media_metadata) {
    return nullptr;
  }

  return Metadata::Create(media_metadata->duration, media_metadata->title,
                          media_metadata->artist, media_metadata->album,
                          media_metadata->publisher, media_metadata->genre,
                          media_metadata->composer);
}

// Creates a MediaTypeScheme from a StreamType::Scheme.
MediaTypeScheme Convert(StreamType::Scheme scheme) {
  switch (scheme) {
    case StreamType::Scheme::kUnknown:
      return MediaTypeScheme::UNKNOWN;
    case StreamType::Scheme::kNone:
      return MediaTypeScheme::NONE;
    case StreamType::Scheme::kAnyElementary:
      return MediaTypeScheme::ANY_ELEMENTARY;
    case StreamType::Scheme::kAnyAudio:
      return MediaTypeScheme::ANY_AUDIO;
    case StreamType::Scheme::kAnyVideo:
      return MediaTypeScheme::ANY_VIDEO;
    case StreamType::Scheme::kAnySubpicture:
      return MediaTypeScheme::ANY_SUBPICTURE;
    case StreamType::Scheme::kAnyText:
      return MediaTypeScheme::ANY_TEXT;
    case StreamType::Scheme::kAnyMultiplexed:
      return MediaTypeScheme::ANY_MULTIPLEXED;
    case StreamType::Scheme::kAny:
      return MediaTypeScheme::ANY;
    case StreamType::Scheme::kMultiplexed:
      return MediaTypeScheme::MULTIPLEXED;
    case StreamType::Scheme::kLpcm:
      return MediaTypeScheme::LPCM;
    case StreamType::Scheme::kCompressedAudio:
      return MediaTypeScheme::COMPRESSED_AUDIO;
    case StreamType::Scheme::kVideo:
      return MediaTypeScheme::VIDEO;
  }

  return MediaTypeScheme::UNKNOWN;
}

// Creates an LpcmSampleFormat from an LpcmStreamType::SampleFormat.
LpcmSampleFormat Convert(LpcmStreamType::SampleFormat sample_format) {
  switch (sample_format) {
    case LpcmStreamType::SampleFormat::kUnknown:
      return LpcmSampleFormat::UNKNOWN;
    case LpcmStreamType::SampleFormat::kAny:
      return LpcmSampleFormat::ANY;
    case LpcmStreamType::SampleFormat::kUnsigned8:
      return LpcmSampleFormat::UNSIGNED_8;
    case LpcmStreamType::SampleFormat::kSigned16:
      return LpcmSampleFormat::SIGNED_16;
    case LpcmStreamType::SampleFormat::kSigned24In32:
      return LpcmSampleFormat::SIGNED_24_IN_32;
    case LpcmStreamType::SampleFormat::kFloat:
      return LpcmSampleFormat::FLOAT;
  }

  return LpcmSampleFormat::UNKNOWN;
}

// Creates an AudioEncoding from a CompressedAudioStreamType::VideoEncoding.
AudioEncoding Convert(CompressedAudioStreamType::AudioEncoding audio_encoding) {
  switch (audio_encoding) {
    case CompressedAudioStreamType::AudioEncoding::kUnknown:
      return AudioEncoding::UNKNOWN;
    case CompressedAudioStreamType::AudioEncoding::kAny:
      return AudioEncoding::ANY;
    case CompressedAudioStreamType::AudioEncoding::kVorbis:
      return AudioEncoding::VORBIS;
  }

  return AudioEncoding::UNKNOWN;
}

// Creates a VideoEncoding from a VideoStreamType::VideoEncoding.
VideoEncoding Convert(VideoStreamType::VideoEncoding video_encoding) {
  switch (video_encoding) {
    case VideoStreamType::VideoEncoding::kUnknown:
      return VideoEncoding::UNKNOWN;
    case VideoStreamType::VideoEncoding::kAny:
      return VideoEncoding::ANY;
    case VideoStreamType::VideoEncoding::kTheora:
      return VideoEncoding::THEORA;
    case VideoStreamType::VideoEncoding::kVp8:
      return VideoEncoding::VP8;
  }

  return VideoEncoding::UNKNOWN;
}

// Creates a VideoProfile from a VideoStreamType::VideoProfile.
VideoProfile Convert(VideoStreamType::VideoProfile video_profile) {
  switch (video_profile) {
    case VideoStreamType::VideoProfile::kUnknown:
      return VideoProfile::UNKNOWN;
    case VideoStreamType::VideoProfile::kNotApplicable:
      return VideoProfile::NOT_APPLICABLE;
    case VideoStreamType::VideoProfile::kH264Baseline:
      return VideoProfile::H264_BASELINE;
    case VideoStreamType::VideoProfile::kH264Main:
      return VideoProfile::H264_MAIN;
    case VideoStreamType::VideoProfile::kH264Extended:
      return VideoProfile::H264_EXTENDED;
    case VideoStreamType::VideoProfile::kH264High:
      return VideoProfile::H264_HIGH;
    case VideoStreamType::VideoProfile::kH264High10:
      return VideoProfile::H264_HIGH10;
    case VideoStreamType::VideoProfile::kH264High422:
      return VideoProfile::H264_HIGH422;
    case VideoStreamType::VideoProfile::kH264High444Predictive:
      return VideoProfile::H264_HIGH444_PREDICTIVE;
    case VideoStreamType::VideoProfile::kH264ScalableBaseline:
      return VideoProfile::H264_SCALABLE_BASELINE;
    case VideoStreamType::VideoProfile::kH264ScalableHigh:
      return VideoProfile::H264_SCALABLE_HIGH;
    case VideoStreamType::VideoProfile::kH264StereoHigh:
      return VideoProfile::H264_STEREO_HIGH;
    case VideoStreamType::VideoProfile::kH264MultiviewHigh:
      return VideoProfile::H264_MULTIVIEW_HIGH;
  }

  return VideoProfile::UNKNOWN;
}

// Creates a PixelFormat from a VideoStreamType::PixelFormat.
PixelFormat Convert(VideoStreamType::PixelFormat pixel_format) {
  switch (pixel_format) {
    case VideoStreamType::PixelFormat::kUnknown:
      return PixelFormat::UNKNOWN;
    case VideoStreamType::PixelFormat::kI420:
      return PixelFormat::I420;
    case VideoStreamType::PixelFormat::kYv12:
      return PixelFormat::YV12;
    case VideoStreamType::PixelFormat::kYv16:
      return PixelFormat::YV16;
    case VideoStreamType::PixelFormat::kYv12A:
      return PixelFormat::YV12A;
    case VideoStreamType::PixelFormat::kYv24:
      return PixelFormat::YV24;
    case VideoStreamType::PixelFormat::kNv12:
      return PixelFormat::NV12;
    case VideoStreamType::PixelFormat::kNv21:
      return PixelFormat::NV21;
    case VideoStreamType::PixelFormat::kUyvy:
      return PixelFormat::UYVY;
    case VideoStreamType::PixelFormat::kYuy2:
      return PixelFormat::YUY2;
    case VideoStreamType::PixelFormat::kArgb:
      return PixelFormat::ARGB;
    case VideoStreamType::PixelFormat::kXrgb:
      return PixelFormat::XRGB;
    case VideoStreamType::PixelFormat::kRgb24:
      return PixelFormat::RGB24;
    case VideoStreamType::PixelFormat::kRgb32:
      return PixelFormat::RGB32;
    case VideoStreamType::PixelFormat::kMjpeg:
      return PixelFormat::MJPEG;
    case VideoStreamType::PixelFormat::kMt21:
      return PixelFormat::MT21;
  }

  return PixelFormat::UNKNOWN;
}

// Creates a ColorSpace from a VideoStreamType::ColorSpace.
ColorSpace Convert(VideoStreamType::ColorSpace color_space) {
  switch (color_space) {
    case VideoStreamType::ColorSpace::kUnknown:
      return ColorSpace::UNKNOWN;
    case VideoStreamType::ColorSpace::kNotApplicable:
      return ColorSpace::NOT_APPLICABLE;
    case VideoStreamType::ColorSpace::kJpeg:
      return ColorSpace::JPEG;
    case VideoStreamType::ColorSpace::kHdRec709:
      return ColorSpace::HD_REC709;
    case VideoStreamType::ColorSpace::kSdRec601:
      return ColorSpace::SD_REC601;
  }

  return ColorSpace::UNKNOWN;
}

// Creates a MediaType from a StreamType.
MediaTypePtr Convert(const std::unique_ptr<StreamType>& stream_type) {
  if (stream_type == nullptr) {
    return nullptr;
  }

  switch (stream_type->scheme()) {
    case StreamType::Scheme::kMultiplexed: {
      MultiplexedMediaTypeDetailsPtr multiplexed_details =
          MultiplexedMediaTypeDetails::New();
      multiplexed_details->multiplex_type =
          Convert(stream_type->multiplexed()->multiplex_type());
      multiplexed_details->substream_types =
          Convert(stream_type->multiplexed()->substream_types());
      MediaTypeDetailsPtr details = MediaTypeDetails::New();
      details->set_multiplexed(multiplexed_details.Pass());
      MediaTypePtr media_type = MediaType::New();
      media_type->scheme = MediaTypeScheme::MULTIPLEXED;
      media_type->details = details.Pass();
      return media_type;
    }
    case StreamType::Scheme::kLpcm: {
      LpcmMediaTypeDetailsPtr lpcm_details = LpcmMediaTypeDetails::New();
      lpcm_details->sample_format =
          Convert(stream_type->lpcm()->sample_format());
      lpcm_details->channels = stream_type->lpcm()->channels();
      lpcm_details->frames_per_second =
          stream_type->lpcm()->frames_per_second();
      MediaTypeDetailsPtr details = MediaTypeDetails::New();
      details->set_lpcm(lpcm_details.Pass());
      MediaTypePtr media_type = MediaType::New();
      media_type->scheme = MediaTypeScheme::LPCM;
      media_type->details = details.Pass();
      return media_type;
    }
    case StreamType::Scheme::kCompressedAudio: {
      CompressedAudioMediaTypeDetailsPtr compressed_audio_details =
          CompressedAudioMediaTypeDetails::New();
      compressed_audio_details->encoding =
          Convert(stream_type->compressed_audio()->encoding());
      compressed_audio_details->sample_format =
          Convert(stream_type->compressed_audio()->sample_format());
      compressed_audio_details->channels =
          stream_type->compressed_audio()->channels();
      compressed_audio_details->frames_per_second =
          stream_type->compressed_audio()->frames_per_second();
      compressed_audio_details->extra_data_base64 =
          Convert(stream_type->compressed_audio()->encoding_details());
      MediaTypeDetailsPtr details = MediaTypeDetails::New();
      details->set_compressed_audio(compressed_audio_details.Pass());
      MediaTypePtr media_type = MediaType::New();
      media_type->scheme = MediaTypeScheme::COMPRESSED_AUDIO;
      media_type->details = details.Pass();
      return media_type;
    }
    case StreamType::Scheme::kVideo: {
      VideoMediaTypeDetailsPtr video_details = VideoMediaTypeDetails::New();
      video_details->encoding = Convert(stream_type->video()->encoding());
      video_details->profile = Convert(stream_type->video()->profile());
      video_details->pixel_format =
          Convert(stream_type->video()->pixel_format());
      video_details->color_space = Convert(stream_type->video()->color_space());
      video_details->width = stream_type->video()->width();
      video_details->height = stream_type->video()->height();
      video_details->coded_width = stream_type->video()->coded_width();
      video_details->coded_height = stream_type->video()->coded_height();
      video_details->extra_data_base64 =
          Convert(stream_type->video()->encoding_details());
      MediaTypeDetailsPtr details = MediaTypeDetails::New();
      details->set_video(video_details.Pass());
      MediaTypePtr media_type = MediaType::New();
      media_type->scheme = MediaTypeScheme::VIDEO;
      media_type->details = details.Pass();
      return media_type;
    }
    default: {
      MediaTypePtr media_type = MediaType::New();
      media_type->scheme = Convert(stream_type->scheme());
      return media_type;
    }
  }
}

// Creates an array of MediaTypes from std::vector<std::unique_ptr<StreamType>>.
Array<MediaTypePtr> Convert(
    const std::unique_ptr<std::vector<std::unique_ptr<StreamType>>>&
        stream_types) {
  if (stream_types == nullptr) {
    return nullptr;
  }

  Array<MediaTypePtr> result = Array<MediaTypePtr>::New(stream_types->size());
  for (const std::unique_ptr<StreamType>& stream_type : *stream_types) {
    result.push_back(Convert(stream_type));
  }
  return result;
}

// Creates a MediaTypeSet from a StreamTypeSet.
MediaTypeSetPtr Convert(const std::unique_ptr<StreamTypeSet>& stream_type_set) {
  if (stream_type_set == nullptr) {
    return nullptr;
  }

  switch (stream_type_set->scheme()) {
    case StreamType::Scheme::kMultiplexed: {
      MultiplexedMediaTypeSetDetailsPtr multiplexed_details =
          MultiplexedMediaTypeSetDetails::New();
      multiplexed_details->multiplex_type_set =
          Convert(stream_type_set->multiplexed()->multiplex_type_set());
      multiplexed_details->substream_type_sets =
          Convert(stream_type_set->multiplexed()->substream_type_sets());
      MediaTypeSetDetailsPtr details = MediaTypeSetDetails::New();
      details->set_multiplexed(multiplexed_details.Pass());
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->scheme = MediaTypeScheme::MULTIPLEXED;
      media_type_set->details = details.Pass();
      return media_type_set;
    }
    case StreamType::Scheme::kLpcm: {
      LpcmMediaTypeSetDetailsPtr lpcm_details = LpcmMediaTypeSetDetails::New();
      lpcm_details->sample_format =
          Convert(stream_type_set->lpcm()->sample_format());
      lpcm_details->min_channels = stream_type_set->lpcm()->channels().min;
      lpcm_details->max_channels = stream_type_set->lpcm()->channels().max;
      lpcm_details->min_frames_per_second =
          stream_type_set->lpcm()->frames_per_second().min;
      lpcm_details->max_frames_per_second =
          stream_type_set->lpcm()->frames_per_second().max;
      MediaTypeSetDetailsPtr details = MediaTypeSetDetails::New();
      details->set_lpcm(lpcm_details.Pass());
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->scheme = MediaTypeScheme::LPCM;
      media_type_set->details = details.Pass();
      return media_type_set;
    }
    case StreamType::Scheme::kCompressedAudio: {
      CompressedAudioMediaTypeSetDetailsPtr compressed_audio_details =
          CompressedAudioMediaTypeSetDetails::New();
      compressed_audio_details->encoding =
          Convert(stream_type_set->compressed_audio()->encoding());
      compressed_audio_details->sample_format =
          Convert(stream_type_set->compressed_audio()->sample_format());
      compressed_audio_details->min_channels =
          stream_type_set->compressed_audio()->channels().min;
      compressed_audio_details->max_channels =
          stream_type_set->compressed_audio()->channels().max;
      compressed_audio_details->min_frames_per_second =
          stream_type_set->compressed_audio()->frames_per_second().min;
      compressed_audio_details->max_frames_per_second =
          stream_type_set->compressed_audio()->frames_per_second().max;
      MediaTypeSetDetailsPtr details = MediaTypeSetDetails::New();
      details->set_compressed_audio(compressed_audio_details.Pass());
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->scheme = MediaTypeScheme::COMPRESSED_AUDIO;
      media_type_set->details = details.Pass();
      return media_type_set;
    }
    case StreamType::Scheme::kVideo: {
      VideoMediaTypeSetDetailsPtr video_details =
          VideoMediaTypeSetDetails::New();
      video_details->encoding = Convert(stream_type_set->video()->encoding());
      video_details->min_width = stream_type_set->video()->width().min;
      video_details->max_width = stream_type_set->video()->width().max;
      video_details->min_height = stream_type_set->video()->height().min;
      video_details->max_height = stream_type_set->video()->height().max;
      MediaTypeSetDetailsPtr details = MediaTypeSetDetails::New();
      details->set_video(video_details.Pass());
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->scheme = MediaTypeScheme::VIDEO;
      media_type_set->details = details.Pass();
      return media_type_set;
    }
    default: {
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->scheme = Convert(stream_type_set->scheme());
      return media_type_set;
    }
  }
}

// Creates an array of MediaTypeSets from
// std::vector<std::unique_ptr<StreamTypeSet>>.
Array<MediaTypeSetPtr> Convert(
    const std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>&
        stream_type_sets) {
  if (stream_type_sets == nullptr) {
    return nullptr;
  }

  Array<MediaTypeSetPtr> result =
      Array<MediaTypeSetPtr>::New(stream_type_sets->size());
  for (const std::unique_ptr<StreamTypeSet>& stream_type_set :
       *stream_type_sets) {
    result.push_back(Convert(stream_type_set));
  }
  return result;
}

// Creates a base64-encoded string from Bytes.
String Convert(const std::unique_ptr<Bytes>& bytes) {
  if (bytes == nullptr) {
    return nullptr;
  }

  std::string temp;
  temp.resize(modp_b64_encode_len(bytes->size()));  // Makes room for null byte.

  // modp_b64_encode_len() returns at least 1, so temp[0] is safe to use.
  size_t output_size = modp_b64_encode(
      &(temp[0]), reinterpret_cast<char*>(bytes->data()), bytes->size());

  temp.resize(output_size);  // Strips off null byte.

  return String(temp);
}

MediaMetadataPtr Convert(const std::unique_ptr<Metadata>& metadata) {
  if (metadata == nullptr) {
    return nullptr;
  }

  MediaMetadataPtr result = MediaMetadata::New();
  result->duration = metadata->duration_ns();
  result->title =
      metadata->title().empty() ? String() : String(metadata->title());
  result->artist =
      metadata->artist().empty() ? String() : String(metadata->artist());
  result->album =
      metadata->album().empty() ? String() : String(metadata->album());
  result->publisher =
      metadata->publisher().empty() ? String() : String(metadata->publisher());
  result->genre =
      metadata->genre().empty() ? String() : String(metadata->genre());
  result->composer =
      metadata->composer().empty() ? String() : String(metadata->composer());
  return result;
}

}  // namespace media
}  // namespace mojo
