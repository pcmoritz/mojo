// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_DART_EMBEDDER_IO_FILTER_H_
#define MOJO_DART_EMBEDDER_IO_FILTER_H_

#include "dart/runtime/include/dart_api.h"
#include "mojo/public/cpp/system/macros.h"
#include "third_party/zlib/zlib.h"

namespace mojo {
namespace dart {

class Filter {
 public:
  virtual ~Filter() {}

  virtual bool Init() = 0;

  /**
   * On a successful call to Process, Process will take ownership of data. On
   * successive calls to either Processed or ~Filter, data will be freed with
   * a delete[] call.
   */
  virtual bool Process(uint8_t* data, intptr_t length) = 0;
  virtual intptr_t Processed(uint8_t* buffer, intptr_t length, bool finish,
                             bool end) = 0;

  static Dart_Handle SetFilterPointerNativeField(Dart_Handle filter,
                                                 Filter* filter_pointer);
  static Dart_Handle GetFilterPointerNativeField(Dart_Handle filter,
                                                 Filter** filter_pointer);

  bool initialized() const { return initialized_; }
  void set_initialized(bool value) { initialized_ = value; }
  uint8_t* processed_buffer() { return processed_buffer_; }
  intptr_t processed_buffer_size() const { return kFilterBufferSize; }

 protected:
  Filter() : initialized_(false) {}

 private:
  static const intptr_t kFilterBufferSize = 65536;
  uint8_t processed_buffer_[kFilterBufferSize];
  bool initialized_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(Filter);
};

class ZLibDeflateFilter : public Filter {
 public:
  ZLibDeflateFilter(bool gzip, int32_t level, int32_t window_bits,
                    int32_t mem_level, int32_t strategy,
                    uint8_t* dictionary, intptr_t dictionary_length, bool raw)
      : gzip_(gzip), level_(level), window_bits_(window_bits),
        mem_level_(mem_level), strategy_(strategy), dictionary_(dictionary),
        dictionary_length_(dictionary_length), raw_(raw), current_buffer_(NULL)
    {}
  virtual ~ZLibDeflateFilter();

  virtual bool Init();
  virtual bool Process(uint8_t* data, intptr_t length);
  virtual intptr_t Processed(uint8_t* buffer, intptr_t length, bool finish,
                             bool end);

 private:
  const bool gzip_;
  const int32_t level_;
  const int32_t window_bits_;
  const int32_t mem_level_;
  const int32_t strategy_;
  uint8_t* dictionary_;
  const intptr_t dictionary_length_;
  const bool raw_;
  uint8_t* current_buffer_;
  z_stream stream_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(ZLibDeflateFilter);
};

class ZLibInflateFilter : public Filter {
 public:
  ZLibInflateFilter(int32_t window_bits, uint8_t* dictionary,
                    intptr_t dictionary_length, bool raw)
      : window_bits_(window_bits), dictionary_(dictionary),
        dictionary_length_(dictionary_length), raw_(raw), current_buffer_(NULL)
    {}
  virtual ~ZLibInflateFilter();

  virtual bool Init();
  virtual bool Process(uint8_t* data, intptr_t length);
  virtual intptr_t Processed(uint8_t* buffer, intptr_t length, bool finish,
                             bool end);

 private:
  const int32_t window_bits_;
  uint8_t* dictionary_;
  const intptr_t dictionary_length_;
  const bool raw_;
  uint8_t* current_buffer_;
  z_stream stream_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(ZLibInflateFilter);
};

}  // namespace dart
}  // namespace mojo

#endif  // MOJO_DART_EMBEDDER_IO_FILTER_H_