// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_STREAM_TYPE_H_
#define SERVICES_MEDIA_FRAMEWORK_STREAM_TYPE_H_

#include <cstring>
#include <memory>
#include <string>
#include <vector>

#include "base/logging.h"

namespace mojo {
namespace media {

class StreamType;
class AudioStreamType;
class VideoStreamType;
class TextStreamType;
class SubpictureStreamType;

class Bytes {
 public:
  static std::unique_ptr<Bytes> Create(size_t size) {
    return std::unique_ptr<Bytes>(new Bytes(size));
  }

  static std::unique_ptr<Bytes> Create(const uint8_t* data, size_t size) {
    std::unique_ptr<Bytes> result = Create(size);
    if (size != 0) {
      DCHECK(result->data());
      DCHECK(data);
      std::memcpy(result->data(), data, size);
    }
    return result;
  }

  ~Bytes();

  std::unique_ptr<Bytes> Clone() const;

  uint8_t* data() { return storage_.data(); }

  const uint8_t* data() const { return storage_.data(); }

  size_t size() const { return storage_.size(); }

 private:
  explicit Bytes(size_t size);

  std::vector<uint8_t> storage_;
};

// Describes the type of a stream.
class StreamType {
 public:
  enum class Medium { kAudio, kVideo, kText, kSubpicture };

  static const char* kAudioEncodingLpcm;
  static const char* kAudioEncodingVorbis;
  static const char* kVideoEncodingUncompressed;
  static const char* kVideoEncodingTheora;

  static std::unique_ptr<StreamType> Create(
      Medium medium,
      const std::string& encoding,
      std::unique_ptr<Bytes> encoding_parameters) {
    return std::unique_ptr<StreamType>(
        new StreamType(medium, encoding, std::move(encoding_parameters)));
  }

  explicit StreamType(Medium medium,
                      const std::string& encoding,
                      std::unique_ptr<Bytes> encoding_parameters);

  virtual ~StreamType();

  Medium medium() const { return medium_; }

  const std::string& encoding() const { return encoding_; }

  const std::unique_ptr<Bytes>& encoding_parameters() const {
    return encoding_parameters_;
  }

  virtual const AudioStreamType* audio() const;
  virtual const VideoStreamType* video() const;
  virtual const TextStreamType* text() const;
  virtual const SubpictureStreamType* subpicture() const;

  virtual std::unique_ptr<StreamType> Clone() const;

 private:
  Medium medium_;
  std::string encoding_;
  std::unique_ptr<Bytes> encoding_parameters_;
};

template <typename T>
struct Range {
  Range(T min_param, T max_param) : min(min_param), max(max_param) {
    DCHECK(min_param <= max_param);
  }

  T min;
  T max;

  constexpr bool contains(const T& t) const { return t >= min && t <= max; }
};

class StreamTypeSet;
class AudioStreamTypeSet;
class VideoStreamTypeSet;
class TextStreamTypeSet;
class SubpictureStreamTypeSet;

// Describes a set of possible stream types.
class StreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(
      StreamType::Medium medium,
      const std::vector<std::string>& encodings) {
    return std::unique_ptr<StreamTypeSet>(new StreamTypeSet(medium, encodings));
  }

  StreamTypeSet(StreamType::Medium medium,
                const std::vector<std::string>& encodings);

  virtual ~StreamTypeSet();

  StreamType::Medium medium() const { return medium_; }

  const std::vector<std::string>& encodings() const { return encodings_; }

  virtual const AudioStreamTypeSet* audio() const;
  virtual const VideoStreamTypeSet* video() const;
  virtual const TextStreamTypeSet* text() const;
  virtual const SubpictureStreamTypeSet* subpicture() const;

  virtual std::unique_ptr<StreamTypeSet> Clone() const;

  bool IncludesEncoding(const std::string encoding);

 private:
  StreamType::Medium medium_;
  std::vector<std::string> encodings_;
};

// Describes the type of an audio stream.
class AudioStreamType : public StreamType {
 public:
  enum class SampleFormat {
    kAny,
    kUnsigned8,
    kSigned16,
    kSigned24In32,
    kFloat
  };

  static std::unique_ptr<StreamType> Create(
      const std::string& encoding,
      std::unique_ptr<Bytes> encoding_parameters,
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second) {
    return std::unique_ptr<StreamType>(
        new AudioStreamType(encoding, std::move(encoding_parameters),
                            sample_format, channels, frames_per_second));
  }

  AudioStreamType(const std::string& encoding,
                  std::unique_ptr<Bytes> encoding_parameters,
                  SampleFormat sample_format,
                  uint32_t channels,
                  uint32_t frames_per_second);

  AudioStreamType(const AudioStreamType& other);

  ~AudioStreamType() override;

  const AudioStreamType* audio() const override;

  SampleFormat sample_format() const { return sample_format_; }

  uint32_t channels() const { return channels_; }

  uint32_t frames_per_second() const { return frames_per_second_; }

  uint32_t sample_size() const { return sample_size_; }

  uint32_t bytes_per_frame() const { return sample_size_ * channels_; }

  uint64_t min_buffer_size(uint64_t frame_count) const {
    return frame_count * bytes_per_frame();
  }

  uint64_t frame_count(uint64_t size) const {
    DCHECK(bytes_per_frame() != 0);
    DCHECK(size % bytes_per_frame() == 0);
    return size / bytes_per_frame();
  }

  static uint32_t SampleSizeFromFormat(SampleFormat sample_format);

  std::unique_ptr<StreamType> Clone() const override;

 private:
  SampleFormat sample_format_;
  uint32_t channels_;
  uint32_t frames_per_second_;
  uint32_t sample_size_;
};

// Describes a set of audio stream types.
class AudioStreamTypeSet : public StreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(
      const std::vector<std::string>& encodings,
      AudioStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second) {
    return std::unique_ptr<StreamTypeSet>(new AudioStreamTypeSet(
        encodings, sample_format, channels, frames_per_second));
  }

  AudioStreamTypeSet(const std::vector<std::string>& encodings,
                     AudioStreamType::SampleFormat sample_format,
                     Range<uint32_t> channels,
                     Range<uint32_t> frames_per_second);

  ~AudioStreamTypeSet() override;

  const AudioStreamTypeSet* audio() const override;

  AudioStreamType::SampleFormat sample_format() const { return sample_format_; }

  Range<uint32_t> channels() const { return channels_; }

  Range<uint32_t> frames_per_second() const { return frames_per_second_; }

  bool contains(const AudioStreamType& type) const;

  std::unique_ptr<StreamTypeSet> Clone() const override;

 private:
  AudioStreamType::SampleFormat sample_format_;
  Range<uint32_t> channels_;
  Range<uint32_t> frames_per_second_;
};

// Describes the type of a video stream.
class VideoStreamType : public StreamType {
 public:
  enum class VideoProfile {
    kUnknown,
    kNotApplicable,
    kH264Baseline,
    kH264Main,
    kH264Extended,
    kH264High,
    kH264High10,
    kH264High422,
    kH264High444Predictive,
    kH264ScalableBaseline,
    kH264ScalableHigh,
    kH264StereoHigh,
    kH264MultiviewHigh
  };

  enum class PixelFormat {
    kUnknown,
    kI420,
    kYv12,
    kYv16,
    kYv12A,
    kYv24,
    kNv12,
    kNv21,
    kUyvy,
    kYuy2,
    kArgb,
    kXrgb,
    kRgb24,
    kRgb32,
    kMjpeg,
    kMt21
  };

  enum class ColorSpace {
    kUnknown,
    kNotApplicable,
    kJpeg,
    kHdRec709,
    kSdRec601
  };

  static std::unique_ptr<StreamType> Create(
      const std::string& encoding,
      std::unique_ptr<Bytes> encoding_parameters,
      VideoProfile profile,
      PixelFormat pixel_format,
      ColorSpace color_space,
      uint32_t width,
      uint32_t height,
      uint32_t coded_width,
      uint32_t coded_height) {
    return std::unique_ptr<StreamType>(new VideoStreamType(
        encoding, std::move(encoding_parameters), profile, pixel_format,
        color_space, width, height, coded_width, coded_height));
  }

  VideoStreamType(const std::string& encoding,
                  std::unique_ptr<Bytes> encoding_parameters,
                  VideoProfile profile,
                  PixelFormat pixel_format,
                  ColorSpace color_space,
                  uint32_t width,
                  uint32_t height,
                  uint32_t coded_width,
                  uint32_t coded_height);

  ~VideoStreamType() override;

  const VideoStreamType* video() const override;

  VideoProfile profile() const { return profile_; }

  PixelFormat pixel_format() const { return pixel_format_; }

  ColorSpace color_space() const { return color_space_; }

  uint32_t width() const { return width_; }

  uint32_t height() const { return height_; }

  uint32_t coded_width() const { return coded_width_; }

  uint32_t coded_height() const { return coded_height_; }

  std::unique_ptr<StreamType> Clone() const override;

 private:
  VideoProfile profile_;
  PixelFormat pixel_format_;
  ColorSpace color_space_;
  uint32_t width_;
  uint32_t height_;
  uint32_t coded_width_;
  uint32_t coded_height_;
};

// Describes a set of video stream types.
class VideoStreamTypeSet : public StreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(
      const std::vector<std::string>& encodings,
      Range<uint32_t> width,
      Range<uint32_t> height) {
    return std::unique_ptr<StreamTypeSet>(
        new VideoStreamTypeSet(encodings, width, height));
  }

  VideoStreamTypeSet(const std::vector<std::string>& encodings,
                     Range<uint32_t> width,
                     Range<uint32_t> height);

  ~VideoStreamTypeSet() override;

  const VideoStreamTypeSet* video() const override;

  Range<uint32_t> width() const { return width_; }

  Range<uint32_t> height() const { return height_; }

  std::unique_ptr<StreamTypeSet> Clone() const override;

 private:
  Range<uint32_t> width_;
  Range<uint32_t> height_;
};

// Describes the type of a text stream.
class TextStreamType : public StreamType {
 public:
  static std::unique_ptr<StreamType> Create(
      const std::string& encoding,
      std::unique_ptr<Bytes> encoding_parameters) {
    return std::unique_ptr<StreamType>(
        new TextStreamType(encoding, std::move(encoding_parameters)));
  }

  TextStreamType(const std::string& encoding,
                 std::unique_ptr<Bytes> encoding_parameters);

  ~TextStreamType() override;

  const TextStreamType* text() const override;

  std::unique_ptr<StreamType> Clone() const override;
};

// Describes a set of text stream types.
class TextStreamTypeSet : public StreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(
      const std::vector<std::string>& encodings) {
    return std::unique_ptr<StreamTypeSet>(new TextStreamTypeSet(encodings));
  }

  TextStreamTypeSet(const std::vector<std::string>& encodings);

  ~TextStreamTypeSet() override;

  const TextStreamTypeSet* text() const override;

  std::unique_ptr<StreamTypeSet> Clone() const override;
};

// Describes the type of a subpicture stream.
class SubpictureStreamType : public StreamType {
 public:
  static std::unique_ptr<StreamType> Create(
      const std::string& encoding,
      std::unique_ptr<Bytes> encoding_parameters) {
    return std::unique_ptr<StreamType>(
        new SubpictureStreamType(encoding, std::move(encoding_parameters)));
  }

  SubpictureStreamType(const std::string& encoding,
                       std::unique_ptr<Bytes> encoding_parameters);

  ~SubpictureStreamType() override;

  const SubpictureStreamType* subpicture() const override;

  std::unique_ptr<StreamType> Clone() const override;
};

// Describes a set of subpicture stream types.
class SubpictureStreamTypeSet : public StreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(
      const std::vector<std::string>& encodings) {
    return std::unique_ptr<StreamTypeSet>(
        new SubpictureStreamTypeSet(encodings));
  }

  SubpictureStreamTypeSet(const std::vector<std::string>& encodings);

  ~SubpictureStreamTypeSet() override;

  const SubpictureStreamTypeSet* subpicture() const override;

  std::unique_ptr<StreamTypeSet> Clone() const override;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_STREAM_TYPE_H_
