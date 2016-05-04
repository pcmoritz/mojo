// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/system/handle_table.h"

#include <vector>

#include "mojo/edk/system/dispatcher.h"
#include "mojo/edk/system/handle.h"
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

  MojoHandle h = ht.AddHandle(Handle(d.Clone(), MOJO_HANDLE_RIGHT_NONE));
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

TEST(HandleTableTest, AddHandlePair) {
  HandleTable ht(1000u);

  auto d1 = MakeRefCounted<test::MockSimpleDispatcher>();
  auto d2 = MakeRefCounted<test::MockSimpleDispatcher>();

  auto hp = ht.AddHandlePair(Handle(d1.Clone(), MOJO_HANDLE_RIGHT_NONE),
                             Handle(d2.Clone(), MOJO_HANDLE_RIGHT_NONE));
  ASSERT_NE(hp.first, MOJO_HANDLE_INVALID);
  ASSERT_NE(hp.second, MOJO_HANDLE_INVALID);
  ASSERT_NE(hp.first, hp.second);

  RefPtr<Dispatcher> d;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(hp.first, &d));
  ASSERT_EQ(d1, d);

  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(hp.second, &d));
  ASSERT_EQ(d2, d);

  EXPECT_EQ(MOJO_RESULT_OK, d1->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d2->Close());
}

TEST(HandleTableTest, AddHandleTooMany) {
  HandleTable ht(2u);

  auto d1 = MakeRefCounted<test::MockSimpleDispatcher>();
  auto d2 = MakeRefCounted<test::MockSimpleDispatcher>();
  auto d3 = MakeRefCounted<test::MockSimpleDispatcher>();

  MojoHandle h1 = ht.AddHandle(Handle(d1.Clone(), MOJO_HANDLE_RIGHT_NONE));
  ASSERT_NE(h1, MOJO_HANDLE_INVALID);

  MojoHandle h2 = ht.AddHandle(Handle(d2.Clone(), MOJO_HANDLE_RIGHT_NONE));
  ASSERT_NE(h2, MOJO_HANDLE_INVALID);
  EXPECT_NE(h2, h1);

  // Table should be full; adding |d3| should fail.
  EXPECT_EQ(MOJO_HANDLE_INVALID,
            ht.AddHandle(Handle(d3.Clone(), MOJO_HANDLE_RIGHT_NONE)));

  // Remove |h2|/|d2|.
  RefPtr<Dispatcher> d;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h2, &d));
  ASSERT_EQ(d2, d);

  // Now adding |d3| should succeed.
  MojoHandle h3 = ht.AddHandle(Handle(d3.Clone(), MOJO_HANDLE_RIGHT_NONE));
  ASSERT_NE(h3, MOJO_HANDLE_INVALID);
  EXPECT_NE(h3, h1);
  // Note: |h3| may be equal to |h2| (handle values may be reused).

  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h1, &d));
  ASSERT_EQ(d1, d);

  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h3, &d));
  ASSERT_EQ(d3, d);

  EXPECT_EQ(MOJO_RESULT_OK, d1->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d2->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d3->Close());
}

TEST(HandleTableTest, AddHandlePairTooMany) {
  HandleTable ht(2u);

  auto d1 = MakeRefCounted<test::MockSimpleDispatcher>();
  auto d2 = MakeRefCounted<test::MockSimpleDispatcher>();
  auto d3 = MakeRefCounted<test::MockSimpleDispatcher>();
  auto d4 = MakeRefCounted<test::MockSimpleDispatcher>();

  auto hp = ht.AddHandlePair(Handle(d1.Clone(), MOJO_HANDLE_RIGHT_NONE),
                             Handle(d2.Clone(), MOJO_HANDLE_RIGHT_NONE));
  auto h1 = hp.first;
  auto h2 = hp.second;
  ASSERT_NE(h1, MOJO_HANDLE_INVALID);
  ASSERT_NE(h2, MOJO_HANDLE_INVALID);
  ASSERT_NE(h1, h2);

  // Table should be full; adding |d3| should fail.
  EXPECT_EQ(MOJO_HANDLE_INVALID,
            ht.AddHandle(Handle(d3.Clone(), MOJO_HANDLE_RIGHT_NONE)));

  // Adding |d3| and |d4| as a pair should also fail.
  auto hp2 = ht.AddHandlePair(Handle(d3.Clone(), MOJO_HANDLE_RIGHT_NONE),
                              Handle(d4.Clone(), MOJO_HANDLE_RIGHT_NONE));
  EXPECT_EQ(MOJO_HANDLE_INVALID, hp2.first);
  EXPECT_EQ(MOJO_HANDLE_INVALID, hp2.second);

  // Remove |h2|/|d2|.
  RefPtr<Dispatcher> d;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h2, &d));
  ASSERT_EQ(d2, d);

  // Trying to add |d3| and |d4| as a pair should still fail.
  hp2 = ht.AddHandlePair(Handle(d3.Clone(), MOJO_HANDLE_RIGHT_NONE),
                         Handle(d4.Clone(), MOJO_HANDLE_RIGHT_NONE));
  EXPECT_EQ(MOJO_HANDLE_INVALID, hp2.first);
  EXPECT_EQ(MOJO_HANDLE_INVALID, hp2.second);

  // Remove |h1|/|d1|.
  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h1, &d));
  ASSERT_EQ(d1, d);

  // Add |d3| and |d4| as a pair should now succeed fail.
  hp2 = ht.AddHandlePair(Handle(d3.Clone(), MOJO_HANDLE_RIGHT_NONE),
                         Handle(d4.Clone(), MOJO_HANDLE_RIGHT_NONE));
  auto h3 = hp2.first;
  auto h4 = hp2.second;
  ASSERT_NE(h3, MOJO_HANDLE_INVALID);
  ASSERT_NE(h4, MOJO_HANDLE_INVALID);
  ASSERT_NE(h3, h4);

  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h3, &d));
  ASSERT_EQ(d3, d);

  d = nullptr;
  ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(h4, &d));
  ASSERT_EQ(d4, d);

  EXPECT_EQ(MOJO_RESULT_OK, d1->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d2->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d3->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d4->Close());
}

TEST(HandleTableTest, AddHandleVector) {
  static constexpr size_t kNumHandles = 10u;

  HandleTable ht(1000u);

  HandleVector handles;
  std::vector<RefPtr<Dispatcher>> dispatchers;
  for (size_t i = 0u; i < kNumHandles; i++) {
    dispatchers.push_back(MakeRefCounted<test::MockSimpleDispatcher>());
    handles.push_back(
        Handle(dispatchers.back().Clone(), MOJO_HANDLE_RIGHT_NONE));
    ASSERT_TRUE(handles[i]) << i;
  }

  std::vector<MojoHandle> handle_values(kNumHandles, MOJO_HANDLE_INVALID);

  ASSERT_TRUE(ht.AddHandleVector(&handles, handle_values.data()));

  for (size_t i = 0u; i < kNumHandles; i++) {
    ASSERT_NE(handle_values[i], MOJO_HANDLE_INVALID) << i;

    RefPtr<Dispatcher> d;
    ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(handle_values[i], &d))
        << i;
    ASSERT_EQ(dispatchers[i], d) << i;

    EXPECT_EQ(MOJO_RESULT_OK, dispatchers[i]->Close()) << i;
  }
}

TEST(HandleTableTest, AddHandleVectorTooMany) {
  static constexpr size_t kHandleTableSize = 10u;
  static constexpr size_t kNumHandles = kHandleTableSize + 1u;

  HandleTable ht(kHandleTableSize);

  HandleVector handles;
  std::vector<RefPtr<Dispatcher>> dispatchers;
  for (size_t i = 0u; i < kNumHandles; i++) {
    dispatchers.push_back(MakeRefCounted<test::MockSimpleDispatcher>());
    handles.push_back(
        Handle(dispatchers.back().Clone(), MOJO_HANDLE_RIGHT_NONE));
    ASSERT_TRUE(handles[i]) << i;
  }

  std::vector<MojoHandle> handle_values(kNumHandles, MOJO_HANDLE_INVALID);

  EXPECT_FALSE(ht.AddHandleVector(&handles, handle_values.data()));

  handles.pop_back();
  handle_values.pop_back();

  ASSERT_TRUE(ht.AddHandleVector(&handles, handle_values.data()));

  for (size_t i = 0u; i < kNumHandles - 1u; i++) {
    ASSERT_NE(handle_values[i], MOJO_HANDLE_INVALID) << i;

    RefPtr<Dispatcher> d;
    ASSERT_EQ(MOJO_RESULT_OK, ht.GetAndRemoveDispatcher(handle_values[i], &d))
        << i;
    ASSERT_EQ(dispatchers[i], d) << i;
  }

  for (size_t i = 0u; i < kNumHandles; i++)
    EXPECT_EQ(MOJO_RESULT_OK, dispatchers[i]->Close()) << i;
}

}  // namespace
}  // namespace system
}  // namespace mojo
