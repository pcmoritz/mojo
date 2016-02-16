// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_impl.h"

#include "base/bind.h"
#include "services/ui/view_manager/view_registry.h"
#include "services/ui/view_manager/view_state.h"

namespace view_manager {

ViewImpl::ViewImpl(ViewRegistry* registry, ViewState* state)
    : registry_(registry), state_(state) {}

ViewImpl::~ViewImpl() {}

void ViewImpl::GetToken(const mojo::ui::View::GetTokenCallback& callback) {
  callback.Run(state_->view_token()->Clone());
}

void ViewImpl::GetServiceProvider(
    mojo::InterfaceRequest<mojo::ServiceProvider> service_provider_request) {
  service_provider_bindings_.AddBinding(this, service_provider_request.Pass());
}

void ViewImpl::CreateScene(
    mojo::InterfaceRequest<mojo::gfx::composition::Scene> scene) {
  registry_->CreateScene(state_, scene.Pass());
}

void ViewImpl::RequestLayout() {
  registry_->RequestLayout(state_);
}

void ViewImpl::AddChild(
    uint32_t child_key,
    mojo::InterfaceHandle<mojo::ui::ViewOwner> child_view_owner) {
  registry_->AddChild(state_, child_key, child_view_owner.Pass());
}

void ViewImpl::RemoveChild(uint32_t child_key,
                           mojo::InterfaceRequest<mojo::ui::ViewOwner>
                               transferred_view_owner_request) {
  registry_->RemoveChild(state_, child_key,
                         transferred_view_owner_request.Pass());
}

static void RunLayoutChildCallback(
    const ViewImpl::LayoutChildCallback& callback,
    mojo::ui::ViewLayoutInfoPtr info) {
  callback.Run(info.Pass());
}

void ViewImpl::LayoutChild(uint32_t child_key,
                           mojo::ui::ViewLayoutParamsPtr child_layout_params,
                           const LayoutChildCallback& callback) {
  registry_->LayoutChild(state_, child_key, child_layout_params.Pass(),
                         base::Bind(&RunLayoutChildCallback, callback));
}

void ViewImpl::ConnectToService(const mojo::String& service_name,
                                mojo::ScopedMessagePipeHandle client_handle) {
  registry_->ConnectToViewService(state_, service_name, client_handle.Pass());
}

}  // namespace view_manager
