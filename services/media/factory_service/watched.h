// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_WATCHED_H_
#define MOJO_SERVICES_MEDIA_FACTORY_WATCHED_H_

#include "services/media/factory_service/rule_set.h"

namespace mojo {
namespace media {

// Wraps an object, providing Events that occur when certain criteria are met.
template <typename T>
class Watched : public RuleSet {
 public:
  Watched() {}
  explicit Watched(T t) : t_(t) {}

  // Returns a Event that will occur when the value of this Watched changes
  // to comparand (immediately if they're already equal).
  Event Becomes(const T& comparand) {
    return AddRule([this, comparand]() -> bool { return t_ == comparand; });
  }

  // Returns a Event that will occur when the value of this Watched changes
  // to something other than comparand (immediately if they're already not
  // equal).
  Event BecomesOtherThan(const T& comparand) {
    return AddRule([this, comparand]() -> bool { return t_ != comparand; });
  }

  void SetWithConsequences(const T& t) {
    t_ = t;
    CheckRules();
  }

  operator T() { return t_; }

  operator const T&() const { return t_; }

 private:
  T t_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_WATCHED_H_
