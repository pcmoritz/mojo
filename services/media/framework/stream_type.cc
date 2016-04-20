// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/safe_clone.h"
#include "services/media/framework/stream_type.h"

namespace mojo {
namespace media {

Bytes::Bytes(size_t size) : storage_(size) {}

Bytes::~Bytes() {}

std::unique_ptr<Bytes> Bytes::Clone() const {
  return std::unique_ptr<Bytes>(new Bytes(*this));
}

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

AudioStreamType::AudioStreamType(const std::string& encoding,
                                 std::unique_ptr<Bytes> encoding_parameters,
                                 SampleFormat sample_format,
                                 uint32_t channels,
                                 uint32_t frames_per_second)
    : StreamType(StreamType::Medium::kAudio,
                 encoding,
                 std::move(encoding_parameters)),
      sample_format_(sample_format),
      channels_(channels),
      frames_per_second_(frames_per_second),
      sample_size_(SampleSizeFromFormat(sample_format)) {}

AudioStreamType::AudioStreamType(const AudioStreamType& other)
    : AudioStreamType(other.encoding(),
                      SafeClone(other.encoding_parameters()),
                      other.sample_format(),
                      other.channels(),
                      other.frames_per_second()) {}

AudioStreamType::~AudioStreamType() {}

const AudioStreamType* AudioStreamType::audio() const {
  return this;
}

// static
uint32_t AudioStreamType::SampleSizeFromFormat(SampleFormat sample_format) {
  switch (sample_format) {
    case SampleFormat::kAny:
      LOG(ERROR) << "sample size requested for SampleFormat::kAny";
      abort();
    case SampleFormat::kUnsigned8:
      return sizeof(uint8_t);
    case SampleFormat::kSigned16:
      return sizeof(int16_t);
    case SampleFormat::kSigned24In32:
      return sizeof(int32_t);
    case SampleFormat::kFloat:
      return sizeof(float);
  }

  return 0;
}

std::unique_ptr<StreamType> AudioStreamType::Clone() const {
  return Create(encoding(), SafeClone(encoding_parameters()), sample_format(),
                channels(), frames_per_second());
}

AudioStreamTypeSet::AudioStreamTypeSet(
    const std::vector<std::string>& encodings,
    AudioStreamType::SampleFormat sample_format,
    Range<uint32_t> channels,
    Range<uint32_t> frames_per_second)
    : StreamTypeSet(StreamType::Medium::kAudio, encodings),
      sample_format_(sample_format),
      channels_(channels),
      frames_per_second_(frames_per_second) {}

AudioStreamTypeSet::~AudioStreamTypeSet() {}

const AudioStreamTypeSet* AudioStreamTypeSet::audio() const {
  return this;
}

bool AudioStreamTypeSet::contains(const AudioStreamType& type) const {
  return (sample_format() == type.sample_format() ||
          sample_format() == AudioStreamType::SampleFormat::kAny) &&
         channels().contains(type.frames_per_second()) &&
         frames_per_second().contains(type.frames_per_second());
}

std::unique_ptr<StreamTypeSet> AudioStreamTypeSet::Clone() const {
  return Create(encodings(), sample_format(), channels(), frames_per_second());
}

VideoStreamType::VideoStreamType(const std::string& encoding,
                                 std::unique_ptr<Bytes> encoding_parameters,
                                 VideoProfile profile,
                                 PixelFormat pixel_format,
                                 ColorSpace color_space,
                                 uint32_t width,
                                 uint32_t height,
                                 uint32_t coded_width,
                                 uint32_t coded_height)
    : StreamType(StreamType::Medium::kVideo,
                 encoding,
                 std::move(encoding_parameters)),
      profile_(profile),
      pixel_format_(pixel_format),
      color_space_(color_space),
      width_(width),
      height_(height),
      coded_width_(coded_width),
      coded_height_(coded_height) {}

VideoStreamType::~VideoStreamType() {}

const VideoStreamType* VideoStreamType::video() const {
  return this;
}

std::unique_ptr<StreamType> VideoStreamType::Clone() const {
  return Create(encoding(), SafeClone(encoding_parameters()), profile(),
                pixel_format(), color_space(), width(), height(), coded_width(),
                coded_height());
}

VideoStreamTypeSet::VideoStreamTypeSet(
    const std::vector<std::string>& encodings,
    Range<uint32_t> width,
    Range<uint32_t> height)
    : StreamTypeSet(StreamType::Medium::kVideo, encodings),
      width_(width),
      height_(height) {}

VideoStreamTypeSet::~VideoStreamTypeSet() {}

const VideoStreamTypeSet* VideoStreamTypeSet::video() const {
  return this;
}

std::unique_ptr<StreamTypeSet> VideoStreamTypeSet::Clone() const {
  return Create(encodings(), width(), height());
}

TextStreamType::TextStreamType(const std::string& encoding,
                               std::unique_ptr<Bytes> encoding_parameters)
    : StreamType(StreamType::Medium::kText,
                 encoding,
                 std::move(encoding_parameters)) {}

TextStreamType::~TextStreamType() {}

const TextStreamType* TextStreamType::text() const {
  return this;
}

std::unique_ptr<StreamType> TextStreamType::Clone() const {
  return Create(encoding(), SafeClone(encoding_parameters()));
}

TextStreamTypeSet::TextStreamTypeSet(const std::vector<std::string>& encodings)
    : StreamTypeSet(StreamType::Medium::kText, encodings) {}

TextStreamTypeSet::~TextStreamTypeSet() {}

const TextStreamTypeSet* TextStreamTypeSet::text() const {
  return this;
}

std::unique_ptr<StreamTypeSet> TextStreamTypeSet::Clone() const {
  return Create(encodings());
}

SubpictureStreamType::SubpictureStreamType(
    const std::string& encoding,
    std::unique_ptr<Bytes> encoding_parameters)
    : StreamType(StreamType::Medium::kSubpicture,
                 encoding,
                 std::move(encoding_parameters)) {}

SubpictureStreamType::~SubpictureStreamType() {}

const SubpictureStreamType* SubpictureStreamType::subpicture() const {
  return this;
}

std::unique_ptr<StreamType> SubpictureStreamType::Clone() const {
  return Create(encoding(), SafeClone(encoding_parameters()));
}

SubpictureStreamTypeSet::SubpictureStreamTypeSet(
    const std::vector<std::string>& encodings)
    : StreamTypeSet(StreamType::Medium::kSubpicture, encodings) {}

SubpictureStreamTypeSet::~SubpictureStreamTypeSet() {}

const SubpictureStreamTypeSet* SubpictureStreamTypeSet::subpicture() const {
  return this;
}

std::unique_ptr<StreamTypeSet> SubpictureStreamTypeSet::Clone() const {
  return Create(encodings());
}

}  // namespace media
}  // namespace mojo
