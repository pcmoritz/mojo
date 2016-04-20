// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework_mojo/mojo_type_conversions.h"

namespace mojo {
namespace media {

namespace {

bool KnownEncodingsMatch() {
  return StreamType::kAudioEncodingLpcm == MediaType::kAudioEncodingLpcm &&
         StreamType::kAudioEncodingVorbis == MediaType::kAudioEncodingVorbis &&
         StreamType::kVideoEncodingUncompressed ==
             MediaType::kVideoEncodingUncompressed &&
         StreamType::kVideoEncodingTheora == MediaType::kVideoEncodingTheora;
}

}  // namespace

Result ConvertResult(MojoResult mojo_result) {
  switch (mojo_result) {
    case MOJO_RESULT_OK:
      return Result::kOk;
    case MOJO_RESULT_INTERNAL:
      return Result::kInternalError;
    case MOJO_RESULT_UNIMPLEMENTED:
      return Result::kUnsupportedOperation;
    case MOJO_RESULT_INVALID_ARGUMENT:
      return Result::kInvalidArgument;
    case MOJO_RESULT_NOT_FOUND:
      return Result::kNotFound;
    case MOJO_RESULT_CANCELLED:
    case MOJO_RESULT_UNKNOWN:
    case MOJO_RESULT_DEADLINE_EXCEEDED:
    case MOJO_RESULT_ALREADY_EXISTS:
    case MOJO_RESULT_PERMISSION_DENIED:
    case MOJO_RESULT_RESOURCE_EXHAUSTED:
    case MOJO_RESULT_FAILED_PRECONDITION:
    case MOJO_RESULT_ABORTED:
    case MOJO_RESULT_OUT_OF_RANGE:
    case MOJO_RESULT_UNAVAILABLE:
    case MOJO_RESULT_DATA_LOSS:
    case MOJO_RESULT_BUSY:
    case MOJO_RESULT_SHOULD_WAIT:
    default:
      break;
  }
  return Result::kUnknownError;
}

Result Convert(MediaResult media_result) {
  switch (media_result) {
    case MediaResult::OK:
      return Result::kOk;
    case MediaResult::INTERNAL_ERROR:
      return Result::kInternalError;
    case MediaResult::UNSUPPORTED_OPERATION:
    case MediaResult::NOT_IMPLEMENTED:
      return Result::kUnsupportedOperation;
    case MediaResult::INVALID_ARGUMENT:
      return Result::kInvalidArgument;
    case MediaResult::NOT_FOUND:
      return Result::kNotFound;
    case MediaResult::UNKNOWN_ERROR:
    case MediaResult::UNSUPPORTED_CONFIG:
    case MediaResult::INSUFFICIENT_RESOURCES:
    case MediaResult::BAD_STATE:
    case MediaResult::BUF_OVERFLOW:
    case MediaResult::FLUSHED:
    case MediaResult::BUSY:
    case MediaResult::PROTOCOL_ERROR:
    case MediaResult::ALREADY_EXISTS:
    case MediaResult::SHUTTING_DOWN:
    case MediaResult::CONNECTION_LOST:
      break;
  }
  return Result::kUnknownError;
}

StreamType::Medium Convert(MediaTypeMedium media_type_medium) {
  switch (media_type_medium) {
    case MediaTypeMedium::AUDIO:
      return StreamType::Medium::kAudio;
    case MediaTypeMedium::VIDEO:
      return StreamType::Medium::kVideo;
    case MediaTypeMedium::TEXT:
      return StreamType::Medium::kText;
    case MediaTypeMedium::SUBPICTURE:
      return StreamType::Medium::kSubpicture;
  }
  LOG(ERROR) << "unrecognized medium";
  abort();
}

AudioStreamType::SampleFormat Convert(AudioSampleFormat audio_sample_format) {
  switch (audio_sample_format) {
    case AudioSampleFormat::ANY:
      return AudioStreamType::SampleFormat::kAny;
    case AudioSampleFormat::UNSIGNED_8:
      return AudioStreamType::SampleFormat::kUnsigned8;
    case AudioSampleFormat::SIGNED_16:
      return AudioStreamType::SampleFormat::kSigned16;
    case AudioSampleFormat::SIGNED_24_IN_32:
      return AudioStreamType::SampleFormat::kSigned24In32;
    case AudioSampleFormat::FLOAT:
      return AudioStreamType::SampleFormat::kFloat;
  }
  LOG(ERROR) << "unrecognized sample format";
  abort();
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
  LOG(ERROR);
  abort();
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
  DCHECK(KnownEncodingsMatch());

  if (!media_type) {
    return nullptr;
  }

  switch (media_type->medium) {
    case MediaTypeMedium::AUDIO:
      return AudioStreamType::Create(
          media_type->encoding, Convert(media_type->encoding_parameters),
          Convert(media_type->details->get_audio()->sample_format),
          media_type->details->get_audio()->channels,
          media_type->details->get_audio()->frames_per_second);
    case MediaTypeMedium::VIDEO:
      return VideoStreamType::Create(
          media_type->encoding, Convert(media_type->encoding_parameters),
          Convert(media_type->details->get_video()->profile),
          Convert(media_type->details->get_video()->pixel_format),
          Convert(media_type->details->get_video()->color_space),
          media_type->details->get_video()->width,
          media_type->details->get_video()->height,
          media_type->details->get_video()->coded_width,
          media_type->details->get_video()->coded_height);
    case MediaTypeMedium::TEXT:
      return TextStreamType::Create(media_type->encoding,
                                    Convert(media_type->encoding_parameters));
    case MediaTypeMedium::SUBPICTURE:
      return SubpictureStreamType::Create(
          media_type->encoding, Convert(media_type->encoding_parameters));
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
  DCHECK(KnownEncodingsMatch());

  if (!media_type_set) {
    return nullptr;
  }

  switch (media_type_set->medium) {
    case MediaTypeMedium::AUDIO:
      return AudioStreamTypeSet::Create(
          media_type_set->encodings.To<std::vector<std::string>>(),
          Convert(media_type_set->details->get_audio()->sample_format),
          Range<uint32_t>(media_type_set->details->get_audio()->min_channels,
                          media_type_set->details->get_audio()->max_channels),
          Range<uint32_t>(
              media_type_set->details->get_audio()->min_frames_per_second,
              media_type_set->details->get_audio()->max_frames_per_second));
    case MediaTypeMedium::VIDEO:
      return VideoStreamTypeSet::Create(
          media_type_set->encodings.To<std::vector<std::string>>(),
          Range<uint32_t>(media_type_set->details->get_video()->min_width,
                          media_type_set->details->get_video()->max_width),
          Range<uint32_t>(media_type_set->details->get_video()->min_height,
                          media_type_set->details->get_video()->max_height));
    case MediaTypeMedium::TEXT:
      return TextStreamTypeSet::Create(
          media_type_set->encodings.To<std::vector<std::string>>());
    case MediaTypeMedium::SUBPICTURE:
      return SubpictureStreamTypeSet::Create(
          media_type_set->encodings.To<std::vector<std::string>>());
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

std::unique_ptr<Bytes> Convert(const Array<uint8_t>& bytes_array) {
  if (bytes_array.is_null()) {
    return nullptr;
  }

  std::unique_ptr<Bytes> bytes = Bytes::Create(bytes_array.size());
  std::memcpy(bytes->data(), bytes_array.data(), bytes_array.size());

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

MediaTypeMedium Convert(StreamType::Medium medium) {
  switch (medium) {
    case StreamType::Medium::kAudio:
      return MediaTypeMedium::AUDIO;
    case StreamType::Medium::kVideo:
      return MediaTypeMedium::VIDEO;
    case StreamType::Medium::kText:
      return MediaTypeMedium::TEXT;
    case StreamType::Medium::kSubpicture:
      return MediaTypeMedium::SUBPICTURE;
  }

  LOG(ERROR) << "unrecognized medium";
  abort();
}

AudioSampleFormat Convert(AudioStreamType::SampleFormat sample_format) {
  switch (sample_format) {
    case AudioStreamType::SampleFormat::kAny:
      return AudioSampleFormat::ANY;
    case AudioStreamType::SampleFormat::kUnsigned8:
      return AudioSampleFormat::UNSIGNED_8;
    case AudioStreamType::SampleFormat::kSigned16:
      return AudioSampleFormat::SIGNED_16;
    case AudioStreamType::SampleFormat::kSigned24In32:
      return AudioSampleFormat::SIGNED_24_IN_32;
    case AudioStreamType::SampleFormat::kFloat:
      return AudioSampleFormat::FLOAT;
  }

  LOG(ERROR) << "unrecognized sample format";
  abort();
}

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

  LOG(ERROR) << "unrecognized video profile";
  abort();
}

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

  LOG(ERROR) << "unrecognized pixel format";
  abort();
}

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

  LOG(ERROR) << "unrecognized color space";
  abort();
}

MediaTypePtr Convert(const std::unique_ptr<StreamType>& stream_type) {
  DCHECK(KnownEncodingsMatch());

  if (stream_type == nullptr) {
    return nullptr;
  }

  switch (stream_type->medium()) {
    case StreamType::Medium::kAudio: {
      AudioMediaTypeDetailsPtr audio_details = AudioMediaTypeDetails::New();
      audio_details->sample_format =
          Convert(stream_type->audio()->sample_format());
      audio_details->channels = stream_type->audio()->channels();
      audio_details->frames_per_second =
          stream_type->audio()->frames_per_second();
      MediaTypeDetailsPtr details = MediaTypeDetails::New();
      details->set_audio(audio_details.Pass());
      MediaTypePtr media_type = MediaType::New();
      media_type->medium = MediaTypeMedium::AUDIO;
      media_type->details = details.Pass();
      media_type->encoding = stream_type->encoding();
      media_type->encoding_parameters =
          Convert(stream_type->encoding_parameters());
      return media_type;
    }
    case StreamType::Medium::kVideo: {
      VideoMediaTypeDetailsPtr video_details = VideoMediaTypeDetails::New();
      video_details->profile = Convert(stream_type->video()->profile());
      video_details->pixel_format =
          Convert(stream_type->video()->pixel_format());
      video_details->color_space = Convert(stream_type->video()->color_space());
      video_details->width = stream_type->video()->width();
      video_details->height = stream_type->video()->height();
      video_details->coded_width = stream_type->video()->coded_width();
      video_details->coded_height = stream_type->video()->coded_height();
      MediaTypeDetailsPtr details = MediaTypeDetails::New();
      details->set_video(video_details.Pass());
      MediaTypePtr media_type = MediaType::New();
      media_type->medium = MediaTypeMedium::VIDEO;
      media_type->details = details.Pass();
      media_type->encoding = stream_type->encoding();
      media_type->encoding_parameters =
          Convert(stream_type->encoding_parameters());
      return media_type;
    }
    case StreamType::Medium::kText: {
      MediaTypePtr media_type = MediaType::New();
      media_type->medium = MediaTypeMedium::TEXT;
      media_type->encoding = stream_type->encoding();
      media_type->encoding_parameters =
          Convert(stream_type->encoding_parameters());
      return media_type;
    }
    case StreamType::Medium::kSubpicture: {
      MediaTypePtr media_type = MediaType::New();
      media_type->medium = MediaTypeMedium::SUBPICTURE;
      media_type->encoding = stream_type->encoding();
      media_type->encoding_parameters =
          Convert(stream_type->encoding_parameters());
      return media_type;
    }
  }

  LOG(ERROR) << "unrecognized medium";
  abort();
}

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

MediaTypeSetPtr Convert(const std::unique_ptr<StreamTypeSet>& stream_type_set) {
  DCHECK(KnownEncodingsMatch());

  if (stream_type_set == nullptr) {
    return nullptr;
  }

  switch (stream_type_set->medium()) {
    case StreamType::Medium::kAudio: {
      AudioMediaTypeSetDetailsPtr audio_details =
          AudioMediaTypeSetDetails::New();
      audio_details->sample_format =
          Convert(stream_type_set->audio()->sample_format());
      audio_details->min_channels = stream_type_set->audio()->channels().min;
      audio_details->max_channels = stream_type_set->audio()->channels().max;
      audio_details->min_frames_per_second =
          stream_type_set->audio()->frames_per_second().min;
      audio_details->max_frames_per_second =
          stream_type_set->audio()->frames_per_second().max;
      MediaTypeSetDetailsPtr details = MediaTypeSetDetails::New();
      details->set_audio(audio_details.Pass());
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->medium = MediaTypeMedium::AUDIO;
      media_type_set->details = details.Pass();
      media_type_set->encodings =
          Array<String>::From(stream_type_set->encodings());
      return media_type_set;
    }
    case StreamType::Medium::kVideo: {
      VideoMediaTypeSetDetailsPtr video_details =
          VideoMediaTypeSetDetails::New();
      video_details->min_width = stream_type_set->video()->width().min;
      video_details->max_width = stream_type_set->video()->width().max;
      video_details->min_height = stream_type_set->video()->height().min;
      video_details->max_height = stream_type_set->video()->height().max;
      MediaTypeSetDetailsPtr details = MediaTypeSetDetails::New();
      details->set_video(video_details.Pass());
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->medium = MediaTypeMedium::VIDEO;
      media_type_set->details = details.Pass();
      media_type_set->encodings =
          Array<String>::From(stream_type_set->encodings());
      return media_type_set;
    }
    case StreamType::Medium::kText: {
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->medium = MediaTypeMedium::TEXT;
      media_type_set->encodings =
          Array<String>::From(stream_type_set->encodings());
      return media_type_set;
    }
    case StreamType::Medium::kSubpicture: {
      MediaTypeSetPtr media_type_set = MediaTypeSet::New();
      media_type_set->medium = MediaTypeMedium::SUBPICTURE;
      media_type_set->encodings =
          Array<String>::From(stream_type_set->encodings());
      return media_type_set;
    }
  }

  LOG(ERROR) << "unrecognized medium";
  abort();
}

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

Array<uint8_t> Convert(const std::unique_ptr<Bytes>& bytes) {
  if (bytes == nullptr) {
    return nullptr;
  }

  Array<uint8_t> array = Array<uint8_t>::New(bytes->size());
  std::memcpy(array.data(), bytes->data(), bytes->size());

  return array;
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
