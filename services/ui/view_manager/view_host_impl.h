// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_HOST_IMPL_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_HOST_IMPL_H_

#include "base/macros.h"
#include "mojo/common/binding_set.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"

namespace view_manager {

class ViewRegistry;
class ViewState;

// ViewHost interface implementation.
// This object is owned by its associated ViewState.
class ViewHostImpl : public mojo::ui::ViewHost,
                     public mojo::ui::ViewOwner,
                     public mojo::ServiceProvider {
 public:
  ViewHostImpl(ViewRegistry* registry, ViewState* state);
  ~ViewHostImpl() override;

 private:
  // |ViewHost|:
  void GetToken(const mojo::ui::ViewHost::GetTokenCallback& callback) override;
  void GetServiceProvider(mojo::InterfaceRequest<mojo::ServiceProvider>
                              service_provider_request) override;
  void CreateScene(
      mojo::InterfaceRequest<mojo::gfx::composition::Scene> scene) override;
  void RequestLayout() override;
  void AddChild(uint32_t child_key,
                mojo::ui::ViewOwnerPtr child_view_owner) override;
  void RemoveChild(uint32_t child_key,
                   mojo::InterfaceRequest<mojo::ui::ViewOwner>
                       transferred_view_owner_request) override;
  void LayoutChild(uint32_t child_key,
                   mojo::ui::ViewLayoutParamsPtr child_layout_params,
                   const LayoutChildCallback& callback) override;

  // |ServiceProvider|:
  void ConnectToService(const mojo::String& service_name,
                        mojo::ScopedMessagePipeHandle client_handle) override;

  ViewRegistry* const registry_;
  ViewState* const state_;
  mojo::BindingSet<mojo::ServiceProvider> service_provider_bindings_;

  DISALLOW_COPY_AND_ASSIGN(ViewHostImpl);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_HOST_IMPL_H_
