// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_manager_impl.h"

#include "services/ui/view_manager/view_host_impl.h"
#include "services/ui/view_manager/view_tree_host_impl.h"

namespace view_manager {

ViewManagerImpl::ViewManagerImpl(ViewRegistry* registry)
    : registry_(registry) {}

ViewManagerImpl::~ViewManagerImpl() {}

void ViewManagerImpl::RegisterView(
    mojo::ui::ViewPtr view,
    mojo::InterfaceRequest<mojo::ui::ViewHost> view_host_request,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    const mojo::String& label) {
  registry_->RegisterView(view.Pass(), view_host_request.Pass(),
                          view_owner_request.Pass(), label);
}

void ViewManagerImpl::RegisterViewTree(
    mojo::ui::ViewTreePtr view_tree,
    mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request,
    const mojo::String& label) {
  registry_->RegisterViewTree(view_tree.Pass(), view_tree_host_request.Pass(),
                              label);
}

}  // namespace view_manager
