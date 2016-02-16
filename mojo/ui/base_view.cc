// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/base_view.h"

#include "base/logging.h"

namespace mojo {
namespace ui {

BaseView::BaseView(
    mojo::ApplicationImpl* app_impl,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    const std::string& label)
    : app_impl_(app_impl), view_listener_binding_(this) {
  DCHECK(app_impl_);
  app_impl_->ConnectToService("mojo:view_manager_service", &view_manager_);

  mojo::ui::ViewListenerPtr view_listener;
  view_listener_binding_.Bind(mojo::GetProxy(&view_listener));
  view_manager_->CreateView(mojo::GetProxy(&view_), view_owner_request.Pass(),
                            view_listener.Pass(), label);
  view_->CreateScene(mojo::GetProxy(&scene_));
  view_->GetServiceProvider(mojo::GetProxy(&view_service_provider_));
}

BaseView::~BaseView() {}

void BaseView::OnChildUnavailable(uint32_t child_key,
                                  const OnChildUnavailableCallback& callback) {
  callback.Run();
}

}  // namespace ui
}  // namespace mojo
