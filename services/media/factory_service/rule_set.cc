// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <list>

#include "services/media/factory_service/rule_set.h"

namespace mojo {
namespace media {

RuleSet::RuleSet() {}

RuleSet::~RuleSet() {}

Event RuleSet::AddRule(const Condition& condition) {
  Event event = Event::Create();

  if (condition()) {
    event.Occur();
  } else {
    CheckRules(); // To purge occurred/cancelled events.
    rules_.push_back(Rule(condition, event));
  }

  return event;
}

void RuleSet::CheckRules() {
  Event to_occur;
  std::unique_ptr<std::list<Event>> more_to_occur;

  auto iter = rules_.begin();
  while (iter != rules_.end()) {
    if (iter->second.occurred() || iter->second.cancelled()) {
      // Event cancelled/occurred elsewhere. Erase the rule.
      auto to_erase = iter++;
      rules_.erase(to_erase);
    } else if (iter->first()) {
      // Condition return true. Record the event and erase the rule.
      auto to_erase = iter++;
      if (!to_occur) {
        to_occur = to_erase->second;
      } else {
        if (!more_to_occur) {
          more_to_occur.reset(new std::list<Event>());
        }
        more_to_occur->push_back(to_erase->second);
      }
      rules_.erase(to_erase);
    } else {
      ++iter;
    }
  }

  if (to_occur) {
    to_occur.Occur();
  }

  if (more_to_occur) {
    for (const Event& event : *more_to_occur) {
      event.Occur();
    }
  }
}

}  // namespace media
}  // namespace mojo
