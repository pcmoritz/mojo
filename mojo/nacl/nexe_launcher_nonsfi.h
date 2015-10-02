// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_NACL_NEXE_LAUNCHER_NONSFI_H_
#define MOJO_NACL_NEXE_LAUNCHER_NONSFI_H_

#include "mojo/public/c/system/types.h"

namespace nacl {

/**
 * Takes a fd to a nexe, and launches the nexe with the given
 * MojoHandle.
 */
void MojoLaunchNexeNonsfi(int nexe_fd, MojoHandle initial_handle);

} // namespace nacl

#endif  // MOJO_NACL_NEXE_LAUNCHER_NONSFI_H_
