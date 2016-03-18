// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_container_state.h"

#include <ostream>

namespace view_manager {

ViewContainerState::ViewContainerState() {}

ViewContainerState::~ViewContainerState() {}

std::ostream& operator<<(std::ostream& os, ViewContainerState* state) {
  if (!state)
    return os << "null";
  return os << state->FormattedLabel();
}

}  // namespace view_manager
