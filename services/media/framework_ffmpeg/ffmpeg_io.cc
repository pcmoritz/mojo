// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/parts/reader.h"
#include "services/media/framework_ffmpeg/ffmpeg_init.h"
#include "services/media/framework_ffmpeg/ffmpeg_io.h"
extern "C" {
#include "third_party/ffmpeg/libavformat/avio.h"
}

namespace mojo {
namespace media {

static int AvioRead(void* opaque, uint8_t* buf, int buf_size);
static int64_t AvioSeek(void* opaque, int64_t offset, int whence);

AvioContextPtr CreateAvioContext(Reader* reader) {
  // Internal buffer size used by AVIO for reading.
  const int kBufferSize = 32 * 1024;

  InitFfmpeg();

  AVIOContext* result = avio_alloc_context(
      static_cast<unsigned char*>(av_malloc(kBufferSize)),
      kBufferSize,
      0, // write_flag
      reader, // opaque
      &AvioRead,
      nullptr,
      &AvioSeek);

  // Ensure FFmpeg only tries to seek when we know how.
  result->seekable = reader->CanSeek() ? AVIO_SEEKABLE_NORMAL : 0;

  // Ensure writing is disabled.
  result->write_flag = 0;

  return AvioContextPtr(result);
}

// Performs a read operation using the signature required for avio.
static int AvioRead(void* opaque, uint8_t* buf, int buf_size) {
  Reader* reader = reinterpret_cast<Reader*>(opaque);
  int result = reader->Read(buf, buf_size);
  if (result < 0) {
    result = AVERROR(EIO);
  }
  return result;
}

// Performs a seek operation using the signature required for avio.
static int64_t AvioSeek(void* opaque, int64_t offset, int whence) {
  Reader* reader = reinterpret_cast<Reader*>(opaque);

  if (whence == AVSEEK_SIZE) {
    int64_t result = reader->GetSize();
    if (result == -1) {
      return AVERROR(EIO);
    }
    return result;
  }

  int64_t base;
  switch (whence) {
    case SEEK_SET:
      base = 0;
      break;

    case SEEK_CUR:
      base = reader->GetPosition();
      if (base == -1) {
        return AVERROR(EIO);
      }
      break;

    case SEEK_END:
      base = reader->GetSize();
      if (base == -1) {
        return AVERROR(EIO);
      }
      break;

    default:
      NOTREACHED();
      return AVERROR(EIO);
  }

  int64_t result = reader->SetPosition(base + offset);
  if (result == -1) {
    return AVERROR(EIO);
  }

  return result;
}

} // namespace media
} // namespace mojo
