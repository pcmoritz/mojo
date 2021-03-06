// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "shell/shell_test_base.h"

#include "base/bind.h"
#include "base/command_line.h"
#include "base/files/file_path.h"
#include "base/files/file_util.h"
#include "base/logging.h"
#include "base/path_service.h"
#include "build/build_config.h"
#include "shell/filename_util.h"
#include "url/gurl.h"

namespace shell {
namespace test {

namespace {

void QuitIfRunning() {
  if (base::MessageLoop::current() &&
      base::MessageLoop::current()->is_running()) {
    base::MessageLoop::current()->QuitWhenIdle();
  }
}

}  // namespace

ShellTestBase::ShellTestBase() {}

ShellTestBase::~ShellTestBase() {}

void ShellTestBase::SetUp() {
  CHECK(shell_context_.Init());
  SetUpTestApplications();
}

void ShellTestBase::TearDown() {
  shell_context_.Shutdown();
}

mojo::ScopedMessagePipeHandle ShellTestBase::ConnectToService(
    const GURL& application_url,
    const std::string& service_name) {
  mojo::ServiceProviderPtr services;
  shell_context_.application_manager()->ConnectToApplication(
      application_url, GURL(), mojo::GetProxy(&services),
      base::Bind(&QuitIfRunning));
  mojo::MessagePipe pipe;
  services->ConnectToService(service_name, pipe.handle1.Pass());
  return pipe.handle0.Pass();
}

#if !defined(OS_ANDROID)
void ShellTestBase::SetUpTestApplications() {
  // Set the URLResolver origin to be the same as the base file path for
  // local files. This is primarily for test convenience, so that references
  // to unknown mojo: urls that do not have specific local file or custom
  // mappings registered on the URL resolver are treated as shared libraries.
  base::FilePath service_dir;
  CHECK(PathService::Get(base::DIR_MODULE, &service_dir));
  shell_context_.url_resolver()->SetMojoBaseURL(FilePathToFileURL(service_dir));
}
#endif

}  // namespace test
}  // namespace shell
