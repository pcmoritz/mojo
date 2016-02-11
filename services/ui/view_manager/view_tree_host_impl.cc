// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_tree_host_impl.h"

#include "base/bind.h"
#include "services/ui/view_manager/view_registry.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

ViewTreeHostImpl::ViewTreeHostImpl(ViewRegistry* registry, ViewTreeState* state)
    : registry_(registry), state_(state) {}

ViewTreeHostImpl::~ViewTreeHostImpl() {}

void ViewTreeHostImpl::GetToken(const GetTokenCallback& callback) {
  callback.Run(state_->view_tree_token()->Clone());
}

void ViewTreeHostImpl::GetServiceProvider(
    mojo::InterfaceRequest<mojo::ServiceProvider> service_provider) {
  service_provider_bindings_.AddBinding(this, service_provider.Pass());
}

void ViewTreeHostImpl::RequestLayout() {
  registry_->RequestLayout(state_);
}

void ViewTreeHostImpl::SetRoot(
    uint32_t root_key,
    mojo::InterfaceHandle<mojo::ui::ViewOwner> root_view_owner) {
  registry_->SetRoot(state_, root_key, root_view_owner.Pass());
}

void ViewTreeHostImpl::ResetRoot(mojo::InterfaceRequest<mojo::ui::ViewOwner>
                                     transferred_view_owner_request) {
  registry_->ResetRoot(state_, transferred_view_owner_request.Pass());
}

static void RunLayoutRootCallback(
    const ViewTreeHostImpl::LayoutRootCallback& callback,
    mojo::ui::ViewLayoutInfoPtr info) {
  callback.Run(info.Pass());
}

void ViewTreeHostImpl::LayoutRoot(
    mojo::ui::ViewLayoutParamsPtr root_layout_params,
    const LayoutRootCallback& callback) {
  registry_->LayoutRoot(state_, root_layout_params.Pass(),
                        base::Bind(&RunLayoutRootCallback, callback));
}

void ViewTreeHostImpl::ConnectToService(
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  registry_->ConnectToViewTreeService(state_, service_name,
                                      client_handle.Pass());
}

}  // namespace view_manager
