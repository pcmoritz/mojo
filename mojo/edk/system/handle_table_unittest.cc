// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/system/handle_table.h"

#include "mojo/edk/system/dispatcher.h"
#include "mojo/edk/system/mock_simple_dispatcher.h"
#include "testing/gtest/include/gtest/gtest.h"

using mojo::util::MakeRefCounted;
using mojo::util::RefPtr;

namespace mojo {
namespace system {
namespace {

TEST(HandleTableTest, Basic) {
  HandleTable ht(1000u);

  RefPtr<Dispatcher> d = MakeRefCounted<test::MockSimpleDispatcher>();

  MojoHandle h = ht.AddDispatcher(d.get());
  ASSERT_NE(h, MOJO_HANDLE_INVALID);

  // Save the pointer value (without taking a ref), so we can check that we get
  // the same object back.
  Dispatcher* dv = d.get();
  // Reset this, to make sure that the handle table takes a ref.
  d = nullptr;

  EXPECT_EQ(MOJO_RESULT_OK, ht.GetDispatcher(h, &d));
  EXPECT_EQ(d.get(), dv);

  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h, &d));
  ASSERT_EQ(d.get(), dv);

  EXPECT_EQ(MOJO_RESULT_OK, d->Close());

  // We removed |h|, so it should no longer be valid.
  d = nullptr;
  EXPECT_EQ(MOJO_RESULT_INVALID_ARGUMENT, ht.GetDispatcher(h, &d));
}

TEST(HandleTableTest, TooManyHandles) {
  HandleTable ht(2u);

  auto d1 = MakeRefCounted<test::MockSimpleDispatcher>();
  auto d2 = MakeRefCounted<test::MockSimpleDispatcher>();
  auto d3 = MakeRefCounted<test::MockSimpleDispatcher>();

  MojoHandle h1 = ht.AddDispatcher(d1.get());
  ASSERT_NE(h1, MOJO_HANDLE_INVALID);

  MojoHandle h2 = ht.AddDispatcher(d2.get());
  ASSERT_NE(h2, MOJO_HANDLE_INVALID);
  EXPECT_NE(h2, h1);

  // Table should be full; adding |d3| should fail.
  EXPECT_EQ(MOJO_HANDLE_INVALID, ht.AddDispatcher(d3.get()));

  // Remove |h2|/|d2|.
  RefPtr<Dispatcher> d;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h2, &d));
  ASSERT_EQ(d, d2);

  // Now adding |d3| should succeed.
  MojoHandle h3 = ht.AddDispatcher(d3.get());
  ASSERT_NE(h3, MOJO_HANDLE_INVALID);
  EXPECT_NE(h3, h1);
  // Note: |h3| may be equal to |h2| (handle values may be reused).

  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h1, &d));
  ASSERT_EQ(d, d1);

  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h3, &d));
  ASSERT_EQ(d, d3);

  EXPECT_EQ(MOJO_RESULT_OK, d1->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d2->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d3->Close());
}

}  // namespace
}  // namespace system
}  // namespace mojo
