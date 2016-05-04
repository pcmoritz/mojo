// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <limits>

#include "mojo/services/media/common/cpp/ratio.h"
#include "services/media/common/test/test_base.h"

namespace mojo {
namespace media {
namespace {

class RatioTest : public TestBase {
  static uint32_t gcd(uint32_t a, uint32_t b) {
    while (b != 0) {
      uint32_t t = a;
      a = b;
      b = t % b;
    }
    return a;
  }

 public:
  // Verifies Ratio::Reduce and the constructor, ensuring that the ratio
  // numerator * common_factor / denominator * common_factor is reduced to
  // numerator / denominator. numerator and denominator need to be relatively
  // prime for this to work.
  void VerifyReduce(uint32_t numerator,
                    uint32_t denominator,
                    uint32_t common_factor) {
    // Make sure numerator and denominator are relatively prime.
    EXPECT_EQ(1u, gcd(numerator, denominator));

    uint32_t test_numerator = numerator * common_factor;
    uint32_t test_denominator = denominator * common_factor;

    // Make sure the constructor reduces.
    Ratio ratio(test_numerator, test_denominator);
    EXPECT_EQ(numerator, ratio.numerator());
    EXPECT_EQ(denominator, ratio.denominator());

    // Test the static method.
    Ratio::Reduce(&test_numerator, &test_denominator);
    EXPECT_EQ(numerator, test_numerator);
    EXPECT_EQ(denominator, test_denominator);
  }

  // Verifies the Ratio::Scale methods by scaling value by numerator /
  // denominator and verifying the result.
  void VerifyScale(int64_t value,
                   uint32_t numerator,
                   uint32_t denominator,
                   int64_t result) {
    // Test the instance method.
    EXPECT_EQ(result, Ratio(numerator, denominator).Scale(value));

    // Test the static method.
    EXPECT_EQ(result, Ratio::Scale(value, numerator, denominator));

    // Test the operators.
    EXPECT_EQ(result, value * Ratio(numerator, denominator));
    EXPECT_EQ(result, Ratio(numerator, denominator) * value);
    if (numerator != 0) {
      EXPECT_EQ(result, value / Ratio(denominator, numerator));
    }
  }

  // Verifies the Ratio::Product methods by multiplying the given a and b
  // ratios and checking the result against the expected ratio.
  void VerifyProduct(uint32_t a_numerator,
                     uint32_t a_denominator,
                     uint32_t b_numerator,
                     uint32_t b_denominator,
                     uint32_t expected_numerator,
                     uint32_t expected_denominator,
                     bool exact) {
    // Test the first static method.
    uint32_t actual_numerator;
    uint32_t actual_denominator;
    Ratio::Product(a_numerator, a_denominator, b_numerator, b_denominator,
                   &actual_numerator, &actual_denominator, exact);
    EXPECT_EQ(expected_numerator, actual_numerator);
    EXPECT_EQ(expected_denominator, actual_denominator);

    // Test the second static method.
    EXPECT_EQ(Ratio(expected_numerator, expected_denominator),
              Ratio::Product(Ratio(a_numerator, a_denominator),
                             Ratio(b_numerator, b_denominator), exact));

    // Test the operator
    if (exact) {
      EXPECT_EQ(Ratio(expected_numerator, expected_denominator),
                Ratio(a_numerator, a_denominator) *
                    Ratio(b_numerator, b_denominator));
    }
  }

  // Verifies the Ration::Inverse method using the given ratio.
  void VerifyInverse(uint32_t numerator, uint32_t denominator) {
    Ratio ratio(numerator, denominator);
    Ratio inverse(ratio.Inverse());
    EXPECT_EQ(ratio.denominator(), inverse.numerator());
    EXPECT_EQ(ratio.numerator(), inverse.denominator());
  }
};

// Tests Ratio::Reduce and that the Ratio constructor reduces.
TEST_F(RatioTest, Reduce) {
  VerifyReduce(0, 1, 1);
  VerifyReduce(1, 1, 1);
  VerifyReduce(1234, 1, 1);
  VerifyReduce(1, 1234, 14);
  VerifyReduce(1, 1, 1234);
  VerifyReduce(10, 1, 1234);
  VerifyReduce(1, 10, 1234);
  VerifyReduce(49, 81, 1);
  VerifyReduce(49, 81, 10);
  VerifyReduce(49, 81, 100);
  VerifyReduce(1, 8, 65536);
  VerifyReduce(8, 1, 65536);
}

// Tests Ratio::Scale, static, instance and operator versions.
TEST_F(RatioTest, Scale) {
  const int64_t int64_min = std::numeric_limits<int64_t>::min();
  VerifyScale(0, 0, 1, 0);
  VerifyScale(1, 0, 1, 0);
  VerifyScale(0, 1, 1, 0);
  VerifyScale(1, 1, 1, 1);
  VerifyScale(1, 2, 1, 2);
  VerifyScale(1, 1, 2, 0);
  VerifyScale(-1, 1, 2, -1);
  VerifyScale(1000, 1, 2, 500);
  VerifyScale(1001, 1, 2, 500);
  VerifyScale(-1000, 1, 2, -500);
  VerifyScale(-1001, 1, 2, -501);
  VerifyScale(1000, 2, 1, 2000);
  VerifyScale(1001, 2, 1, 2002);
  VerifyScale(-1000, 2, 1, -2000);
  VerifyScale(-1001, 2, 1, -2002);
  VerifyScale(1ll << 32, 1, 1, 1ll << 32);
  VerifyScale(1ll << 32, 1, 2, 1ll << 31);
  VerifyScale(1ll << 32, 2, 1, 1ll << 33);
  VerifyScale(1234ll << 30, 1, 1, 1234ll << 30);
  VerifyScale(1234ll << 30, 1, 2, 1234ll << 29);
  VerifyScale(1234ll << 30, 2, 1, 1234ll << 31);
  VerifyScale(1234ll << 30, 1 << 31, 1, Ratio::kOverflow);
  VerifyScale(1234ll << 30, 1ll << 31, (1ll << 31) - 2,
              (1234ll << 30) + 1234ll);
  VerifyScale(int64_min, 1, 1, int64_min);
  VerifyScale(int64_min, 1, 2, int64_min / 2);
  VerifyScale(int64_min / 2, 2, 1, int64_min);
  VerifyScale(int64_min, 1000001, 1000000, Ratio::kOverflow);
}

// Tests Ratio::Product, static and operator versions.
TEST_F(RatioTest, Product) {
  VerifyProduct(0, 1, 0, 1, 0, 1, true);
  VerifyProduct(1, 1, 1, 1, 1, 1, true);
  VerifyProduct(10, 1, 1, 10, 1, 1, true);
  VerifyProduct(4321, 1234, 617, 4321, 1, 2, true);
  VerifyProduct(1234, 4321, 4321, 617, 2, 1, true);
  VerifyProduct(1ll << 31, (1ll << 31) - 1, (1ll << 31) - 1, 1ll << 31, 1, 1,
                true);
  VerifyProduct(1ll << 31, (1ll << 31) - 1, (1ll << 31) - 2, 1ll << 31,
                0x7ffffffe, 0x7fffffff, false);
}

// Tests Ratio::Inverse.
TEST_F(RatioTest, Inverse) {
  VerifyInverse(1, 1);
  VerifyInverse(2, 1);
  VerifyInverse(1, 2);
  VerifyInverse(1000000, 1234);
  VerifyInverse(1234, 1000000);
}

}  // namespace
}  // namespace media
}  // namespace mojo
