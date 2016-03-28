// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/scene_label.h"

#include "base/strings/stringprintf.h"

namespace compositor {

SceneLabel::SceneLabel(uint32_t token, const std::string& label)
    : token_(token), label_(label) {}

SceneLabel::SceneLabel(const SceneLabel& other)
    : token_(other.token_), label_(other.label_) {}

SceneLabel::~SceneLabel() {}

std::string SceneLabel::FormattedLabel() const {
  return label_.empty()
             ? base::StringPrintf("<S%d>", token_)
             : base::StringPrintf("<S%d:%s>", token_, label_.c_str());
}

std::string SceneLabel::FormattedLabelForVersion(uint32_t version) const {
  return label_.empty() ? base::StringPrintf("<S%d/%d>", token_, version)
                        : base::StringPrintf("<S%d:%s/%d>", token_,
                                             label_.c_str(), version);
}

std::string SceneLabel::FormattedLabelForNode(uint32_t version,
                                              uint32_t node_id) const {
  return label_.empty()
             ? base::StringPrintf("<S%d/%d>[%d]", token_, version, node_id)
             : base::StringPrintf("<S%d:%s/%d>[%d]", token_, label_.c_str(),
                                  version, node_id);
}

}  // namespace compositor
