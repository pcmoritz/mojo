// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_PARTS_FILE_READER_H_
#define SERVICES_MEDIA_FRAMEWORK_PARTS_FILE_READER_H_

#include "services/media/framework/parts/reader.h"

namespace mojo {
namespace media {

// Reads raw data from a file.
class FileReader : public Reader {
 public:
  static std::shared_ptr<Reader> Create() {
    return std::shared_ptr<Reader>(new FileReader());
  }

  ~FileReader() override;

  // Reader implementation.
  Result Init(const GURL& gurl) override;

  size_t Read(uint8_t* buffer, size_t bytes_to_read) override;

  int64_t GetPosition() const override;

  int64_t SetPosition(int64_t position) override;

  size_t GetSize() const override;

  bool CanSeek() const override;

 private:
  FileReader() {}

  FILE* file_;
  size_t size_;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_PARTS_FILE_READER_H_
