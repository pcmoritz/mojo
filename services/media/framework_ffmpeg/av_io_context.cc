// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/parts/reader.h"
#include "services/media/framework_ffmpeg/av_io_context.h"
#include "services/media/framework_ffmpeg/ffmpeg_init.h"
extern "C" {
#include "third_party/ffmpeg/libavformat/avio.h"
}

namespace mojo {
namespace media {

void AVIOContextDeleter::operator()(AVIOContext* context) const {
  AvIoContext* av_io_context = reinterpret_cast<AvIoContext*>(context->opaque);
  DCHECK(av_io_context);
  delete av_io_context;
  av_free(context->buffer);
  av_free(context);
}

// static
AvIoContextPtr AvIoContext::Create(std::shared_ptr<Reader> reader) {
  // Internal buffer size used by AVIO for reading.
  constexpr int kBufferSize = 32 * 1024;

  InitFfmpeg();

  AVIOContext* result = avio_alloc_context(
      static_cast<unsigned char*>(av_malloc(kBufferSize)), kBufferSize,
      0,  // write_flag
      new AvIoContext(reader), &Read, nullptr, &Seek);

  // Ensure FFmpeg only tries to seek when we know how.
  result->seekable = reader->CanSeek() ? AVIO_SEEKABLE_NORMAL : 0;

  // Ensure writing is disabled.
  result->write_flag = 0;

  return AvIoContextPtr(result);
}

// static
int AvIoContext::Read(void* opaque, uint8_t* buf, int buf_size) {
  AvIoContext* av_io_context = reinterpret_cast<AvIoContext*>(opaque);
  return av_io_context->Read(buf, buf_size);
}

// static
int64_t AvIoContext::Seek(void* opaque, int64_t offset, int whence) {
  AvIoContext* av_io_context = reinterpret_cast<AvIoContext*>(opaque);
  return av_io_context->Seek(offset, whence);
}

AvIoContext::~AvIoContext() {}

AvIoContext::AvIoContext(std::shared_ptr<Reader> reader) : reader_(reader) {
  can_seek_ = reader_->CanSeek();

  size_t size = reader_->GetSize();
  size_ = size == Reader::kFailed ? -1 : static_cast<int64_t>(size);
}

int AvIoContext::Read(uint8_t* buffer, size_t bytes_to_read) {
  size_t bytes_read = reader_->Read(buffer, bytes_to_read);
  if (bytes_read == Reader::kFailed) {
    LOG(ERROR) << "read failed";
    return AVERROR(EIO);
  }
  position_ += bytes_read;
  return bytes_read;
}

int64_t AvIoContext::Seek(int64_t offset, int whence) {
  switch (whence) {
    case SEEK_SET:
      position_ = offset;
      break;
    case SEEK_CUR:
      position_ += offset;
      break;
    case SEEK_END:
      if (size_ == -1) {
        return AVERROR(EIO);
      }
      position_ = size_ + offset;
      break;
    case AVSEEK_SIZE:
      if (size_ == -1) {
        return AVERROR(EIO);
      }
      return size_;
    default:
      NOTREACHED();
      return AVERROR(EIO);
  }

  CHECK(size_ == -1 || position_ < size_) << "position out of range";
  int64_t result = reader_->SetPosition(position_);
  if (result == -1) {
    LOG(ERROR) << "seek failed";
    return AVERROR(EIO);
  }
  return position_;
}

}  // namespace media
}  // namespace mojo
