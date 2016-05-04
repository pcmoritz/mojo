// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/services/media/common/cpp/linear_function.h"
#include "services/media/common/test/test_base.h"

namespace mojo {
namespace media {
namespace {

class LinearFunctionTest : public TestBase {
 public:
  // Verifies that a LinearFunction instantiated in three different ways with
  // the given arguments has the expected properties.
  void VerifyBasics(int64_t domain_basis,
                    int64_t range_basis,
                    uint32_t domain_delta,
                    uint32_t range_delta) {
    LinearFunction under_test_1(domain_basis, range_basis, domain_delta,
                                range_delta);
    VerifyBasics(under_test_1, domain_basis, range_basis, domain_delta,
                 range_delta);

    LinearFunction under_test_2(domain_basis, range_basis,
                                Ratio(range_delta, domain_delta));
    VerifyBasics(under_test_2, domain_basis, range_basis, domain_delta,
                 range_delta);

    LinearFunction under_test_3(Ratio(range_delta, domain_delta));
    VerifyBasics(under_test_3, 0, 0, domain_delta, range_delta);

    EXPECT_EQ(under_test_1, under_test_1);
    EXPECT_EQ(under_test_1, under_test_2);
    EXPECT_EQ(under_test_2, under_test_1);
    EXPECT_EQ(under_test_2, under_test_2);

    if (domain_basis == 0 && range_basis == 0) {
      EXPECT_EQ(under_test_1, under_test_3);
      EXPECT_EQ(under_test_2, under_test_3);
      EXPECT_EQ(under_test_3, under_test_1);
      EXPECT_EQ(under_test_3, under_test_2);
    } else {
      EXPECT_NE(under_test_1, under_test_3);
      EXPECT_NE(under_test_2, under_test_3);
      EXPECT_NE(under_test_3, under_test_1);
      EXPECT_NE(under_test_3, under_test_2);
    }
  }

  // Verifies that the given LinearFunction instantiated with the given
  // arguments has the expected properties.
  void VerifyBasics(const LinearFunction& under_test,
                    int64_t domain_basis,
                    int64_t range_basis,
                    uint32_t domain_delta,
                    uint32_t range_delta) {
    Ratio::Reduce(&range_delta, &domain_delta);
    EXPECT_EQ(domain_basis, under_test.domain_basis());
    EXPECT_EQ(range_basis, under_test.range_basis());
    EXPECT_EQ(domain_delta, under_test.domain_delta());
    EXPECT_EQ(range_delta, under_test.range_delta());
    EXPECT_EQ(domain_delta, under_test.slope().denominator());
    EXPECT_EQ(range_delta, under_test.slope().numerator());
  }

  // Verifies that the inverse of a LinearFunction instantiated in three
  // different ways with the given arguments has the expected properties.
  void VerifyInverse(int64_t domain_basis,
                     int64_t range_basis,
                     uint32_t domain_delta,
                     uint32_t range_delta) {
    LinearFunction under_test_1(domain_basis, range_basis, domain_delta,
                                range_delta);
    VerifyBasics(under_test_1.Inverse(), range_basis, domain_basis, range_delta,
                 domain_delta);

    LinearFunction under_test_2(domain_basis, range_basis,
                                Ratio(range_delta, domain_delta));
    VerifyBasics(under_test_2.Inverse(), range_basis, domain_basis, range_delta,
                 domain_delta);

    LinearFunction under_test_3(Ratio(range_delta, domain_delta));
    VerifyBasics(under_test_3.Inverse(), 0, 0, range_delta, domain_delta);
  }

  // Verifies that LinearFunction::Apply, in its various forms, works as
  // expected for the given arguments.
  void VerifyApply(int64_t domain_basis,
                   int64_t range_basis,
                   uint32_t domain_delta,
                   uint32_t range_delta,
                   int64_t domain_input,
                   int64_t expected_result) {
    // Verify the static method.
    EXPECT_EQ(
        expected_result,
        LinearFunction::Apply(domain_basis, range_basis,
                              Ratio(range_delta, domain_delta), domain_input));

    // Verify the instance method.
    LinearFunction under_test(domain_basis, range_basis, domain_delta,
                              range_delta);
    EXPECT_EQ(expected_result, under_test.Apply(domain_input));

    // Verify the operator.
    EXPECT_EQ(expected_result, under_test(domain_input));
  }

  // Verifies that LinearFunction::ApplyInverse, in its various forms, works as
  // expected for the given arguments.
  void VerifyApplyInverse(int64_t domain_basis,
                          int64_t range_basis,
                          uint32_t domain_delta,
                          uint32_t range_delta,
                          int64_t range_input,
                          int64_t expected_result) {
    // Verify the static method.
    EXPECT_EQ(expected_result,
              LinearFunction::ApplyInverse(domain_basis, range_basis,
                                           Ratio(range_delta, domain_delta),
                                           range_input));

    // Verify the instance method.
    LinearFunction under_test(domain_basis, range_basis, domain_delta,
                              range_delta);
    EXPECT_EQ(expected_result, under_test.ApplyInverse(range_input));
  }

  // Verifies that LinearFunction::Compose works as expected with the given
  // inputs.
  void VerifyCompose(const LinearFunction& a,
                     const LinearFunction& b,
                     bool exact,
                     const LinearFunction& expected_result) {
    // Verify the static method.
    EXPECT_EQ(expected_result, LinearFunction::Compose(a, b, exact));
  }
};

// Tests LinearFunction basics for various instantiation arguments.
TEST_F(LinearFunctionTest, Basics) {
  VerifyBasics(0, 0, 1, 0);
  VerifyBasics(0, 0, 1, 1);
  VerifyBasics(1, 1, 10, 10);
  VerifyBasics(1234, 5678, 4321, 8765);
  VerifyBasics(-1234, 5678, 4321, 8765);
  VerifyBasics(-1234, -5678, 4321, 8765);
  VerifyBasics(1234, -5678, 4321, 8765);
}

// Tests LinearFunction::Inverse.
TEST_F(LinearFunctionTest, Inverse) {
  VerifyInverse(0, 0, 1, 1);
  VerifyInverse(1, 1, 10, 10);
  VerifyInverse(1234, 5678, 4321, 8765);
  VerifyInverse(-1234, 5678, 4321, 8765);
  VerifyInverse(-1234, -5678, 4321, 8765);
  VerifyInverse(1234, -5678, 4321, 8765);
}

// Tests LinearFunction::Apply in its variations.
TEST_F(LinearFunctionTest, Apply) {
  VerifyApply(0, 0, 1, 0, 0, 0);
  VerifyApply(0, 0, 1, 0, 1000, 0);
  VerifyApply(0, 1234, 1, 0, 0, 1234);
  VerifyApply(0, 1234, 1, 0, 1000, 1234);
  VerifyApply(0, 1234, 1, 0, -1000, 1234);
  VerifyApply(0, -1234, 1, 0, 0, -1234);
  VerifyApply(0, -1234, 1, 0, 1000, -1234);
  VerifyApply(0, -1234, 1, 0, -1000, -1234);
  VerifyApply(0, 0, 1, 1, 0, 0);
  VerifyApply(0, 0, 1, 1, 1000, 1000);
  VerifyApply(0, 1234, 1, 1, 0, 1234);
  VerifyApply(0, 1234, 1, 1, 1000, 2234);
  VerifyApply(0, 1234, 1, 1, -1000, 234);
  VerifyApply(0, -1234, 1, 1, 0, -1234);
  VerifyApply(0, -1234, 1, 1, 1000, -234);
  VerifyApply(0, -1234, 1, 1, -1000, -2234);
  VerifyApply(10, 0, 1, 0, 0, 0);
  VerifyApply(10, 0, 1, 1, 0, -10);
  VerifyApply(-10, 0, 1, 0, 0, 0);
  VerifyApply(-10, 0, 1, 1, 0, 10);
  VerifyApply(0, 1234, 2, 1, 0, 1234);
  VerifyApply(0, 1234, 2, 1, 1234, 1234 + 1234 / 2);
  VerifyApply(0, 1234, 1, 2, 1234, 1234 + 1234 * 2);
}

// Tests LinearFunction::Apply in its variations.
TEST_F(LinearFunctionTest, ApplyInverse) {
  VerifyApplyInverse(0, 0, 1, 1, 0, 0);
  VerifyApplyInverse(0, 0, 1, 1, 1000, 1000);
  VerifyApplyInverse(0, 1234, 1, 1, 1234, 0);
  VerifyApplyInverse(0, 1234, 1, 1, 2234, 1000);
  VerifyApplyInverse(0, 1234, 1, 1, 234, -1000);
  VerifyApplyInverse(0, -1234, 1, 1, -1234, 0);
  VerifyApplyInverse(0, -1234, 1, 1, -234, 1000);
  VerifyApplyInverse(0, -1234, 1, 1, -2234, -1000);
  VerifyApplyInverse(10, 0, 1, 1, -10, 0);
  VerifyApplyInverse(-10, 0, 1, 1, 10, 0);
  VerifyApplyInverse(0, 1234, 2, 1, 1234, 0);
  VerifyApplyInverse(0, 1234, 2, 1, 1234 + 1234 / 2, 1234);
  VerifyApplyInverse(0, 1234, 1, 2, 1234 + 1234 * 2, 1234);
}

// Tests LinearFunction::Compose.
TEST_F(LinearFunctionTest, Compose) {
  VerifyCompose(LinearFunction(0, 0, 1, 0), LinearFunction(0, 0, 1, 0), true,
                LinearFunction(0, 0, 1, 0));
  VerifyCompose(LinearFunction(0, 0, 1, 1), LinearFunction(0, 0, 1, 1), true,
                LinearFunction(0, 0, 1, 1));
  VerifyCompose(LinearFunction(1, 0, 1, 1), LinearFunction(0, 0, 1, 1), true,
                LinearFunction(0, -1, 1, 1));
  VerifyCompose(LinearFunction(10, 10, 1, 1), LinearFunction(0, 0, 1, 1), true,
                LinearFunction(0, 0, 1, 1));
  VerifyCompose(LinearFunction(0, 0, 1, 2), LinearFunction(0, 0, 1, 2), true,
                LinearFunction(0, 0, 1, 4));
  VerifyCompose(LinearFunction(0, 0, 2, 1), LinearFunction(0, 0, 2, 1), true,
                LinearFunction(0, 0, 4, 1));
  VerifyCompose(LinearFunction(0, 0, 2, 1), LinearFunction(0, 0, 1, 2), true,
                LinearFunction(0, 0, 1, 1));
}

}  // namespace
}  // namespace media
}  // namespace mojo
