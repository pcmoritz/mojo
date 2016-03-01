// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_TYPE_CONVERSIONS_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_TYPE_CONVERSIONS_H_

#include "mojo/services/media/common/interfaces/media_metadata.mojom.h"
#include "mojo/services/media/common/interfaces/media_types.mojom.h"
#include "services/media/framework/metadata.h"
#include "services/media/framework/stream_type.h"

namespace mojo {
namespace media {

// Creates a StreamType::Scheme from a MediaTypeScheme.
StreamType::Scheme Convert(MediaTypeScheme media_type_scheme);

// Creates an LpcmStreamType::SampleFormat from an LpcmSampleFormat.
LpcmStreamType::SampleFormat Convert(LpcmSampleFormat lpcm_sample_format);

// Creates a CompressedAudioStreamType::VideoEncoding from an AudioEncoding.
CompressedAudioStreamType::AudioEncoding Convert(AudioEncoding audio_encoding);

// Creates a VideoStreamType::VideoEncoding from a VideoEncoding.
VideoStreamType::VideoEncoding Convert(VideoEncoding video_encoding);

// Creates a VideoStreamType::VideoProfile from a VideoProfile.
VideoStreamType::VideoProfile Convert(VideoProfile video_profile);

// Creates a VideoStreamType::PixelFormat from a PixelFormat.
VideoStreamType::PixelFormat Convert(PixelFormat pixel_format);

// Creates a VideoStreamType::ColorSpace from a ColorSpace.
VideoStreamType::ColorSpace Convert(ColorSpace color_space);

// Creates a StreamType from a MediaType.
std::unique_ptr<StreamType> Convert(const MediaTypePtr& media_type);

// Creates std::vector<std::unique_ptr<StreamType>> from an array of MediaTypes.
std::unique_ptr<std::vector<std::unique_ptr<StreamType>>>
    Convert(const Array<MediaTypePtr>& media_types);

// Creates a StreamTypeSet from a MediaTypeSet.
std::unique_ptr<StreamTypeSet> Convert(const MediaTypeSetPtr& media_type_set);

// Creates std::vector<std::unique_ptr<StreamTypeSet>> from an array of
// MediaTypeSets.
std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>> Convert(
    const Array<MediaTypeSetPtr>& media_type_sets);

// Creates Bytes from a base64-encoded string.
std::unique_ptr<Bytes> Convert(const String& base64);

// Creates Metadata from MediaMetadata.
std::unique_ptr<Metadata> Convert(const MediaMetadataPtr& media_metadata);

// Creates a MediaTypeScheme from a StreamType::Scheme.
MediaTypeScheme Convert(StreamType::Scheme scheme);

// Creates an LpcmSampleFormat from an LpcmStreamType::SampleFormat.
LpcmSampleFormat Convert(LpcmStreamType::SampleFormat sample_format);

// Creates an AudioEncoding from a CompressedAudioStreamType::VideoEncoding.
AudioEncoding Convert(CompressedAudioStreamType::AudioEncoding audio_encoding);

// Creates a VideoEncoding from a VideoStreamType::VideoEncoding.
VideoEncoding Convert(VideoStreamType::VideoEncoding video_encoding);

// Creates a VideoProfile from a VideoStreamType::VideoProfile.
VideoProfile Convert(VideoStreamType::VideoProfile video_profile);

// Creates a PixelFormat from a VideoStreamType::PixelFormat.
PixelFormat Convert(VideoStreamType::PixelFormat pixel_format);

// Creates a ColorSpace from a VideoStreamType::ColorSpace.
ColorSpace Convert(VideoStreamType::ColorSpace color_space);

// Creates a MediaType from a StreamType.
MediaTypePtr Convert(const std::unique_ptr<StreamType>& stream_type);

// Creates an array of MediaTypes from std::vector<std::unique_ptr<StreamType>>.
Array<MediaTypePtr> Convert(
    const std::unique_ptr<std::vector<std::unique_ptr<StreamType>>>&
      stream_types);

// Creates a MediaTypeSet from a StreamTypeSet.
MediaTypeSetPtr Convert(const std::unique_ptr<StreamTypeSet>& stream_type_set);

// Creates an array of MediaTypeSets from
// std::vector<std::unique_ptr<StreamTypeSet>>.
Array<MediaTypeSetPtr> Convert(
    const std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>&
        stream_type_sets);

// Creates a base64-encoded string from Bytes.
String Convert(const std::unique_ptr<Bytes>& bytes);

// Creates MediaMetadata from Metadata.
MediaMetadataPtr Convert(const std::unique_ptr<Metadata>& metadata);

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_TYPE_CONVERSIONS_H_
