// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_RULE_SET_H_
#define MOJO_SERVICES_MEDIA_FACTORY_RULE_SET_H_

#include <list>

#include "services/media/factory_service/event.h"

namespace mojo {
namespace media {

// A collection of condition/Event pairs that can be scanned on request to
// fire the Events whose conditions are true.
class RuleSet {
 protected:
  using Condition = std::function<bool()>;
  using Rule = std::pair<Condition, Event>;

  RuleSet();

  ~RuleSet();

  // Adds a rule to the collection, returning a new Event for that rule. Also
  // call CheckRules to purge any occurred or cancelled Events.
  Event AddRule(const Condition& condition);

  // Runs each condition and calls Occur on the Events corresponding to
  // conditions that return true. Rules whose events have occurred or been
  // cancelled are erased.
  void CheckRules();

 private:
  std::list<Rule> rules_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_RULE_SET_H_
