// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_TREE_HOST_IMPL_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_TREE_HOST_IMPL_H_

#include "base/macros.h"
#include "mojo/common/binding_set.h"
#include "mojo/services/ui/views/interfaces/view_trees.mojom.h"

namespace view_manager {

class ViewRegistry;
class ViewTreeState;

// ViewTreeHost interface implementation.
// This object is owned by its associated ViewTreeState.
class ViewTreeHostImpl : public mojo::ui::ViewTreeHost,
                         public mojo::ServiceProvider {
 public:
  ViewTreeHostImpl(ViewRegistry* registry, ViewTreeState* state);
  ~ViewTreeHostImpl() override;

 private:
  // |ViewTreeHost|:
  void GetToken(const GetTokenCallback& callback) override;
  void GetServiceProvider(
      mojo::InterfaceRequest<mojo::ServiceProvider> service_provider) override;
  void RequestLayout() override;
  void SetRoot(uint32_t root_key,
               mojo::ui::ViewOwnerPtr root_view_owner) override;
  void ResetRoot(mojo::InterfaceRequest<mojo::ui::ViewOwner>
                     transferred_view_owner_request) override;
  void LayoutRoot(mojo::ui::ViewLayoutParamsPtr root_layout_params,
                  const LayoutRootCallback& callback) override;

  // |ServiceProvider|:
  void ConnectToService(const mojo::String& service_name,
                        mojo::ScopedMessagePipeHandle client_handle) override;

  ViewRegistry* const registry_;
  ViewTreeState* const state_;
  mojo::BindingSet<mojo::ServiceProvider> service_provider_bindings_;

  DISALLOW_COPY_AND_ASSIGN(ViewTreeHostImpl);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_TREE_HOST_IMPL_H_
