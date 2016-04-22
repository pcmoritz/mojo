// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_FILES_FILES_TEST_BASE_H_
#define SERVICES_FILES_FILES_TEST_BASE_H_

#include <type_traits>

#include "base/macros.h"
#include "mojo/public/cpp/application/application_test_base.h"
#include "mojo/public/cpp/bindings/synchronous_interface_ptr.h"
#include "mojo/services/files/interfaces/directory.mojom-sync.h"
#include "mojo/services/files/interfaces/files.mojom-sync.h"

namespace mojo {
namespace files {

// TODO(vtl): Stuff copied from mojo/public/cpp/bindings/lib/template_util.h.
typedef char YesType;

struct NoType {
  YesType dummy[2];
};

template <typename T>
struct IsMoveOnlyType {
  template <typename U>
  static YesType Test(const typename U::MoveOnlyTypeForCPP03*);

  template <typename U>
  static NoType Test(...);

  static const bool value =
      sizeof(Test<T>(0)) == sizeof(YesType) && !std::is_const<T>::value;
};

template <typename T>
typename std::enable_if<!IsMoveOnlyType<T>::value, T>::type& Forward(T& t) {
  return t;
}

template <typename T>
typename std::enable_if<IsMoveOnlyType<T>::value, T>::type Forward(T& t) {
  return t.Pass();
}
// TODO(vtl): (End of stuff copied from template_util.h.)

template <typename T1>
Callback<void(T1)> Capture(T1* t1) {
  return [t1](T1 got_t1) { *t1 = Forward(got_t1); };
}

template <typename T1, typename T2>
Callback<void(T1, T2)> Capture(T1* t1, T2* t2) {
  return [t1, t2](T1 got_t1, T2 got_t2) {
    *t1 = Forward(got_t1);
    *t2 = Forward(got_t2);
  };
}

class FilesTestBase : public test::ApplicationTestBase {
 public:
  FilesTestBase();
  ~FilesTestBase() override;

  void SetUp() override;

 protected:
  // Note: These have out parameters rather than returning
  // |SynchronousInterfacePtr<Directory>|, since |ASSERT_...()| doesn't work
  // with return values.
  void GetTemporaryRoot(SynchronousInterfacePtr<Directory>* directory);
  void GetAppPersistentCacheRoot(SynchronousInterfacePtr<Directory>* directory);

 private:
  SynchronousInterfacePtr<Files> files_;

  DISALLOW_COPY_AND_ASSIGN(FilesTestBase);
};

}  // namespace files
}  // namespace mojo

#endif  // SERVICES_FILES_FILES_TEST_BASE_H_
