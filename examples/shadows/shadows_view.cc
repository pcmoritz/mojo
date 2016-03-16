// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/shadows/shadows_view.h"

#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>

#include "base/bind.h"
#include "base/logging.h"
#include "mojo/services/geometry/cpp/geometry_util.h"

namespace examples {

namespace {
constexpr uint32_t kContentImageResourceId = 1;
constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;
}  // namespace

ShadowsView::ShadowsView(
    mojo::ApplicationImpl* app_impl,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request)
    : GLView(app_impl, view_owner_request.Pass(), "Shadows"),
      choreographer_(scene(), this) {
  gl_renderer()->gl_context()->MakeCurrent();
}

ShadowsView::~ShadowsView() {}

void ShadowsView::OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                           mojo::Array<uint32_t> children_needing_layout,
                           const OnLayoutCallback& callback) {
  size_.width = layout_params->constraints->max_width;
  size_.height = layout_params->constraints->max_height;

  // Submit the new layout information.
  auto info = mojo::ui::ViewLayoutResult::New();
  info->size = size_.Clone();
  callback.Run(info.Pass());

  // Draw!
  choreographer_.ScheduleDraw();
}

void ShadowsView::OnDraw(
    const mojo::gfx::composition::FrameInfo& frame_info,
    const base::TimeDelta& time_delta) {

  // Update the contents of the scene.
  mojo::RectF bounds;
  bounds.width = size_.width;
  bounds.height = size_.height;

  auto update = mojo::gfx::composition::SceneUpdate::New();
  mojo::gfx::composition::ResourcePtr content_resource = gl_renderer()->DrawGL(
      size_, true,
      base::Bind(&ShadowsView::Render, base::Unretained(this)));
  DCHECK(content_resource);
  update->resources.insert(kContentImageResourceId, content_resource.Pass());

  auto root_node = mojo::gfx::composition::Node::New();
  root_node->content_transform = mojo::Transform::New();
  mojo::SetIdentityTransform(root_node->content_transform.get());
  root_node->hit_test_behavior = mojo::gfx::composition::HitTestBehavior::New();
  root_node->op = mojo::gfx::composition::NodeOp::New();
  root_node->op->set_image(mojo::gfx::composition::ImageNodeOp::New());
  root_node->op->get_image()->content_rect = bounds.Clone();
  root_node->op->get_image()->image_resource_id = kContentImageResourceId;
  update->nodes.insert(kRootNodeId, root_node.Pass());

  auto metadata = mojo::gfx::composition::SceneMetadata::New();
  metadata->presentation_time = frame_info.presentation_time;

  // Publish the scene.
  scene()->Update(update.Pass());
  scene()->Publish(metadata.Pass());
}

void ShadowsView::Render() {
  glClearColor(0.0f, 1.0f, 0.0f, 1.0f);
  glClear(GL_COLOR_BUFFER_BIT);
}

}  // namespace examples
