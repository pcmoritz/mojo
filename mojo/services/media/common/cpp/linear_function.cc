// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <limits>
#include <utility>

#include "mojo/public/cpp/environment/logging.h"
#include "mojo/services/media/common/cpp/linear_function.h"

namespace mojo {
namespace media {

// static
int64_t LinearFunction::Apply(int64_t domain_basis,
                              int64_t range_basis,
                              const Ratio& slope,  // range_delta / domain_delta
                              int64_t domain_input) {
  return slope.Scale(domain_input - domain_basis) + range_basis;
}

// static
LinearFunction LinearFunction::Compose(const LinearFunction& bc,
                                       const LinearFunction& ab,
                                       bool exact) {
  return LinearFunction(ab.domain_basis(), bc.Apply(ab.range_basis()),
                        Ratio::Product(ab.slope(), bc.slope(), exact));
}

}  // namespace media
}  // namespace mojo
