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
class MultiplexedStreamType;
class LpcmStreamType;
class CompressedAudioStreamType;
class VideoStreamType;

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
  enum class Scheme {
    kUnknown,
    kNone,
    kAnyElementary,
    kAnyAudio,
    kAnyVideo,
    kAnySubpicture,
    kAnyText,
    kAnyMultiplexed,
    kAny,

    kMultiplexed,
    kLpcm,
    kCompressedAudio,
    kVideo
  };

  static std::unique_ptr<StreamType> Create(Scheme scheme) {
    return std::unique_ptr<StreamType>(new StreamType(scheme));
  }

  explicit StreamType(Scheme scheme);

  virtual ~StreamType();

  Scheme scheme() const {
    return scheme_;
  }

  virtual const MultiplexedStreamType* multiplexed() const;
  virtual const LpcmStreamType* lpcm() const;
  virtual const CompressedAudioStreamType* compressed_audio() const;
  virtual const VideoStreamType* video() const;

  virtual std::unique_ptr<StreamType> Clone() const;

 private:
  Scheme scheme_;
};

template<typename T>
struct Range {
  Range(T min_param, T max_param) : min(min_param), max(max_param) {
    DCHECK(min_param <= max_param);
  }

  T min;
  T max;

  constexpr bool contains(const T& t) const {
    return t >= min && t <= max;
  }
};

class StreamTypeSet;
class MultiplexedStreamTypeSet;
class LpcmStreamTypeSet;
class CompressedAudioStreamTypeSet;
class VideoStreamTypeSet;

// Describes a set of possible stream types.
class StreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(StreamType::Scheme scheme) {
    return std::unique_ptr<StreamTypeSet>(new StreamTypeSet(scheme));
  }

  StreamTypeSet(StreamType::Scheme scheme);

  virtual ~StreamTypeSet();

  StreamType::Scheme scheme() const {
    return scheme_;
  }

  virtual const MultiplexedStreamTypeSet* multiplexed() const;
  virtual const LpcmStreamTypeSet* lpcm() const;
  virtual const CompressedAudioStreamTypeSet* compressed_audio() const;
  virtual const VideoStreamTypeSet* video() const;

  virtual std::unique_ptr<StreamTypeSet> Clone() const;

 private:
  StreamType::Scheme scheme_;
};

// Describes the type of a multiplexed stream.
class MultiplexedStreamType : public StreamType {
 public:
  static std::unique_ptr<StreamType> Create(
      std::unique_ptr<StreamType> multiplex_type,
      std::unique_ptr<std::vector<std::unique_ptr<StreamType>>>
          substream_types) {
    return std::unique_ptr<StreamType>(
        new MultiplexedStreamType(
            std::move(multiplex_type),
            std::move(substream_types)));
  }

  MultiplexedStreamType(
      std::unique_ptr<StreamType> multiplex_type,
      std::unique_ptr<std::vector<std::unique_ptr<StreamType>>>
          substream_types);

  ~MultiplexedStreamType() override;

  const MultiplexedStreamType* multiplexed() const override;

  const std::unique_ptr<StreamType>& multiplex_type() const {
    return multiplex_type_;
  }

  const std::unique_ptr<std::vector<std::unique_ptr<StreamType>>>&
      substream_types() const {
    return substream_types_;
  }

  std::unique_ptr<StreamType> Clone() const override;

private:
  std::unique_ptr<StreamType> multiplex_type_;
  std::unique_ptr<std::vector<std::unique_ptr<StreamType>>> substream_types_;
};

// Describes the type of a multiplexed stream.
class MultiplexedStreamTypeSet : public StreamTypeSet {
public:
  static std::unique_ptr<StreamTypeSet> Create(
      std::unique_ptr<StreamTypeSet> multiplex_type_set,
      std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>
          substream_type_sets) {
    return std::unique_ptr<StreamTypeSet>(
        new MultiplexedStreamTypeSet(
            std::move(multiplex_type_set),
            std::move(substream_type_sets)));
  }

  MultiplexedStreamTypeSet(
      std::unique_ptr<StreamTypeSet> multiplex_type_set,
      std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>
          substream_type_sets);

  ~MultiplexedStreamTypeSet() override;

  const MultiplexedStreamTypeSet* multiplexed() const override;

  const std::unique_ptr<StreamTypeSet>& multiplex_type_set() const {
    return multiplex_type_set_;
  }

  const std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>&
      substream_type_sets() const {
    return substream_type_sets_;
  }

  std::unique_ptr<StreamTypeSet> Clone() const override;

private:
  std::unique_ptr<StreamTypeSet> multiplex_type_set_;
  std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>
      substream_type_sets_;
};

// Describes the type of an LPCM stream.
class LpcmStreamType : public StreamType {
 public:
  enum class SampleFormat {
    kUnknown,
    kAny,
    kUnsigned8,
    kSigned16,
    kSigned24In32,
    kFloat
  };

  static std::unique_ptr<StreamType> Create(
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second) {
    return std::unique_ptr<StreamType>(new LpcmStreamType(
        sample_format,
        channels,
        frames_per_second));
  }

  LpcmStreamType(
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second);

  ~LpcmStreamType() override;

  const LpcmStreamType* lpcm() const override;

  SampleFormat sample_format() const {
    return sample_format_;
  }

  uint32_t channels() const {
    return channels_;
  }

  uint32_t frames_per_second() const {
    return frames_per_second_;
  }

  uint32_t sample_size() const {
    return sample_size_;
  }

  uint32_t bytes_per_frame() const {
    return sample_size_ * channels_;
  }

  uint64_t min_buffer_size(uint64_t frame_count) const {
    return frame_count * sample_size_ * channels_;
  }

  static uint32_t SampleSizeFromFormat(SampleFormat sample_format);

  std::unique_ptr<StreamType> Clone() const override;

 protected:
  LpcmStreamType(
      Scheme scheme,
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second);

 private:
  SampleFormat sample_format_;
  uint32_t channels_;
  uint32_t frames_per_second_;
  uint32_t sample_size_;
};

// Describes a set of LPCM stream types.
class LpcmStreamTypeSet : public StreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(
      LpcmStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second) {
    return std::unique_ptr<StreamTypeSet>(new LpcmStreamTypeSet(
        sample_format,
        channels,
        frames_per_second));
  }

  LpcmStreamTypeSet(
      LpcmStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second);

  ~LpcmStreamTypeSet() override;

  const LpcmStreamTypeSet* lpcm() const override;

  LpcmStreamType::SampleFormat sample_format() const {
    return sample_format_;
  }

  Range<uint32_t> channels() const {
    return channels_;
  }

  Range<uint32_t> frames_per_second() const {
    return frames_per_second_;
  }

  bool contains(const LpcmStreamType& type) const;

  std::unique_ptr<StreamTypeSet> Clone() const override;

 protected:
  LpcmStreamTypeSet(
      StreamType::Scheme scheme,
      LpcmStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second);

 private:
  LpcmStreamType::SampleFormat sample_format_;
  Range<uint32_t> channels_;
  Range<uint32_t> frames_per_second_;
};

// Describes the type of a compressed audio stream.
class CompressedAudioStreamType : public LpcmStreamType {
 public:
  enum class AudioEncoding {
    kUnknown,
    kAny,
    kVorbis
  };

  static std::unique_ptr<StreamType> Create(
      AudioEncoding encoding,
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second,
      std::unique_ptr<Bytes> encoding_details) {
    return std::unique_ptr<StreamType>(new CompressedAudioStreamType(
        encoding,
        sample_format,
        channels,
        frames_per_second,
        std::move(encoding_details)));
  }

  CompressedAudioStreamType(
    AudioEncoding encoding,
    SampleFormat sample_format,
    uint32_t channels,
    uint32_t frames_per_second,
    std::unique_ptr<Bytes> encoding_details);

  ~CompressedAudioStreamType() override;

  const CompressedAudioStreamType* compressed_audio() const override;

  AudioEncoding encoding() const {
    return encoding_;
  }

  const std::unique_ptr<Bytes>& encoding_details() const {
    return encoding_details_;
  }

  std::unique_ptr<StreamType> Clone() const override;

 private:
  AudioEncoding encoding_;
  std::unique_ptr<Bytes> encoding_details_;
};

// Describes a set of compressed audio stream types.
class CompressedAudioStreamTypeSet : public LpcmStreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(
      CompressedAudioStreamType::AudioEncoding encoding,
      CompressedAudioStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second) {
    return std::unique_ptr<StreamTypeSet>(new CompressedAudioStreamTypeSet(
        encoding,
        sample_format,
        channels,
        frames_per_second));
  }

  CompressedAudioStreamTypeSet(
    CompressedAudioStreamType::AudioEncoding encoding,
    CompressedAudioStreamType::SampleFormat sample_format,
    Range<uint32_t> channels,
    Range<uint32_t> frames_per_second);

  ~CompressedAudioStreamTypeSet() override;

  const CompressedAudioStreamTypeSet* compressed_audio() const override;

  CompressedAudioStreamType::AudioEncoding encoding() const {
    return encoding_;
  }

  bool contains(const CompressedAudioStreamType& type) const;

  std::unique_ptr<StreamTypeSet> Clone() const override;

 private:
  CompressedAudioStreamType::AudioEncoding encoding_;
};

// Describes the type of a video stream.
class VideoStreamType : public StreamType {
 public:
  enum class VideoEncoding {
    kUnknown,
    kAny,
    kTheora,
    kVp8,
  };

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
      VideoEncoding encoding,
      VideoProfile profile,
      PixelFormat pixel_format,
      ColorSpace color_space,
      uint32_t width,
      uint32_t height,
      uint32_t coded_width,
      uint32_t coded_height,
      std::unique_ptr<Bytes> encoding_details) {
    return std::unique_ptr<StreamType>(new VideoStreamType(
        encoding,
        profile,
        pixel_format,
        color_space,
        width,
        height,
        coded_width,
        coded_height,
        std::move(encoding_details)));
  }

  VideoStreamType(
    VideoEncoding encoding,
    VideoProfile profile,
    PixelFormat pixel_format,
    ColorSpace color_space,
    uint32_t width,
    uint32_t height,
    uint32_t coded_width,
    uint32_t coded_height,
    std::unique_ptr<Bytes> encoding_details);

  ~VideoStreamType() override;

  const VideoStreamType* video() const override;

  VideoEncoding encoding() const {
    return encoding_;
  }

  VideoProfile profile() const {
    return profile_;
  }

  PixelFormat pixel_format() const {
    return pixel_format_;
  }

  ColorSpace color_space() const {
    return color_space_;
  }

  uint32_t width() const {
    return width_;
  }

  uint32_t height() const {
    return height_;
  }

  uint32_t coded_width() const {
    return coded_width_;
  }

  uint32_t coded_height() const {
    return coded_height_;
  }

  const std::unique_ptr<Bytes>& encoding_details() const {
    return encoding_details_;
  }

  std::unique_ptr<StreamType> Clone() const override;

 private:
  VideoEncoding encoding_;
  VideoProfile profile_;
  PixelFormat pixel_format_;
  ColorSpace color_space_;
  uint32_t width_;
  uint32_t height_;
  uint32_t coded_width_;
  uint32_t coded_height_;
  std::unique_ptr<Bytes> encoding_details_;
};

// Describes a set of video stream types.
class VideoStreamTypeSet : public StreamTypeSet {
 public:
  static std::unique_ptr<StreamTypeSet> Create(
      VideoStreamType::VideoEncoding encoding,
      Range<uint32_t> width,
      Range<uint32_t> height) {
    return std::unique_ptr<StreamTypeSet>(new VideoStreamTypeSet(
        encoding,
        width,
        height));
  }

  VideoStreamTypeSet(
    VideoStreamType::VideoEncoding encoding,
    Range<uint32_t> width,
    Range<uint32_t> height);

  ~VideoStreamTypeSet() override;

  const VideoStreamTypeSet* video() const override;

  VideoStreamType::VideoEncoding encoding() const {
    return encoding_;
  }

  Range<uint32_t> width() const {
    return width_;
  }

  Range<uint32_t> height() const {
    return height_;
  }

  std::unique_ptr<StreamTypeSet> Clone() const override;

 private:
  VideoStreamType::VideoEncoding encoding_;
  Range<uint32_t> width_;
  Range<uint32_t> height_;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_STREAM_TYPE_H_
