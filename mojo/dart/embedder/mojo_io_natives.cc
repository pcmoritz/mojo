// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>
#include <string.h>
#include <limits>

#include "dart/runtime/include/dart_api.h"
#include "mojo/dart/embedder/builtin.h"
#include "mojo/dart/embedder/common.h"
#include "mojo/dart/embedder/io/filter.h"
#include "mojo/dart/embedder/io/internet_address.h"
#include "mojo/dart/embedder/mojo_dart_state.h"
#include "mojo/public/cpp/system/macros.h"

namespace mojo {
namespace dart {

#define MOJO_IO_NATIVE_LIST(V)                                                 \
  V(Filter_CreateZLibDeflate, 8)                                               \
  V(Filter_CreateZLibInflate, 4)                                               \
  V(Filter_End, 1)                                                             \
  V(Filter_Process, 4)                                                         \
  V(Filter_Processed, 3)                                                       \
  V(InternetAddress_Parse, 1)                                                  \
  V(InternetAddress_Reverse, 1)                                                \
  V(Platform_NumberOfProcessors, 0)                                            \
  V(Platform_OperatingSystem, 0)                                               \
  V(Platform_PathSeparator, 0)                                                 \
  V(Platform_LocalHostname, 0)                                                 \
  V(Platform_ExecutableName, 0)                                                \
  V(Platform_Environment, 0)                                                   \
  V(Platform_ExecutableArguments, 0)                                           \
  V(Platform_PackageRoot, 0)                                                   \
  V(Platform_GetVersion, 0)                                                    \
  V(Process_Pid, 0)                                                            \

MOJO_IO_NATIVE_LIST(DECLARE_FUNCTION);

static struct NativeEntries {
  const char* name;
  Dart_NativeFunction function;
  int argument_count;
} MojoEntries[] = {MOJO_IO_NATIVE_LIST(REGISTER_FUNCTION)};

Dart_NativeFunction MojoIoNativeLookup(Dart_Handle name,
                                       int argument_count,
                                       bool* auto_setup_scope) {
  const char* function_name = nullptr;
  Dart_Handle result = Dart_StringToCString(name, &function_name);
  DART_CHECK_VALID(result);
  assert(function_name != nullptr);
  assert(auto_setup_scope != nullptr);
  *auto_setup_scope = true;
  size_t num_entries = MOJO_ARRAYSIZE(MojoEntries);
  for (size_t i = 0; i < num_entries; ++i) {
    const struct NativeEntries& entry = MojoEntries[i];
    if (!strcmp(function_name, entry.name) &&
        (entry.argument_count == argument_count)) {
      return entry.function;
    }
  }
  return nullptr;
}

const uint8_t* MojoIoNativeSymbol(Dart_NativeFunction nf) {
  size_t num_entries = MOJO_ARRAYSIZE(MojoEntries);
  for (size_t i = 0; i < num_entries; ++i) {
    const struct NativeEntries& entry = MojoEntries[i];
    if (entry.function == nf) {
      return reinterpret_cast<const uint8_t*>(entry.name);
    }
  }
  return nullptr;
}

class IOBuffer {
 public:
  static Dart_Handle Allocate(intptr_t size, uint8_t **buffer) {
    uint8_t* data = Allocate(size);
    Dart_Handle result = Dart_NewExternalTypedData(
        Dart_TypedData_kUint8, data, size);
    Dart_NewWeakPersistentHandle(result, data, size, IOBuffer::Finalizer);

    if (Dart_IsError(result)) {
      Free(data);
      Dart_PropagateError(result);
    }
    if (buffer != NULL) {
      *buffer = data;
    }
    return result;
  }

  // Allocate IO buffer storage.
  static uint8_t* Allocate(intptr_t size) {
    return new uint8_t[size];
  }

  // Function for disposing of IO buffer storage. All backing storage
  // for IO buffers must be freed using this function.
  static void Free(void* buffer) {
    delete[] reinterpret_cast<uint8_t*>(buffer);
  }

  // Function for finalizing external byte arrays used as IO buffers.
  static void Finalizer(void* isolate_callback_data,
                        Dart_WeakPersistentHandle handle,
                        void* buffer) {
    Free(buffer);
  }

 private:
  DISALLOW_IMPLICIT_CONSTRUCTORS(IOBuffer);
};

static Filter* GetFilter(Dart_Handle filter_obj) {
  Filter* filter;
  Dart_Handle result = Filter::GetFilterPointerNativeField(filter_obj, &filter);
  if (Dart_IsError(result)) {
    Dart_PropagateError(result);
  }
  if (filter == NULL) {
    Dart_ThrowException(DartEmbedder::NewInternalError("Filter destroyed"));
  }
  return filter;
}

static void EndFilter(Dart_Handle filter_obj, Filter* filter) {
  Filter::SetFilterPointerNativeField(filter_obj, NULL);
  delete filter;
}

static uint8_t* copyDictionary(Dart_Handle dictionary_obj) {
  uint8_t* src = NULL;
  intptr_t size;
  Dart_TypedData_Type type;

  if (Dart_IsError(Dart_ListLength(dictionary_obj, &size))) {
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Failed to get the zlib dictionary length"));
  }

  uint8_t* dictionary = new uint8_t[size];

  if (dictionary == NULL) {
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Failed to allocate buffer for the zlib dictionary"));
  }

  Dart_Handle result = Dart_TypedDataAcquireData(
      dictionary_obj, &type, reinterpret_cast<void**>(&src), &size);
  if (!Dart_IsError(result)) {
    memmove(dictionary, src, size);
    Dart_TypedDataReleaseData(dictionary_obj);
  } else {
    if (Dart_IsError(Dart_ListGetAsBytes(dictionary_obj, 0, dictionary,
                                         size))) {
      Dart_ThrowException(DartEmbedder::NewInternalError(
          "Failed to get the zlib dictionary"));
    }
  }

  return dictionary;
}

void Filter_CreateZLibInflate(Dart_NativeArguments args) {
  Dart_Handle filter_obj = Dart_GetNativeArgument(args, 0);
  Dart_Handle window_bits_obj = Dart_GetNativeArgument(args, 1);
  int64_t window_bits = DartEmbedder::GetIntegerValue(window_bits_obj);
  Dart_Handle dict_obj = Dart_GetNativeArgument(args, 2);
  uint8_t* dictionary = NULL;
  intptr_t dictionary_length = 0;
  if (!Dart_IsNull(dict_obj)) {
    dictionary = copyDictionary(dict_obj);
    if (dictionary != NULL) {
      dictionary_length = 0;
      Dart_ListLength(dict_obj, &dictionary_length);
    }
  }
  Dart_Handle raw_obj = Dart_GetNativeArgument(args, 3);
  bool raw;
  if (Dart_IsError(Dart_BooleanValue(raw_obj, &raw))) {
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Failed to get 'raw' parameter"));
  }
  Filter* filter = new ZLibInflateFilter(static_cast<int32_t>(window_bits),
                                         dictionary, dictionary_length, raw);
  if (!filter->Init()) {
    delete filter;
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Failed to create ZLibInflateFilter"));
  }
  Dart_Handle result = Filter::SetFilterPointerNativeField(filter_obj, filter);
  if (Dart_IsError(result)) {
    delete filter;
    Dart_PropagateError(result);
  }
}

void Filter_CreateZLibDeflate(Dart_NativeArguments args) {
  Dart_Handle filter_obj = Dart_GetNativeArgument(args, 0);
  Dart_Handle gzip_obj = Dart_GetNativeArgument(args, 1);
  bool gzip = DartEmbedder::GetBooleanValue(gzip_obj);
  Dart_Handle level_obj = Dart_GetNativeArgument(args, 2);
  int64_t level = DartEmbedder::GetInt64ValueCheckRange(
      level_obj,
      std::numeric_limits<int32_t>::min(),
      std::numeric_limits<int32_t>::max());
  Dart_Handle window_bits_obj = Dart_GetNativeArgument(args, 3);
  int64_t window_bits = DartEmbedder::GetIntegerValue(window_bits_obj);
  Dart_Handle mLevel_obj = Dart_GetNativeArgument(args, 4);
  int64_t mem_level = DartEmbedder::GetIntegerValue(mLevel_obj);
  Dart_Handle strategy_obj = Dart_GetNativeArgument(args, 5);
  int64_t strategy = DartEmbedder::GetIntegerValue(strategy_obj);
  Dart_Handle dict_obj = Dart_GetNativeArgument(args, 6);
  uint8_t* dictionary = NULL;
  intptr_t dictionary_length = 0;
  if (!Dart_IsNull(dict_obj)) {
    dictionary = copyDictionary(dict_obj);
    if (dictionary != NULL) {
      dictionary_length = 0;
      Dart_ListLength(dict_obj, &dictionary_length);
    }
  }
  Dart_Handle raw_obj = Dart_GetNativeArgument(args, 7);
  bool raw = DartEmbedder::GetBooleanValue(raw_obj);
  Filter* filter = new ZLibDeflateFilter(gzip, static_cast<int32_t>(level),
                                         static_cast<int32_t>(window_bits),
                                         static_cast<int32_t>(mem_level),
                                         static_cast<int32_t>(strategy),
                                         dictionary, dictionary_length, raw);
  if (!filter->Init()) {
    delete filter;
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Failed to create ZLibDeflateFilter"));
  }
  Dart_Handle result = Filter::SetFilterPointerNativeField(filter_obj, filter);
  if (Dart_IsError(result)) {
    delete filter;
    Dart_PropagateError(result);
  }
}

void Filter_Process(Dart_NativeArguments args) {
  Dart_Handle filter_obj = Dart_GetNativeArgument(args, 0);
  Filter* filter = GetFilter(filter_obj);
  Dart_Handle data_obj = Dart_GetNativeArgument(args, 1);
  intptr_t start =
      DartEmbedder::GetIntptrValue(Dart_GetNativeArgument(args, 2));
  intptr_t end = DartEmbedder::GetIntptrValue(Dart_GetNativeArgument(args, 3));
  intptr_t chunk_length = end - start;
  intptr_t length;
  Dart_TypedData_Type type;
  uint8_t* buffer = NULL;
  Dart_Handle result = Dart_TypedDataAcquireData(
      data_obj, &type, reinterpret_cast<void**>(&buffer), &length);

  if (!Dart_IsError(result)) {
    DCHECK(type == Dart_TypedData_kUint8 || type == Dart_TypedData_kInt8);
    if (type != Dart_TypedData_kUint8 && type != Dart_TypedData_kInt8) {
      Dart_TypedDataReleaseData(data_obj);
      Dart_ThrowException(DartEmbedder::NewInternalError(
          "Invalid argument passed to Filter_Process"));
    }
    uint8_t* zlib_buffer = new uint8_t[chunk_length];
    if (zlib_buffer == NULL) {
      Dart_TypedDataReleaseData(data_obj);
      Dart_ThrowException(DartEmbedder::NewInternalError(
          "Failed to allocate buffer for zlib"));
    }
    memmove(zlib_buffer, buffer + start, chunk_length);
    Dart_TypedDataReleaseData(data_obj);
    buffer = zlib_buffer;
  } else {
    if (Dart_IsError(Dart_ListLength(data_obj, &length))) {
      Dart_ThrowException(DartEmbedder::NewInternalError(
          "Failed to get list length"));
    }
    buffer = new uint8_t[chunk_length];
    if (Dart_IsError(Dart_ListGetAsBytes(
            data_obj, start, buffer, chunk_length))) {
      delete[] buffer;
      Dart_ThrowException(DartEmbedder::NewInternalError(
          "Failed to get list bytes"));
    }
  }
  // Process will take ownership of buffer, if successful.
  if (!filter->Process(buffer, chunk_length)) {
    delete[] buffer;
    EndFilter(filter_obj, filter);
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Call to Process while still processing data"));
  }
}

void Filter_Processed(Dart_NativeArguments args) {
  Dart_Handle filter_obj = Dart_GetNativeArgument(args, 0);
  Filter* filter = GetFilter(filter_obj);
  Dart_Handle flush_obj = Dart_GetNativeArgument(args, 1);
  bool flush;
  if (Dart_IsError(Dart_BooleanValue(flush_obj, &flush))) {
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Failed to get 'flush' parameter"));
  }
  Dart_Handle end_obj = Dart_GetNativeArgument(args, 2);
  bool end;
  if (Dart_IsError(Dart_BooleanValue(end_obj, &end))) {
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Failed to get 'end' parameter"));
  }
  intptr_t read = filter->Processed(filter->processed_buffer(),
                                    filter->processed_buffer_size(),
                                    flush,
                                    end);
  if (read < 0) {
    // Error, end filter.
    EndFilter(filter_obj, filter);
    Dart_ThrowException(DartEmbedder::NewInternalError(
        "Filter error, bad data"));
  } else if (read == 0) {
    Dart_SetReturnValue(args, Dart_Null());
  } else {
    uint8_t* io_buffer;
    Dart_Handle result = IOBuffer::Allocate(read, &io_buffer);
    memmove(io_buffer, filter->processed_buffer(), read);
    Dart_SetReturnValue(args, result);
  }
}

void Filter_End(Dart_NativeArguments args) {
  Dart_Handle filter_obj = Dart_GetNativeArgument(args, 0);
  Filter* filter = GetFilter(filter_obj);
  EndFilter(filter_obj, filter);
}

void InternetAddress_Parse(Dart_NativeArguments arguments) {
  const char* address = DartEmbedder::GetStringArgument(arguments, 0);
  CHECK(address != nullptr);
  RawAddr raw;
  int type = strchr(address, ':') == nullptr ? InternetAddress::TYPE_IPV4
                                          : InternetAddress::TYPE_IPV6;
  intptr_t length = (type == InternetAddress::TYPE_IPV4) ?
      IPV4_RAW_ADDR_LENGTH : IPV6_RAW_ADDR_LENGTH;
  if (InternetAddress::Parse(type, address, &raw)) {
    Dart_SetReturnValue(arguments,
                        DartEmbedder::MakeUint8TypedData(&raw.bytes[0],
                                                         length));
  } else {
    DartEmbedder::SetNullReturn(arguments);
  }
}

void InternetAddress_Reverse(Dart_NativeArguments arguments) {
  uint8_t* addr = nullptr;
  intptr_t addr_len = 0;
  DartEmbedder::GetTypedDataListArgument(arguments, 0, &addr, &addr_len);
  if (addr_len == 0) {
    DartEmbedder::SetNullReturn(arguments);
    return;
  }
  // IPv4 or IPv6 address length.
  CHECK((addr_len == 4) || (addr_len == 16));
  RawAddr raw_addr;
  for (intptr_t i = 0; i < addr_len; i++) {
    raw_addr.bytes[i] = addr[i];
  }
  free(addr);

  const intptr_t kMaxHostLength = 1025;
  char host[kMaxHostLength];
  intptr_t error_code = 0;
  const char* error_description = nullptr;
  bool success = InternetAddress::Reverse(raw_addr, addr_len,
                                          &host[0], kMaxHostLength,
                                          &error_code, &error_description);
  // List of length 2.
  // [0] -> code (0 indicates success).
  // [1] -> error or host.
  Dart_Handle result_list = Dart_NewList(2);
  Dart_ListSetAt(result_list, 0, Dart_NewInteger(error_code));
  if (success) {
    Dart_ListSetAt(result_list, 1, DartEmbedder::NewCString(host));
  } else {
    Dart_ListSetAt(result_list, 1, DartEmbedder::NewCString(error_description));
  }
  Dart_SetReturnValue(arguments, result_list);
}

void Platform_NumberOfProcessors(Dart_NativeArguments arguments) {
  // TODO(johnmccutchan): Is an implementation needed?
  DartEmbedder::SetNullReturn(arguments);
}

void Platform_OperatingSystem(Dart_NativeArguments arguments) {
  // TODO(johnmccutchan): Is an implementation needed?
  DartEmbedder::SetNullReturn(arguments);
}

void Platform_PathSeparator(Dart_NativeArguments arguments) {
  // TODO(johnmccutchan): Is an implementation needed?
  DartEmbedder::SetNullReturn(arguments);
}

void Platform_LocalHostname(Dart_NativeArguments arguments) {
  // TODO(johnmccutchan): Is an implementation needed?
  DartEmbedder::SetNullReturn(arguments);
}

void Platform_ExecutableName(Dart_NativeArguments arguments) {
  // TODO(johnmccutchan): Is an implementation needed?
  DartEmbedder::SetNullReturn(arguments);
}

void Platform_Environment(Dart_NativeArguments arguments) {
  // TODO(johnmccutchan): Is an implementation needed?
  Dart_SetReturnValue(arguments, Dart_NewList(0));
}

void Platform_ExecutableArguments(Dart_NativeArguments arguments) {
  // TODO(johnmccutchan): Is an implementation needed?
  DartEmbedder::SetNullReturn(arguments);
}

void Platform_PackageRoot(Dart_NativeArguments arguments) {
  auto isolate_data = MojoDartState::Current();
  assert(isolate_data != nullptr);
  Dart_SetReturnValue(
      arguments,
      Dart_NewStringFromCString(isolate_data->package_root().c_str()));
}

void Platform_GetVersion(Dart_NativeArguments arguments) {
  // TODO(johnmccutchan): Consider incorporating Mojo version.
  Dart_SetReturnValue(arguments,
                      Dart_NewStringFromCString(Dart_VersionString()));
}

void Process_Pid(Dart_NativeArguments arguments) {
  // TODO(rudominer) After sandboxing is implemented getpid() will not return
  // the real pid. Most likely it will return the value 1. We need to decide
  // what behavior we want Dart's pid getter to have when sandboxed.
  pid_t pid = getpid();
  Dart_SetIntegerReturnValue(arguments, static_cast<int64_t>(pid));
}

}  // namespace dart
}  // namespace mojo
