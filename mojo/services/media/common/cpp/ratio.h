// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_COMMON_CPP_RATIO_H_
#define MOJO_SERVICES_MEDIA_COMMON_CPP_RATIO_H_

#include <stdint.h>

#include <limits>

#include "mojo/public/cpp/environment/logging.h"

namespace mojo {
namespace media {

// TODO(dalesat): Consider always allowing inexact results.

// Expresses a non-negative rational number as the ratio between two uint32_t
// values.
struct Ratio {
  // Used to indicate overflow of scaling operations.
  static constexpr int64_t kOverflow = std::numeric_limits<int64_t>::max();

  // Reduces the ratio of *numerator and *denominator.
  static void Reduce(uint32_t* numerator, uint32_t* denominator);

  // Produces the product of the ratios. If exact is true, DCHECKs on loss of
  // precision.
  static void Product(uint32_t a_numerator,
                      uint32_t a_denominator,
                      uint32_t b_numerator,
                      uint32_t b_denominator,
                      uint32_t* product_numerator,
                      uint32_t* product_denominator,
                      bool exact = true);

  // Produces the product of the ratios and the int64_t as an int64_t. Returns
  // kOverflow on overflow.
  static int64_t Scale(int64_t value, uint32_t numerator, uint32_t denominator);

  // Returns the product of the ratios. If exact is true, DCHECKs on loss of
  // precision.
  static Ratio Product(const Ratio& a, const Ratio& b, bool exact = true) {
    uint32_t result_numerator;
    uint32_t result_denominator;
    Product(a.numerator(), a.denominator(), b.numerator(), b.denominator(),
            &result_numerator, &result_denominator, exact);
    return Ratio(result_numerator, result_denominator);
  }

  Ratio() : numerator_(0), denominator_(1) {}

  explicit Ratio(uint32_t numerator) : numerator_(numerator), denominator_(1) {}

  Ratio(uint32_t numerator, uint32_t denominator)
      : numerator_(numerator), denominator_(denominator) {
    MOJO_DCHECK(denominator != 0);
    Reduce(&numerator_, &denominator_);
  }

  // Returns the inverse of the ratio. DCHECKs if the numerator of this ratio
  // is zero.
  Ratio Inverse() const {
    MOJO_DCHECK(numerator_ != 0);
    return Ratio(denominator_, numerator_);
  }

  // Scales the value by this ratio. Returns kOverflow on overflow.
  int64_t Scale(int64_t value) const {
    return Scale(value, numerator_, denominator_);
  }

  uint32_t numerator() const { return numerator_; }
  uint32_t denominator() const { return denominator_; }

 private:
  uint32_t numerator_;
  uint32_t denominator_;
};

// Tests two ratios for equality.
inline bool operator==(const Ratio& a, const Ratio& b) {
  return a.numerator() == b.numerator() && a.denominator() == b.denominator();
}

// Tests two ratios for inequality.
inline bool operator!=(const Ratio& a, const Ratio& b) {
  return !(a == b);
}

// Returns the product of the two ratios. DCHECKs on loss of precision.
inline Ratio operator*(const Ratio& a, const Ratio& b) {
  return Ratio::Product(a, b);
}

// Returns the product of the ratio and the int64_t. Returns kOverflow on
// overflow.
inline int64_t operator*(const Ratio& a, int64_t b) {
  return a.Scale(b);
}

// Returns the product of the ratio and the int64_t. Returns kOverflow on
// overflow.
inline int64_t operator*(int64_t a, const Ratio& b) {
  return b.Scale(a);
}

// Returns the the int64_t divided by the ratio. Returns kOverflow on
// overflow.
inline int64_t operator/(int64_t a, const Ratio& b) {
  return b.Inverse().Scale(a);
}

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_COMMON_CPP_LINEAR_TRANSFORM_H_
