// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_NACL_SFI_NACL_BINDINGS_MOJO_SYSCALL_H_
#define MOJO_NACL_SFI_NACL_BINDINGS_MOJO_SYSCALL_H_

#include "mojo/public/c/system/handle.h"
#include "mojo/public/c/system/result.h"

// Injects a NaClDesc for Mojo support and sets a MojoHandle to be provided to
// untrusted code as a "service provider" MojoHandle.  This provides the
// implementation of the Mojo system API outside the NaCl sandbox and allows
// untrusted code to communicate with Mojo interfaces outside the sandbox or in
// other processes.
MojoResult InjectMojo(struct NaClApp* nap, MojoHandle handle);

// Injects a "disabled" NaClDesc for Mojo support. This is to make debugging
// more straightforward in the case where Mojo is not enabled for NaCl plugins.
void InjectDisabledMojo(struct NaClApp* nap);

#endif  // MOJO_NACL_SFI_NACL_BINDINGS_MOJO_SYSCALL_H_
