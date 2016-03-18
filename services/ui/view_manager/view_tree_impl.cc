// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_tree_impl.h"

#include "base/bind.h"
#include "services/ui/view_manager/view_registry.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

ViewTreeImpl::ViewTreeImpl(ViewRegistry* registry, ViewTreeState* state)
    : registry_(registry), state_(state) {}

ViewTreeImpl::~ViewTreeImpl() {}

void ViewTreeImpl::GetToken(const GetTokenCallback& callback) {
  callback.Run(state_->view_tree_token()->Clone());
}

void ViewTreeImpl::GetServiceProvider(
    mojo::InterfaceRequest<mojo::ServiceProvider> service_provider) {
  service_provider_bindings_.AddBinding(this, service_provider.Pass());
}

void ViewTreeImpl::SetRenderer(
    mojo::InterfaceHandle<mojo::gfx::composition::Renderer> renderer) {
  registry_->SetRenderer(
      state_, mojo::gfx::composition::RendererPtr::Create(std::move(renderer)));
}

void ViewTreeImpl::RequestLayout() {
  registry_->RequestLayout(state_);
}

void ViewTreeImpl::GetContainer(
    mojo::InterfaceRequest<mojo::ui::ViewContainer> view_container_request) {
  container_bindings_.AddBinding(this, view_container_request.Pass());
}

void ViewTreeImpl::SetListener(
    mojo::InterfaceHandle<mojo::ui::ViewContainerListener> listener) {
  state_->set_view_container_listener(
      mojo::ui::ViewContainerListenerPtr::Create(std::move(listener)));
}

void ViewTreeImpl::AddChild(
    uint32_t child_key,
    mojo::InterfaceHandle<mojo::ui::ViewOwner> child_view_owner) {
  registry_->AddChild(state_, child_key, child_view_owner.Pass());
}

void ViewTreeImpl::RemoveChild(uint32_t child_key,
                               mojo::InterfaceRequest<mojo::ui::ViewOwner>
                                   transferred_view_owner_request) {
  registry_->RemoveChild(state_, child_key,
                         transferred_view_owner_request.Pass());
}

static void RunLayoutChildCallback(
    const ViewTreeImpl::LayoutChildCallback& callback,
    mojo::ui::ViewLayoutInfoPtr info) {
  callback.Run(info.Pass());
}

void ViewTreeImpl::LayoutChild(
    uint32_t child_key,
    mojo::ui::ViewLayoutParamsPtr child_layout_params,
    const LayoutChildCallback& callback) {
  registry_->LayoutChild(state_, child_key, child_layout_params.Pass(),
                         base::Bind(&RunLayoutChildCallback, callback));
}

void ViewTreeImpl::ConnectToService(
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  registry_->ConnectToViewTreeService(state_, service_name,
                                      client_handle.Pass());
}

}  // namespace view_manager
