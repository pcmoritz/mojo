// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/base_view.h"

#include "base/logging.h"
#include "mojo/public/cpp/application/connect.h"

namespace mojo {
namespace ui {

BaseView::BaseView(
    mojo::ApplicationImpl* app_impl,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    const std::string& label)
    : app_impl_(app_impl),
      view_listener_binding_(this),
      view_container_listener_binding_(this) {
  DCHECK(app_impl_);
  ConnectToService(app_impl_->shell(), "mojo:view_manager_service",
                   mojo::GetProxy(&view_manager_));

  mojo::ui::ViewListenerPtr view_listener;
  view_listener_binding_.Bind(mojo::GetProxy(&view_listener));
  view_manager_->CreateView(mojo::GetProxy(&view_), view_owner_request.Pass(),
                            view_listener.Pass(), label);
  view_->CreateScene(mojo::GetProxy(&scene_));
}

BaseView::~BaseView() {}

mojo::ServiceProvider* BaseView::GetViewServiceProvider() {
  if (!view_service_provider_)
    view_->GetServiceProvider(mojo::GetProxy(&view_service_provider_));
  return view_service_provider_.get();
}

mojo::ui::ViewContainer* BaseView::GetViewContainer() {
  if (!view_container_) {
    view_->GetContainer(mojo::GetProxy(&view_container_));
    mojo::ui::ViewContainerListenerPtr view_container_listener;
    view_container_listener_binding_.Bind(
        mojo::GetProxy(&view_container_listener));
    view_container_->SetListener(view_container_listener.Pass());
  }
  return view_container_.get();
}

void BaseView::OnPropertiesChanged(uint32_t old_scene_version,
                                   mojo::ui::ViewPropertiesPtr old_properties) {
}

void BaseView::OnChildAttached(uint32_t child_key,
                               mojo::ui::ViewInfoPtr child_view_info) {}

void BaseView::OnChildUnavailable(uint32_t child_key) {}

void BaseView::OnPropertiesChanged(
    uint32_t scene_version,
    mojo::ui::ViewPropertiesPtr properties,
    const OnPropertiesChangedCallback& callback) {
  DCHECK(properties);
  DCHECK(properties->display_metrics);
  DCHECK(properties->view_layout);
  DCHECK(properties->view_layout->size);

  uint32_t old_scene_version = scene_version_;
  mojo::ui::ViewPropertiesPtr old_properties = properties_.Pass();
  scene_version_ = scene_version;
  properties_ = properties.Pass();

  OnPropertiesChanged(old_scene_version, old_properties.Pass());
  callback.Run();
}

void BaseView::OnChildAttached(uint32_t child_key,
                               mojo::ui::ViewInfoPtr child_view_info,
                               const OnChildUnavailableCallback& callback) {
  DCHECK(child_view_info);

  OnChildAttached(child_key, child_view_info.Pass());
  callback.Run();
}

void BaseView::OnChildUnavailable(uint32_t child_key,
                                  const OnChildUnavailableCallback& callback) {
  OnChildUnavailable(child_key);
  callback.Run();
}

}  // namespace ui
}  // namespace mojo
