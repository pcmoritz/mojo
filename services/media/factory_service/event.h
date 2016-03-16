// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_EVENT_H_
#define MOJO_SERVICES_MEDIA_FACTORY_EVENT_H_

#include <memory>
#include <vector>

#include "mojo/public/cpp/bindings/callback.h"

namespace mojo {
namespace media {

class EventImpl;

// The Event class provides a facility for executing code as the consequence of
// some occurrence. This can be useful for building state machines and otherwise
// dealing with asynchronous operations.
//
// Event is not a thread-safe class and has no ability to make a thread wait
// or to execute code on a particular thread.
//
// An Event consists of a shared pointer to an implementation object, so copies
// of an Event share state, and all copies of an Event must be deleted before
// that shared state is deleted.
//
// Events rely heavily on lambdas and containers, so they shouln't be used in
// enormous numbers.
//
// An Event (and its copies) can be in one of three states: an initial state,
// an occurred state or a cancelled state. The only state transitions that are
// allowed are from the initial state to one of the other two states. That is,
// an Event may either occur or be cancelled, but not both, and once it occurs
// or is cancelled, it can never occur or be cancelled again.
//
// Code can be executed when an event occurs:
//
//     Event event = ...
//     event.When([]() {
//       // Do something...
//     });
//
// The behavior of the When method depends on the event's state. In initial
// state, the consequence is added to a list to be executed when the event
// occurs. In occurred state, When executes the consequence immediately (before
// When returns). In cancelled state, When does nothing.
//
// An Event occurs when its Occur (or Run) method is invoked and the Event is
// in the initial state. All registered consequences of the Event are executed
// during the call to Occur in the order they were added. Subsequent calls to
// Occur, Run or Cancel are ignored.
//
// An Event is cancelled when its Cancel method is invoked and the Event is
// in the initial state. All registered consequences of the Event are destroyed
// during the call to Cancel. Subsequent calls to Occur, Run or Cancel are
// ignored.
//
// Events can be combined using the static methods First and All. First returns
// an Event that occurs when any of the subordinate events occurs, at which
// time, all the subordinates are cancelled. All returns an Event that occurs
// when all of the subordinate events have occurred. First is useful for
// implementing states in which multiple events may occur, each with its own
// consequence. All is useful when multiple operations are performed in
// parallel, and the caller needs to take action when all the operations are
// complete.
//
// As mentioned earlier, Event is really shared pointer to state shared between
// copies of the Event. The shared state's lifetime ends when the last copy of
// the associated Event is deleted. Callers must take care to make sure that
// Events live long enough to do the work for which they are intended.
//
// In many cases, lifetime management more or less takes care of itself, because
// the mechanism that eventually calls Occur or Cancel (usually a lambda) holds
// on to a copy of the Event. This is not the case for Events produced by First
// and All. A First or All event isn't kept alive by its subordinates so it's
// important to keep a copy of such an Event until its done its job.
//
// First and All Events hold a reference to their subordinates so long as those
// subordinates remain in their initial states. Both First and All events cancel
// all of their subordinates in their destructors to ensure that the
// subordinates don't call into a deleted parent Event.
class Event {
 public:
  // Creates a new Event.
  static Event Create();

  // Creates a Event that occurs when any of the precursors occurs. When any
  // of the precursors occurs, all the other precursors are cancelled and the
  // returned Event occurs. If any of the precursors has already occurred when
  // this method is called, all the precursors are cancelled immediately and the
  // return Event has already occurred when the method call completes. If the
  // precursors parameter is empty, the returned event never occurs.
  static Event First(const std::vector<Event>& precursors);

  // Creates a Event that occurs when the precursors have all occurred. If all
  // of the precursors have already occurred when this method is called (or
  // precursors is empty), the returned Event has already occurred when the
  // method call completes.
  static Event All(const std::vector<Event>& precursors);

  // Creates a null Event.
  Event();

  // Creates an Event that references the same underlying object as other.
  Event(const Event& other);

  ~Event();

  // Changes this Event to have the same underlying object as other.
  const Event& operator=(const Event& other) {
    impl_ = other.impl_;
    return *this;
  }

  // Makes this Event null.
  const Event& operator=(std::nullptr_t) {
    impl_.reset();
    return *this;
  }

  // Determines whether this Event is non-null.
  explicit operator bool() const {
    return static_cast<bool>(impl_);
  }

  // Executes the consequence when this Event occurs. If this Event hasn't
  // occurred or been cancelled when this method is called, a copy of the
  // consequence is held until this Event occurs or is cancelled. If this Event
  // has occurred when this method is called, the consequence is executed
  // immediately and no copy of the consequence is held. If this Event is
  // cancelled when this method is called, the method does nothing.
  // Returns this.
  const Event& When(const std::function<void()>& consequence) const;

  // Determines if this Event has occurred due to a past call to Occur or Run.
  bool occurred() const;

  // Determines if this Event has been cancelled.
  bool cancelled() const;

  // If this Event hasn't yet occurred or been cancelled, this method makes
  // this Event occur, executing and deleting all its consequences. Otherwise,
  // does nothing.
  void Occur() const;

  // If this Event hasn't yet occurred or been cancelled, this method cancels
  // this Event and deletes all its consequences. Otherwise, does nothing.
  void Cancel() const;

  // Calls Occur. This method makes an Event convertible to
  // mojo::Callback<void()>.
  void Run() const {
    Occur();
  }

 private:
  explicit Event(const std::shared_ptr<EventImpl>& impl);

  std::shared_ptr<EventImpl> impl_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_EVENT_H_
