// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_COMMON_CPP_LINEAR_FUNCTION_H_
#define MOJO_SERVICES_MEDIA_COMMON_CPP_LINEAR_FUNCTION_H_

#include "mojo/public/cpp/environment/logging.h"
#include "mojo/services/media/common/cpp/ratio.h"

namespace mojo {
namespace media {

// TODO(dalesat): Consider always allowing inexact results.

// A linear function from int64_t to int64_t with non-negative slope. The
// representation is in point-slope form. The point is represented as two
// int64_t values (domain_basis, range_basis), and the slope is represented as
// the ratio of two uint32_t values (range_delta / domain_delta). 'Domain'
// refers to the input space, and 'range' refers to the output space.
struct LinearFunction {
  // Applies a linear function.
  static int64_t Apply(int64_t domain_basis,
                       int64_t range_basis,
                       const Ratio& slope,  // range_delta / domain_delta
                       int64_t domain_input);

  // Applies the inverse of a linear function.
  static int64_t ApplyInverse(int64_t domain_basis,
                              int64_t range_basis,
                              const Ratio& slope,  // range_delta / domain_delta
                              int64_t range_input) {
    MOJO_DCHECK(slope.denominator() != 0u);
    return Apply(range_basis, domain_basis, slope.Inverse(), range_input);
  }

  // Composes two linear functions B->C and A->B producing A->C. If exact is
  // true, DCHECKs on loss of precision.
  static LinearFunction Compose(const LinearFunction& bc,
                                const LinearFunction& ab,
                                bool exact = true);

  LinearFunction() : domain_basis_(0), range_basis_(0) {}

  LinearFunction(int64_t domain_basis,
                 int64_t range_basis,
                 uint32_t domain_delta,
                 uint32_t range_delta)
      : domain_basis_(domain_basis),
        range_basis_(range_basis),
        slope_(range_delta, domain_delta) {}

  LinearFunction(int64_t domain_basis,
                 int64_t range_basis,
                 const Ratio& slope)  // range_delta / domain_delta
      : domain_basis_(domain_basis),
        range_basis_(range_basis),
        slope_(slope) {}

  explicit LinearFunction(const Ratio& slope)  // range_delta / domain_delta
      : domain_basis_(0),
        range_basis_(0),
        slope_(slope) {}

  // Applies the function. Returns Ratio::kOverflow on overflow.
  int64_t Apply(int64_t domain_input) const {
    return Apply(domain_basis_, range_basis_, slope_, domain_input);
  }

  // Applies the inverse of the function. Returns Ratio::kOverflow on overflow.
  int64_t ApplyInverse(int64_t range_input) const {
    MOJO_DCHECK(slope_.denominator() != 0u);
    return ApplyInverse(domain_basis_, range_basis_, slope_, range_input);
  }

  // Applies the function.  Returns Ratio::kOverflow on overflow.
  int64_t operator()(int64_t domain_input) const { return Apply(domain_input); }

  // Returns a linear function that is the inverse if this linear function.
  LinearFunction Inverse() const {
    MOJO_DCHECK(slope_.denominator() != 0u);
    return LinearFunction(range_basis_, domain_basis_, slope_.Inverse());
  }

  int64_t domain_basis() const { return domain_basis_; }

  int64_t range_basis() const { return range_basis_; }

  const Ratio& slope() const { return slope_; }

  uint32_t domain_delta() const { return slope_.denominator(); }

  uint32_t range_delta() const { return slope_.numerator(); }

  int64_t domain_basis_;
  int64_t range_basis_;
  Ratio slope_;  // range_delta / domain_delta
};

// Tests two linear functions for equality. Equality requires equal basis
// values.
inline bool operator==(const LinearFunction& a, const LinearFunction& b) {
  return a.domain_basis() == b.domain_basis() &&
         a.range_basis() == b.range_basis() && a.slope() == b.slope();
}

// Tests two linear functions for inequality. Equality requires equal basis
// values.
inline bool operator!=(const LinearFunction& a, const LinearFunction& b) {
  return !(a == b);
}

// Composes two linear functions B->C and A->B producing A->C. DCHECKs on
// loss of precision.
inline LinearFunction operator*(const LinearFunction& bc,
                                const LinearFunction& ab) {
  return LinearFunction::Compose(bc, ab);
}

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_COMMON_CPP_LINEAR_FUNCTION_H_
