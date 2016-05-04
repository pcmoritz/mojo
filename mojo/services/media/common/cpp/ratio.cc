// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <limits>
#include <utility>

#include "mojo/public/cpp/environment/logging.h"
#include "mojo/services/media/common/cpp/ratio.h"

namespace mojo {
namespace media {

namespace {

// Calculates the greatest common denominator (factor) of two values.
template <typename T>
T BinaryGcd(T a, T b) {
  if (a == 0) {
    return b;
  }

  if (b == 0) {
    return a;
  }

  // Remove and count the common factors of 2.
  uint8_t twos;
  for (twos = 0; ((a | b) & 1) == 0; ++twos) {
    a >>= 1;
    b >>= 1;
  }

  // Get rid of the non-common factors of 2 in a. a is non-zero, so this
  // terminates.
  while ((a & 1) == 0) {
    a >>= 1;
  }

  do {
    // Get rid of the non-common factors of 2 in b. b is non-zero, so this
    // terminates.
    while ((b & 1) == 0) {
      b >>= 1;
    }

    // Apply the Euclid subtraction method.
    if (a > b) {
      std::swap(a, b);
    }

    b = b - a;
  } while (b != 0);

  // Multiply in the common factors of two.
  return a << twos;
}

// Reduces the ration of *numerator and *denominator.
template <typename T>
void ReduceRatio(T* numerator, T* denominator) {
  MOJO_DCHECK(numerator != nullptr);
  MOJO_DCHECK(denominator != nullptr);
  MOJO_DCHECK(*denominator != 0);

  T gcd = BinaryGcd(*numerator, *denominator);

  if (gcd == 0) {
    *denominator = 1;
    return;
  }

  if (gcd == 1) {
    return;
  }

  *numerator = *numerator / gcd;
  *denominator = *denominator / gcd;
}

template void ReduceRatio<uint64_t>(uint64_t* numerator, uint64_t* denominator);
template void ReduceRatio<uint32_t>(uint32_t* numerator, uint32_t* denominator);

// Scales a uint64_t value by the ratio of two uint32_t values. If round_up is
// true, the result is rounded up rather than down. overflow is set to indicate
// overflow.
uint64_t ScaleUInt64(uint64_t value,
                     uint32_t numerator,
                     uint32_t denominator,
                     bool round_up,
                     bool* overflow) {
  MOJO_DCHECK(denominator != 0u);
  MOJO_DCHECK(overflow != nullptr);

  constexpr uint64_t kLow32Bits = 0xffffffffu;
  constexpr uint64_t kHigh32Bits = kLow32Bits << 32u;

  // high and low are the product of the numerator and the high and low halves
  // (respectively) of value.
  uint64_t high = numerator * (value >> 32u);
  uint64_t low = numerator * (value & kLow32Bits);
  // Ignoring overflow and remainder, the result we want is:
  // ((high << 32) + low) / denominator.

  // Move the high end of low into the low end of high.
  high += low >> 32u;
  low = low & kLow32Bits;
  // Ignoring overflow and remainder, the result we want is still:
  // ((high << 32) + low) / denominator.

  // When we divide high by denominator, there'll be a remainder. Make
  // that the high end of low, which is currently all zeroes.
  low |= (high % denominator) << 32u;

  // Determine if we need to round up when we're done:
  round_up = round_up && (low % denominator) != 0;

  // Do the division.
  high /= denominator;
  low /= denominator;

  // If high's top 32 bits aren't all zero, we have overflow.
  if (high & kHigh32Bits) {
    *overflow = true;
    return 0;
  }

  uint64_t result = (high << 32u) | low;
  if (round_up) {
    if (result == std::numeric_limits<int64_t>::max()) {
      *overflow = true;
      return 0;
    }
    ++result;
  }

  *overflow = false;
  return result;
}

}  // namespace

// static
void Ratio::Reduce(uint32_t* numerator, uint32_t* denominator) {
  ReduceRatio(numerator, denominator);
}

// static
void Ratio::Product(uint32_t a_numerator,
                    uint32_t a_denominator,
                    uint32_t b_numerator,
                    uint32_t b_denominator,
                    uint32_t* product_numerator,
                    uint32_t* product_denominator,
                    bool exact) {
  MOJO_DCHECK(a_denominator != 0);
  MOJO_DCHECK(b_denominator != 0);
  MOJO_DCHECK(product_numerator != nullptr);
  MOJO_DCHECK(product_denominator != nullptr);

  uint64_t numerator = static_cast<uint64_t>(a_numerator) * b_numerator;
  uint64_t denominator = static_cast<uint64_t>(a_denominator) * b_denominator;

  ReduceRatio(&numerator, &denominator);

  if (numerator > std::numeric_limits<uint32_t>::max() ||
      denominator > std::numeric_limits<uint32_t>::max()) {
    MOJO_DCHECK(!exact);

    do {
      numerator >>= 1;
      denominator >>= 1;
    } while (numerator > std::numeric_limits<uint32_t>::max() ||
             denominator > std::numeric_limits<uint32_t>::max());

    if (denominator == 0) {
      // Product is larger than we can represent. Return the largest value we
      // can represent.
      *product_numerator = std::numeric_limits<uint32_t>::max();
      *product_denominator = 1;
      return;
    }
  }

  *product_numerator = static_cast<uint32_t>(numerator);
  *product_denominator = static_cast<uint32_t>(denominator);
}

// static
int64_t Ratio::Scale(int64_t value, uint32_t numerator, uint32_t denominator) {
  static constexpr uint64_t abs_of_min_int64 =
      static_cast<uint64_t>(std::numeric_limits<int64_t>::max()) + 1;

  MOJO_DCHECK(denominator != 0u);

  bool overflow;

  uint64_t abs_result;

  if (value >= 0) {
    abs_result = ScaleUInt64(static_cast<uint64_t>(value), numerator,
                             denominator, false, &overflow);
  } else if (value == std::numeric_limits<int64_t>::min()) {
    abs_result = ScaleUInt64(abs_of_min_int64, numerator, denominator,
                             true, &overflow);
  } else {
    abs_result = ScaleUInt64(static_cast<uint64_t>(-value), numerator,
                             denominator, true, &overflow);
  }

  if (overflow) {
    return Ratio::kOverflow;
  }

  // Make sure we won't overflow when we cast to int64_t.
  if (abs_result > static_cast<uint64_t>(std::numeric_limits<int64_t>::max())) {
    if (value < 0 && abs_result == abs_of_min_int64) {
      return std::numeric_limits<int64_t>::min();
    }
    return Ratio::kOverflow;
  }

  return value >= 0 ? static_cast<int64_t>(abs_result)
                    : -static_cast<int64_t>(abs_result);
}

}  // namespace media
}  // namespace mojo
