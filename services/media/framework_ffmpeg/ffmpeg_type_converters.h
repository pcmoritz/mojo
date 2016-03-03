// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_TYPE_CONVERTERS_H_
#define SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_TYPE_CONVERTERS_H_

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

// We don't specialize TypeConverter here, because specializations have to
// occur in the same namespace as the original template (mojo::, in this case).

// Creates a MediaType from an AVCodecContext.
std::unique_ptr<StreamType> StreamTypeFromAVCodecContext(
    const AVCodecContext& from);

// Creates an AVCodecContext from a StreamType.
AvCodecContextPtr AVCodecContextFromStreamType(
    const StreamType& stream_type);

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_TYPE_CONVERTERS_H_
