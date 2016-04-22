// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_TYPE_CONVERSIONS_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_TYPE_CONVERSIONS_H_

#include "mojo/services/media/common/interfaces/media_common.mojom.h"
#include "mojo/services/media/common/interfaces/media_metadata.mojom.h"
#include "mojo/services/media/common/interfaces/media_types.mojom.h"
#include "services/media/framework/metadata.h"
#include "services/media/framework/result.h"
#include "services/media/framework/types/audio_stream_type.h"
#include "services/media/framework/types/stream_type.h"
#include "services/media/framework/types/video_stream_type.h"

namespace mojo {
namespace media {

// Converts a MojoResult into a Result.
Result ConvertResult(MojoResult mojo_result);

// Converts a MediaResult into a Result.
Result Convert(MediaResult media_result);

// Creates a StreamType::Medium from a MediaTypeMedium.
StreamType::Medium Convert(MediaTypeMedium media_type_medium);

// Creates an AudioStreamType::SampleFormat from an AudioSampleFormat.
AudioStreamType::SampleFormat Convert(AudioSampleFormat audio_sample_format);

// Creates a VideoStreamType::VideoProfile from a VideoProfile.
VideoStreamType::VideoProfile Convert(VideoProfile video_profile);

// Creates a VideoStreamType::PixelFormat from a PixelFormat.
VideoStreamType::PixelFormat Convert(PixelFormat pixel_format);

// Creates a VideoStreamType::ColorSpace from a ColorSpace.
VideoStreamType::ColorSpace Convert(ColorSpace color_space);

// Creates a StreamType from a MediaType.
std::unique_ptr<StreamType> Convert(const MediaTypePtr& media_type);

// Creates std::vector<std::unique_ptr<StreamType>> from an array of MediaTypes.
std::unique_ptr<std::vector<std::unique_ptr<StreamType>>> Convert(
    const Array<MediaTypePtr>& media_types);

// Creates a StreamTypeSet from a MediaTypeSet.
std::unique_ptr<StreamTypeSet> Convert(const MediaTypeSetPtr& media_type_set);

// Creates std::vector<std::unique_ptr<StreamTypeSet>> from an array of
// MediaTypeSets.
std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>> Convert(
    const Array<MediaTypeSetPtr>& media_type_sets);

// Creates Bytes from an Array of bytes.
std::unique_ptr<Bytes> Convert(const Array<uint8_t>& bytes_array);

// Creates Metadata from MediaMetadata.
std::unique_ptr<Metadata> Convert(const MediaMetadataPtr& media_metadata);

// Creates a MediaTypeMedium from a StreamType::Medium.
MediaTypeMedium Convert(StreamType::Medium medium);

// Creates an AudioSampleFormat from an AudioStreamType::SampleFormat.
AudioSampleFormat Convert(AudioStreamType::SampleFormat sample_format);

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

// Creates an Array of bytes from Bytes.
Array<uint8_t> Convert(const std::unique_ptr<Bytes>& bytes);

// Creates MediaMetadata from Metadata.
MediaMetadataPtr Convert(const std::unique_ptr<Metadata>& metadata);

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_TYPE_CONVERSIONS_H_
