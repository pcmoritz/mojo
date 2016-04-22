// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_TYPES_VIDEO_STREAM_TYPE_H_
#define SERVICES_MEDIA_FRAMEWORK_TYPES_VIDEO_STREAM_TYPE_H_

#include <cstring>
#include <memory>
#include <string>
#include <vector>

#include "base/logging.h"
#include "services/media/framework/types/stream_type.h"

namespace mojo {
namespace media {

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

  // Creates a VideoStreamType.
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

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_TYPES_VIDEO_STREAM_TYPE_H_
