// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_IO_H_
#define SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_IO_H_

#include "services/media/framework/parts/reader.h"
extern "C" {
#include "third_party/ffmpeg/libavformat/avio.h"
}

namespace mojo {
namespace media {

struct AVIOContextDeleter {
  void operator()(AVIOContext* context) const {
    av_free(context->buffer);
    av_free(context);
  }
};

using AvioContextPtr = std::unique_ptr<AVIOContext, AVIOContextDeleter>;

// Creates an ffmpeg avio_context for a given reader.
AvioContextPtr CreateAvioContext(Reader* reader);

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_FFMPEG_FFMPEG_IO_H_
