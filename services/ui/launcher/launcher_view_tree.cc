// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/launcher/launcher_view_tree.h"

#include "base/bind.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/services/gfx/composition/cpp/formatting.h"
#include "mojo/services/ui/views/cpp/formatting.h"

namespace launcher {

LauncherViewTree::LauncherViewTree(
    mojo::gfx::composition::Compositor* compositor,
    mojo::ui::ViewManager* view_manager,
    mojo::ContextProviderPtr context_provider,
    mojo::ViewportMetricsPtr viewport_metrics,
    const base::Closure& shutdown_callback)
    : compositor_(compositor),
      view_manager_(view_manager),
      context_provider_(context_provider.Pass()),
      viewport_metrics_(viewport_metrics.Pass()),
      shutdown_callback_(shutdown_callback),
      view_tree_listener_binding_(this) {
  // Register the view tree.
  mojo::ui::ViewTreeListenerPtr view_tree_listener;
  view_tree_listener_binding_.Bind(mojo::GetProxy(&view_tree_listener));
  view_manager_->CreateViewTree(mojo::GetProxy(&view_tree_),
                                view_tree_listener.Pass(), "Launcher");
  view_tree_.set_connection_error_handler(base::Bind(
      &LauncherViewTree::OnViewTreeConnectionError, base::Unretained(this)));

  // Get view tree services.
  mojo::ServiceProviderPtr view_tree_service_provider;
  view_tree_->GetServiceProvider(mojo::GetProxy(&view_tree_service_provider));
  mojo::ConnectToService<mojo::ui::InputDispatcher>(
      view_tree_service_provider.get(), &input_dispatcher_);
  input_dispatcher_.set_connection_error_handler(
      base::Bind(&LauncherViewTree::OnInputDispatcherConnectionError,
                 base::Unretained(this)));

  // Attach the renderer.
  mojo::gfx::composition::RendererPtr renderer;
  compositor_->CreateRenderer(context_provider_.Pass(), GetProxy(&renderer),
                              "Launcher");
  view_tree_->SetRenderer(renderer.Pass());
}

LauncherViewTree::~LauncherViewTree() {}

void LauncherViewTree::SetRoot(mojo::ui::ViewOwnerPtr owner) {
  if (owner) {
    view_tree_->SetRoot(++root_key_, owner.Pass());
    root_was_set_ = true;
  } else {
    view_tree_->ResetRoot(nullptr);
    root_was_set_ = false;
  }
  root_layout_info_.reset();
}

void LauncherViewTree::SetViewportMetrics(
    mojo::ViewportMetricsPtr viewport_metrics) {
  viewport_metrics_ = viewport_metrics.Pass();
  view_tree_->RequestLayout();
}

void LauncherViewTree::DispatchEvent(mojo::EventPtr event) {
  if (input_dispatcher_)
    input_dispatcher_->DispatchEvent(event.Pass());
}

void LauncherViewTree::OnViewTreeConnectionError() {
  LOG(ERROR) << "View tree connection error.";
  Shutdown();
}

void LauncherViewTree::OnInputDispatcherConnectionError() {
  // This isn't considered a fatal error right now since it is still useful
  // to be able to test a view system that has graphics but no input.
  LOG(WARNING) << "Input dispatcher connection error, input will not work.";
  input_dispatcher_.reset();
}

void LauncherViewTree::OnLayout(const OnLayoutCallback& callback) {
  LayoutRoot();
  callback.Run();
}

void LauncherViewTree::OnRootUnavailable(
    uint32_t root_key,
    const OnRootUnavailableCallback& callback) {
  if (root_key_ == root_key) {
    LOG(ERROR) << "Root view terminated unexpectedly.";
    Shutdown();
  }
  callback.Run();
}

void LauncherViewTree::OnRendererDied(const OnRendererDiedCallback& callback) {
  LOG(ERROR) << "Renderer died unexpectedly.";
  Shutdown();
  callback.Run();
}

void LauncherViewTree::LayoutRoot() {
  if (!root_was_set_)
    return;

  auto params = mojo::ui::ViewLayoutParams::New();
  params->constraints = mojo::ui::BoxConstraints::New();
  params->constraints->min_width = viewport_metrics_->size->width;
  params->constraints->max_width = viewport_metrics_->size->width;
  params->constraints->min_height = viewport_metrics_->size->height;
  params->constraints->max_height = viewport_metrics_->size->height;
  params->device_pixel_ratio = viewport_metrics_->device_pixel_ratio;
  view_tree_->LayoutRoot(
      params.Pass(),
      base::Bind(&LauncherViewTree::OnLayoutResult, base::Unretained(this)));
}

void LauncherViewTree::OnLayoutResult(mojo::ui::ViewLayoutInfoPtr info) {
  if (!info) {
    DVLOG(1) << "Root layout: <stale>";
    return;
  }

  DVLOG(1) << "Root layout: size.width=" << info->size->width
           << ", size.height=" << info->size->height
           << ", scene_token.value=" << info->scene_token->value;

  root_layout_info_ = info.Pass();
}

void LauncherViewTree::Shutdown() {
  shutdown_callback_.Run();
}

}  // namespace launcher
