// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_FFMPEG_AV_CODEC_CONTEXT_H_
#define SERVICES_MEDIA_FRAMEWORK_FFMPEG_AV_CODEC_CONTEXT_H_

#include "services/media/framework/stream_type.h"
extern "C" {
#include "third_party/ffmpeg/libavformat/avformat.h"
}

namespace mojo {
namespace media {

struct AVCodecContextDeleter {
  void operator()(AVCodecContext* context) const {
    avcodec_free_context(&context);
  }
};

using AvCodecContextPtr =
    std::unique_ptr<AVCodecContext, AVCodecContextDeleter>;

struct AvCodecContext {
  static AvCodecContextPtr Create(const StreamType& stream_type);

  static std::unique_ptr<StreamType> GetStreamType(const AVCodecContext& from);
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_FFMPEG_AV_CODEC_CONTEXT_H_
