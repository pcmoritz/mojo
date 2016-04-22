// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/files/files_test_base.h"

#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/files/interfaces/files.mojom.h"
#include "mojo/services/files/interfaces/types.mojom.h"

namespace mojo {
namespace files {

FilesTestBase::FilesTestBase() {}

FilesTestBase::~FilesTestBase() {}

void FilesTestBase::SetUp() {
  test::ApplicationTestBase::SetUp();
  // TODO(vtl): Fix |ConnectToService()|.
  FilesPtr files_async;
  application_impl()->ConnectToService("mojo:files", &files_async);
  files_ =
      SynchronousInterfacePtr<Files>::Create(files_async.PassInterfaceHandle());
}

void FilesTestBase::GetTemporaryRoot(
    SynchronousInterfacePtr<Directory>* directory) {
  Error error = Error::INTERNAL;
  ASSERT_TRUE(
      files_->OpenFileSystem(nullptr, GetSynchronousProxy(directory), &error));
  ASSERT_EQ(Error::OK, error);
}

void FilesTestBase::GetAppPersistentCacheRoot(
    SynchronousInterfacePtr<Directory>* directory) {
  Error error = Error::INTERNAL;
  ASSERT_TRUE(files_->OpenFileSystem("app_persistent_cache",
                                     GetSynchronousProxy(directory), &error));
  ASSERT_EQ(Error::OK, error);
}

}  // namespace files
}  // namespace mojo
