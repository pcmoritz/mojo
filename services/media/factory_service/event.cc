// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <list>

#include "base/logging.h"
#include "services/media/factory_service/event.h"

namespace mojo {
namespace media {

// Shared state for normal Events.
class EventImpl : public std::enable_shared_from_this<EventImpl> {
 public:
  EventImpl();

  virtual ~EventImpl();

  void When(const std::function<void()>& consequence) {
    if (occurred_) {
      consequence();
    } else if (!cancelled_) {
      consequences_.push_back(consequence);
    }
  }

  void Occur() {
    // Create a shared pointer to this so this object isn't destroyed during
    // the consequence callback.
    std::shared_ptr<EventImpl> self_ref = shared_from_this();
    if (!occurred_ && !cancelled_) {
      occurred_ = true;
      while (!consequences_.empty()) {
        consequences_.front()();
        consequences_.pop_front();
      }
    }
  }

  void Cancel() {
    if (!occurred_) {
      cancelled_ = true;
      consequences_.clear();
    }
  }

  bool occurred() const { return occurred_; }

  bool cancelled() const { return cancelled_; }

 private:
  bool occurred_ = false;
  bool cancelled_ = false;
  std::list<std::function<void()>> consequences_;
};

// Shared state for Events created with Event::First.
class FirstEventImpl : public EventImpl {
 public:
  FirstEventImpl(const std::vector<Event>& precursors);

  ~FirstEventImpl() override;

  // Initializes this. A separate call is needed, because initialization may
  // involve calling Occur, which calls shared_from_this, which requires that
  // a shared pointer be created.
  void Init();

 private:
  void Finished();

  std::vector<Event> precursors_;
};

// Shared state for Events created with Event::All
class AllEventImpl : public EventImpl {
 public:
  AllEventImpl(const std::vector<Event>& precursors);

  ~AllEventImpl() override;

  // Initializes this. A separate call is needed, because initialization may
  // involve calling Occur, which calls shared_from_this, which requires that
  // a shared pointer be created.
  void Init();

 private:
  void Next();

  std::vector<Event> precursors_;
  std::function<void()> consequence_;
};

// static
Event Event::Create() {
  return Event(std::make_shared<EventImpl>());
}

// static
Event Event::First(const std::vector<Event>& precursors) {
  std::shared_ptr<FirstEventImpl> first =
      std::make_shared<FirstEventImpl>(precursors);
  first->Init();
  return Event(first);
}

// static
Event Event::All(const std::vector<Event>& precursors) {
  std::shared_ptr<AllEventImpl> all =
      std::make_shared<AllEventImpl>(precursors);
  all->Init();
  return Event(all);
}

Event::Event() : impl_(nullptr) {}

Event::Event(const Event& other) : impl_(other.impl_) {}

Event::Event(const std::shared_ptr<EventImpl>& impl) : impl_(impl) {}

Event::~Event() {}

const Event& Event::When(const std::function<void()>& consequence) const {
  DCHECK(impl_);
  impl_->When(consequence);
  return *this;
}

bool Event::occurred() const {
  DCHECK(impl_);
  return impl_->occurred();
}

bool Event::cancelled() const {
  DCHECK(impl_);
  return impl_->cancelled();
}

void Event::Occur() const {
  DCHECK(impl_);
  impl_->Occur();
}

void Event::Cancel() const {
  if (impl_) {
    impl_->Cancel();
  }
}

EventImpl::EventImpl() {}

EventImpl::~EventImpl() {
  if (!occurred_ && !cancelled_) {
    LOG(WARNING) << "Event deleted before occuring or being cancelled";
  }
}

FirstEventImpl::FirstEventImpl(const std::vector<Event>& precursors)
    : precursors_(precursors) {
  DCHECK(!precursors.empty());
}

void FirstEventImpl::Init() {
  for (Event& precursor : precursors_) {
    if (precursor.occurred()) {
      Finished();
      return;
    }
  }

  std::function<void()> consequence = [this]() {
    Finished();
  };

  for (Event& precursor : precursors_) {
    precursor.When(consequence);
  }
}

FirstEventImpl::~FirstEventImpl() {
  for (Event& precursor : precursors_) {
    precursor.Cancel();
  }
}

void FirstEventImpl::Finished() {
  for (Event& precursor : precursors_) {
    precursor.Cancel();
  }
  Occur();
  precursors_.clear();
}

AllEventImpl::AllEventImpl(const std::vector<Event>& precursors)
    : precursors_(precursors) {}

void AllEventImpl::Init() {
  consequence_ = [this]() {
    precursors_.pop_back();
    Next();
  };

  Next();
}

AllEventImpl::~AllEventImpl() {
  for (Event& precursor : precursors_) {
    precursor.Cancel();
  }
}

void AllEventImpl::Next() {
  for (; !precursors_.empty(); precursors_.pop_back()) {
    if (!precursors_.back().occurred()) {
      precursors_.back().When(consequence_);
      return;
    }
  }

  Occur();
}

}  // namespace media
}  // namespace mojo
