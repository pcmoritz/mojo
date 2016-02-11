// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_manager_impl.h"

#include <utility>

#include "services/ui/view_manager/view_host_impl.h"
#include "services/ui/view_manager/view_tree_host_impl.h"

namespace view_manager {

ViewManagerImpl::ViewManagerImpl(ViewRegistry* registry)
    : registry_(registry) {}

ViewManagerImpl::~ViewManagerImpl() {}

void ViewManagerImpl::RegisterView(
    mojo::InterfaceHandle<mojo::ui::View> view,
    mojo::InterfaceRequest<mojo::ui::ViewHost> view_host_request,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    const mojo::String& label) {
  registry_->RegisterView(mojo::ui::ViewPtr::Create(std::move(view)),
                          view_host_request.Pass(), view_owner_request.Pass(),
                          label);
}

void ViewManagerImpl::RegisterViewTree(
    mojo::InterfaceHandle<mojo::ui::ViewTree> view_tree,
    mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request,
    const mojo::String& label) {
  registry_->RegisterViewTree(
      mojo::ui::ViewTreePtr::Create(std::move(view_tree)),
      view_tree_host_request.Pass(), label);
}

}  // namespace view_manager
