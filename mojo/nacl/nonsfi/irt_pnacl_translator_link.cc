// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <fcntl.h>

#include "base/files/file_util.h"
#include "base/logging.h"
#include "mojo/nacl/nonsfi/irt_mojo_nonsfi.h"
#include "mojo/public/cpp/bindings/string.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "native_client/src/untrusted/irt/irt_dev.h"
#include "services/nacl/pnacl_link.mojom.h"

namespace {

typedef int (*LinkerCallback)(int, const int*, int);

class PexeLinkerImpl : public mojo::nacl::PexeLinker {
 public:
  PexeLinkerImpl(mojo::ScopedMessagePipeHandle handle, LinkerCallback func)
      : func_(func), strong_binding_(this, handle.Pass()) {}
  void PexeLink(const mojo::String& object_file_name,
                const mojo::Callback<void(mojo::String)>& callback)
      override {
    // Create a temporary .nexe file which will be the result of calling our
    // linker.
    base::FilePath nexe_file_name;
    if (!CreateTemporaryFile(&nexe_file_name))
      LOG(FATAL) << "Could not create temporary nexe file";
    int nexe_file_fd = open(nexe_file_name.value().c_str(), O_RDWR);
    if (nexe_file_fd < 0)
      LOG(FATAL) << "Could not create temp file for linked nexe";

    // Open our temporary object file. Additionally, unlink it, since it is a
    // temporary file that is no longer needed after it is opened.
    size_t obj_file_fd_count = 1;
    int obj_file_fd = open(object_file_name.get().c_str(), O_RDONLY);
    if (unlink(object_file_name.get().c_str()))
      LOG(FATAL) << "Could not unlink temporary object file";
    if (obj_file_fd < 0)
      LOG(FATAL) << "Could not open object file";

    if (func_(nexe_file_fd, &obj_file_fd, obj_file_fd_count))
      LOG(FATAL) << "Error calling func on object file";

    // Return the name of the nexe file.
    callback.Run(mojo::String(nexe_file_name.value()));
  }
 private:
  LinkerCallback func_;
  mojo::StrongBinding<mojo::nacl::PexeLinker> strong_binding_;
};

void ServeLinkRequest(LinkerCallback func) {
  // Acquire the handle -- this is our mechanism to contact the
  // content handler which called us.
  MojoHandle handle;
  nacl::MojoGetInitialHandle(&handle);

  // Convert the MojoHandle into a ScopedMessagePipeHandle, and use that to
  // implement the PexeLinker interface.
  PexeLinkerImpl impl(
      mojo::ScopedMessagePipeHandle(mojo::MessagePipeHandle(handle)).Pass(),
      func);
  mojo::RunLoop::current()->RunUntilIdle();
}

}  // namespace anonymous

namespace nacl {

const struct nacl_irt_private_pnacl_translator_link
    nacl_irt_private_pnacl_translator_link = {
  ServeLinkRequest
};

}  // namespace nacl