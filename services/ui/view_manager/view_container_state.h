// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_CONTAINER_STATE_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_CONTAINER_STATE_H_

#include <iosfwd>

#include "base/macros.h"
#include "mojo/services/ui/views/interfaces/view_containers.mojom.h"

namespace view_manager {

// Base class for views and view trees.
// This object is owned by the ViewRegistry that created it.
class ViewContainerState {
 public:
  ViewContainerState();

  // Gets or sets the view container listener.
  mojo::ui::ViewContainerListener* view_container_listener() const {
    return view_container_listener_.get();
  }
  void set_view_container_listener(
      mojo::ui::ViewContainerListenerPtr view_container_listener) {
    view_container_listener_ = view_container_listener.Pass();
  }

  virtual const std::string& FormattedLabel() const = 0;

 protected:
  virtual ~ViewContainerState();

 private:
  mojo::ui::ViewContainerListenerPtr view_container_listener_;

  DISALLOW_COPY_AND_ASSIGN(ViewContainerState);
};

std::ostream& operator<<(std::ostream& os, ViewContainerState* view_state);

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_CONTAINER_STATE_H_
