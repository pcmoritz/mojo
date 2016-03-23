// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_FFMPEG_AV_IO_CONTEXT_H_
#define SERVICES_MEDIA_FRAMEWORK_FFMPEG_AV_IO_CONTEXT_H_

#include "services/media/framework/parts/reader.h"
extern "C" {
#include "third_party/ffmpeg/libavformat/avio.h"
}

namespace mojo {
namespace media {

struct AVIOContextDeleter {
  void operator()(AVIOContext* context) const;
};

using AvIoContextPtr = std::unique_ptr<AVIOContext, AVIOContextDeleter>;

struct AvIoContext {
  // Creates an ffmpeg avio_context for a given reader.
  static AvIoContextPtr Create(std::shared_ptr<Reader> reader);

  // Performs a read operation using the signature required for avio.
  static int Read(void* opaque, uint8_t* buf, int buf_size);

  // Performs a seek operation using the signature required for avio.
  static int64_t Seek(void* opaque, int64_t offset, int whence);

  ~AvIoContext();

 private:
  AvIoContext(std::shared_ptr<Reader> reader);

  int Read(uint8_t* buffer, size_t bytes_to_read);

  int64_t Seek(int64_t offset, int whence);

  std::shared_ptr<Reader> reader_;
  bool can_seek_;
  int64_t size_;
  int64_t position_ = 0;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_FFMPEG_AV_IO_CONTEXT_H_
