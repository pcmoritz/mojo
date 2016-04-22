// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/types/stream_type.h"
#include "services/media/framework/util/safe_clone.h"

namespace mojo {
namespace media {

// These must match the definitions in media_types.mojom. This is verfied by
// the KnownEncodingsMatch function in framework_mojo/mojo_type_conversion.cc.
// Changes to this list should be reflected there.
const char* StreamType::kAudioEncodingLpcm = "lpcm";
const char* StreamType::kAudioEncodingVorbis = "vorbis";
const char* StreamType::kVideoEncodingUncompressed = "uncompressed_video";
const char* StreamType::kVideoEncodingTheora = "theora";

StreamType::StreamType(Medium medium,
                       const std::string& encoding,
                       std::unique_ptr<Bytes> encoding_parameters)
    : medium_(medium),
      encoding_(encoding),
      encoding_parameters_(std::move(encoding_parameters)) {}

StreamType::~StreamType() {}

const AudioStreamType* StreamType::audio() const {
  LOG(ERROR) << "audio method called on non-audio stream type";
  return nullptr;
}

const VideoStreamType* StreamType::video() const {
  LOG(ERROR) << "video method called on non-video stream type";
  return nullptr;
}

const TextStreamType* StreamType::text() const {
  LOG(ERROR) << "text method called on non-text stream type";
  return nullptr;
}

const SubpictureStreamType* StreamType::subpicture() const {
  LOG(ERROR) << "subpicture method called on non-subpicture stream type";
  return nullptr;
}

std::unique_ptr<StreamType> StreamType::Clone() const {
  return Create(medium(), encoding(), SafeClone(encoding_parameters()));
}

StreamTypeSet::StreamTypeSet(StreamType::Medium medium,
                             const std::vector<std::string>& encodings)
    : medium_(medium), encodings_(encodings) {}

StreamTypeSet::~StreamTypeSet() {}

const AudioStreamTypeSet* StreamTypeSet::audio() const {
  LOG(ERROR) << "audio method called on non-audio stream type set";
  return nullptr;
}

const VideoStreamTypeSet* StreamTypeSet::video() const {
  LOG(ERROR) << "video method called on non-video stream type set";
  return nullptr;
}

const TextStreamTypeSet* StreamTypeSet::text() const {
  LOG(ERROR) << "text method called on non-text stream type set";
  return nullptr;
}

const SubpictureStreamTypeSet* StreamTypeSet::subpicture() const {
  LOG(ERROR) << "subpicture method called on non-subpicture stream type set";
  return nullptr;
}

std::unique_ptr<StreamTypeSet> StreamTypeSet::Clone() const {
  return Create(medium(), encodings());
}

bool StreamTypeSet::IncludesEncoding(const std::string encoding) {
  for (const std::string set_encoding : encodings_) {
    if (set_encoding == encoding) {
      return true;
    }
  }

  return false;
}

}  // namespace media
}  // namespace mojo
