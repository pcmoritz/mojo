// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework_mojo/mojo_formatting.h"

namespace mojo {
namespace media {

template <typename T>
std::ostream& operator<<(std::ostream& os, const InterfacePtr<T>& value) {
  if (!value.is_bound()) {
    return os << "<not bound>" << std::endl;
  } else {
    return os << "<bound>" << std::endl;
  }
}

std::ostream& operator<<(std::ostream& os,
                         const MediaSourceStreamDescriptorPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl << "uint32_t index: " << int(value->index) << std::endl;
  os << begl << "MediaTypePtr media_type: " << value->media_type;
  os << begl
     << "MediaTypePtr original_media_type: " << value->original_media_type;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os, const MediaTypePtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl
     << "MediaTypeScheme scheme: " << StringFromMediaTypeScheme(value->scheme)
     << std::endl;
  os << begl << "MediaTypeDetailsPtr details: " << value->details;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os, const MediaTypeSetPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl
     << "MediaTypeScheme scheme: " << StringFromMediaTypeScheme(value->scheme)
     << std::endl;
  os << begl << "MediaTypeSetDetailsPtr details: " << value->details;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os, const MediaTypeDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else if (value->has_unknown_tag()) {
    return os << "<empty>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  if (value->is_multiplexed()) {
    return os << begl << "MultiplexedMediaTypeDetailsPtr* multiplexed: "
              << value->get_multiplexed() << outdent;
  }
  if (value->is_lpcm()) {
    return os << begl << "LpcmMediaTypeDetailsPtr* lpcm: " << value->get_lpcm()
              << outdent;
  }
  if (value->is_compressed_audio()) {
    return os << begl
              << "CompressedAudiomMediaTypeDetailsPtr* compressed_audio: "
              << value->get_compressed_audio() << outdent;
  }
  if (value->is_video()) {
    return os << begl
              << "VideoMediaTypeDetailsPtr* video: " << value->get_video()
              << outdent;
  }
  return os << begl << "UNKNOWN TAG" << std::endl << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const MediaTypeSetDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else if (value->has_unknown_tag()) {
    return os << "<empty>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  if (value->is_multiplexed()) {
    return os << begl << "MultiplexedMediaTypeSetDetailsPtr* multiplexed: "
              << value->get_multiplexed() << outdent;
  }
  if (value->is_lpcm()) {
    return os << begl
              << "LpcmMediaTypeSetDetailsPtr* lpcm: " << value->get_lpcm()
              << outdent;
  }
  if (value->is_compressed_audio()) {
    return os << begl
              << "CompressedAudioMediaTypeSetDetailsPtr* compressed_audio: "
              << value->get_compressed_audio() << outdent;
  }
  if (value->is_video()) {
    return os << begl
              << "VideoMediaTypeSetDetailsPtr* video: " << value->get_video()
              << outdent;
  }
  return os << begl << "UNKNOWN TAG" << std::endl << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const MultiplexedMediaTypeDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl << "MediaTypePtr multiplex_type: " << value->multiplex_type;
  os << begl
     << "Array<MediaTypePtr> substream_types: " << value->substream_types;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const MultiplexedMediaTypeSetDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl
     << "MediaTypeSetPtr multiplex_type_set: " << value->multiplex_type_set;
  os << begl << "Array<MediaTypeSetPtr> substream_type_sets: "
     << value->substream_type_sets;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const LpcmMediaTypeDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl << "LpcmSampleFormat sample_format: "
     << StringFromLpcmSampleFormat(value->sample_format) << std::endl;
  os << begl << "uint32_t channels: " << int(value->channels) << std::endl;
  os << begl << "uint32_t frames_per_second: " << value->frames_per_second
     << std::endl;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const LpcmMediaTypeSetDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl << "LpcmSampleFormat sample_format: "
     << StringFromLpcmSampleFormat(value->sample_format) << std::endl;
  os << begl << "uint32_t min_channels: " << int(value->min_channels)
     << std::endl;
  os << begl << "uint32_t max_channels: " << int(value->max_channels)
     << std::endl;
  os << begl
     << "uint32_t min_frames_per_second: " << value->min_frames_per_second
     << std::endl;
  os << begl
     << "uint32_t max_cframes_per_second: " << value->max_frames_per_second
     << std::endl;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const CompressedAudioMediaTypeDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl
     << "AudioEncoding encoding: " << StringFromAudioEncoding(value->encoding)
     << std::endl;
  os << begl << "LpcmSampleFormat sample_format: "
     << StringFromLpcmSampleFormat(value->sample_format) << std::endl;
  os << begl << "uint32_t channels: " << int(value->channels) << std::endl;
  os << begl << "uint32_t frames_per_second: " << value->frames_per_second
     << std::endl;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const CompressedAudioMediaTypeSetDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl
     << "AudioEncoding encoding: " << StringFromAudioEncoding(value->encoding)
     << std::endl;
  os << begl << "LpcmSampleFormat sample_format: "
     << StringFromLpcmSampleFormat(value->sample_format) << std::endl;
  os << begl << "uint32_t min_channels: " << int(value->min_channels)
     << std::endl;
  os << begl << "uint32_t max_channels: " << int(value->max_channels)
     << std::endl;
  os << begl
     << "uint32_t min_frames_per_second: " << value->min_frames_per_second
     << std::endl;
  os << begl
     << "uint32_t max_cframes_per_second: " << value->max_frames_per_second
     << std::endl;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const VideoMediaTypeDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl
     << "VideoEncoding encoding: " << StringFromVideoEncoding(value->encoding)
     << std::endl;
  os << begl << "VideoProfile profile: " << value->profile << std::endl;
  os << begl << "PixelFormat pixel_format: " << value->pixel_format
     << std::endl;
  os << begl << "ColorSpace color_space: " << value->color_space << std::endl;
  os << begl << "uint32_t width: " << value->width << std::endl;
  os << begl << "uint32_t height: " << value->height << std::endl;
  os << begl << "uint32_t coded_width: " << value->coded_width << std::endl;
  os << begl << "uint32_t coded_height: " << value->coded_height << std::endl;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os,
                         const VideoMediaTypeSetDetailsPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl
     << "VideoEncoding encoding: " << StringFromVideoEncoding(value->encoding)
     << std::endl;
  os << begl << "uint32_t min_width: " << value->min_width << std::endl;
  os << begl << "uint32_t max_width: " << value->max_width << std::endl;
  os << begl << "uint32_t min_height: " << value->min_height << std::endl;
  os << begl << "uint32_t max_height: " << value->max_height << std::endl;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os, const TimelineQuadPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl << "int64 reference_offset: " << value->reference_offset
     << std::endl;
  os << begl << "int64 target_offset: " << value->target_offset << std::endl;
  os << begl << "int32 reference_delta: " << value->reference_delta
     << std::endl;
  os << begl << "uint32 target_delta: " << value->target_delta << std::endl;
  return os << outdent;
}

std::ostream& operator<<(std::ostream& os, const TimelineTransformPtr& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else {
    os << std::endl;
  }

  os << indent;
  os << begl << "TimelineQuad quad: " << value->quad;
  os << begl << "uint32 reference_timeline_id: " << value->reference_timeline_id
     << std::endl;
  os << begl << "uint32 target_timeline_id: " << value->target_timeline_id
     << std::endl;
  return os << outdent;
}

const char* StringFromMediaTypeScheme(MediaTypeScheme value) {
  switch (value) {
    case MediaTypeScheme::UNKNOWN:
      return "UNKNOWN";
    case MediaTypeScheme::NONE:
      return "NONE";
    case MediaTypeScheme::ANY_ELEMENTARY:
      return "ANY_ELEMENTARY";
    case MediaTypeScheme::ANY_AUDIO:
      return "ANY_AUDIO";
    case MediaTypeScheme::ANY_VIDEO:
      return "ANY_VIDEO";
    case MediaTypeScheme::ANY_TEXT:
      return "ANY_TEXT";
    case MediaTypeScheme::ANY_SUBPICTURE:
      return "ANY_SUBPICTURE";
    case MediaTypeScheme::ANY_MULTIPLEXED:
      return "ANY_MULTIPLEXED";
    case MediaTypeScheme::MULTIPLEXED:
      return "MULTIPLEXED";
    case MediaTypeScheme::ANY:
      return "ANY";
    case MediaTypeScheme::LPCM:
      return "LPCM";
    case MediaTypeScheme::COMPRESSED_AUDIO:
      return "COMPRESSED_AUDIO";
    case MediaTypeScheme::VIDEO:
      return "VIDEO";
  }
  return "UNKNOWN SCHEME";
}

const char* StringFromLpcmSampleFormat(LpcmSampleFormat value) {
  switch (value) {
    case LpcmSampleFormat::UNKNOWN:
      return "UNKNOWN";
    case LpcmSampleFormat::ANY:
      return "ANY";
    case LpcmSampleFormat::UNSIGNED_8:
      return "UNSIGNED_8";
    case LpcmSampleFormat::SIGNED_16:
      return "SIGNED_16";
    case LpcmSampleFormat::SIGNED_24_IN_32:
      return "SIGNED_24_IN_32";
    case LpcmSampleFormat::FLOAT:
      return "FLOAT";
  }
  return "UNKNOWN FORMAT";
}

const char* StringFromAudioEncoding(AudioEncoding value) {
  switch (value) {
    case AudioEncoding::UNKNOWN:
      return "UNKNOWN";
    case AudioEncoding::ANY:
      return "ANY";
    case AudioEncoding::VORBIS:
      return "VORBIS";
  }
  return "UNKNOWN AUDIO ENCODING";
}

const char* StringFromVideoEncoding(VideoEncoding value) {
  switch (value) {
    case VideoEncoding::UNKNOWN:
      return "UNKNOWN";
    case VideoEncoding::ANY:
      return "ANY";
    case VideoEncoding::THEORA:
      return "THEORA";
    case VideoEncoding::VP8:
      return "VP8";
  }
  return "UNKNOWN VIDEO ENCODING";
}

const char* StringFromMediaState(MediaState value) {
  switch (value) {
    case MediaState::FAULT:
      return "FAULT";
    case MediaState::UNPREPARED:
      return "UNPREPARED";
    case MediaState::PAUSED:
      return "PAUSED";
    case MediaState::PLAYING:
      return "PLAYING";
    case MediaState::ENDED:
      return "ENDED";
  }
  return "UNKNOWN MEDIA STATE";
}

}  // namespace media
}  // namespace mojo
