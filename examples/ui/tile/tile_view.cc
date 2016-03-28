// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "examples/ui/tile/tile_view.h"
#include "mojo/services/geometry/cpp/geometry_util.h"

namespace examples {

namespace {
constexpr uint32_t kViewResourceIdBase = 100;
constexpr uint32_t kViewResourceIdSpacing = 100;

constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;
constexpr uint32_t kViewNodeIdBase = 100;
constexpr uint32_t kViewNodeIdSpacing = 100;
constexpr uint32_t kViewSceneNodeIdOffset = 1;
constexpr uint32_t kViewFallbackSceneNodeIdOffset = 2;
constexpr uint32_t kViewFallbackColorNodeIdOffset = 3;
}  // namespace

TileView::TileView(
    mojo::ApplicationImpl* app_impl,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    const std::vector<std::string>& view_urls)
    : BaseView(app_impl, view_owner_request.Pass(), "Tile"),
      view_urls_(view_urls) {
  ConnectViews();
}

TileView::~TileView() {}

void TileView::ConnectViews() {
  uint32_t child_key = 0;
  for (const auto& url : view_urls_) {
    // Start connecting to the view provider.
    mojo::ui::ViewProviderPtr provider;
    app_impl()->ConnectToService(url, &provider);

    LOG(INFO) << "Connecting to view: child_key=" << child_key
              << ", url=" << url;
    mojo::ui::ViewOwnerPtr child_view_owner;
    provider->CreateView(mojo::GetProxy(&child_view_owner), nullptr, nullptr);

    GetViewContainer()->AddChild(child_key, child_view_owner.Pass());
    views_.emplace(std::make_pair(
        child_key, std::unique_ptr<ViewData>(new ViewData(url, child_key))));

    child_key++;
  }
}

void TileView::OnChildAttached(uint32_t child_key,
                               mojo::ui::ViewInfoPtr child_view_info) {
  auto it = views_.find(child_key);
  DCHECK(it != views_.end());

  ViewData* view_data = it->second.get();
  view_data->view_info = child_view_info.Pass();

  UpdateScene();
}

void TileView::OnChildUnavailable(uint32_t child_key) {
  auto it = views_.find(child_key);
  DCHECK(it != views_.end());
  LOG(ERROR) << "View died unexpectedly: child_key=" << child_key
             << ", url=" << it->second->url;

  std::unique_ptr<ViewData> view_data = std::move(it->second);
  views_.erase(it);

  GetViewContainer()->RemoveChild(child_key, nullptr);
}

void TileView::OnPropertiesChanged(uint32_t old_scene_version,
                                   mojo::ui::ViewPropertiesPtr old_properties) {
  if (!properties())
    return;

  // Layout all children in a row.
  if (!views_.empty()) {
    const mojo::Size& size = *properties()->view_layout->size;
    uint32_t index = 0;
    uint32_t base_width = size.width / views_.size();
    uint32_t excess_width = size.width % views_.size();
    uint32_t x = 0;
    for (auto it = views_.begin(); it != views_.end(); ++it, ++index) {
      ViewData* view_data = it->second.get();

      // Distribute any excess width among the leading children.
      uint32_t child_width = base_width;
      if (excess_width) {
        child_width++;
        excess_width--;
      }
      uint32_t child_height = size.height;
      uint32_t child_x = x;
      x += child_width;

      view_data->layout_bounds.x = child_x;
      view_data->layout_bounds.y = 0;
      view_data->layout_bounds.width = child_width;
      view_data->layout_bounds.height = child_height;

      auto view_properties = mojo::ui::ViewProperties::New();
      view_properties->view_layout = mojo::ui::ViewLayout::New();
      view_properties->view_layout->size = mojo::Size::New();
      view_properties->view_layout->size->width = child_width;
      view_properties->view_layout->size->height = child_height;

      if (view_data->view_properties.Equals(view_properties))
        continue;  // no layout work to do

      view_data->view_properties = view_properties.Clone();
      view_data->scene_version++;
      GetViewContainer()->SetChildProperties(
          it->first, view_data->scene_version, view_properties.Pass());
    }
  }

  UpdateScene();
}

void TileView::UpdateScene() {
  // Update the scene.
  // TODO: only send the resources once, be more incremental
  auto update = mojo::gfx::composition::SceneUpdate::New();
  update->clear_resources = true;
  update->clear_nodes = true;

  // Create the root node.
  auto root_node = mojo::gfx::composition::Node::New();

  // Add the children.
  for (auto it = views_.cbegin(); it != views_.cend(); it++) {
    const ViewData& view_data = *(it->second.get());
    const uint32_t scene_resource_id =
        kViewResourceIdBase + view_data.key * kViewResourceIdSpacing;
    const uint32_t container_node_id =
        kViewNodeIdBase + view_data.key * kViewNodeIdSpacing;
    const uint32_t scene_node_id = container_node_id + kViewSceneNodeIdOffset;

    mojo::RectF extent;
    extent.width = view_data.layout_bounds.width;
    extent.height = view_data.layout_bounds.height;

    // Create a container to represent the place where the child view
    // will be presented.  The children of the container provide
    // fallback behavior in case the view is not available.
    auto container_node = mojo::gfx::composition::Node::New();
    container_node->content_clip = extent.Clone();
    container_node->content_transform = mojo::Transform::New();
    SetTranslationTransform(container_node->content_transform.get(),
                            view_data.layout_bounds.x,
                            view_data.layout_bounds.y, 0.f);
    container_node->combinator =
        mojo::gfx::composition::Node::Combinator::FALLBACK;

    // If we have the view, add it to the scene.
    if (view_data.view_info) {
      auto scene_resource = mojo::gfx::composition::Resource::New();
      scene_resource->set_scene(mojo::gfx::composition::SceneResource::New());
      scene_resource->get_scene()->scene_token =
          view_data.view_info->scene_token.Clone();
      update->resources.insert(scene_resource_id, scene_resource.Pass());

      auto scene_node = mojo::gfx::composition::Node::New();
      scene_node->op = mojo::gfx::composition::NodeOp::New();
      scene_node->op->set_scene(mojo::gfx::composition::SceneNodeOp::New());
      scene_node->op->get_scene()->scene_resource_id = scene_resource_id;
      scene_node->op->get_scene()->scene_version = view_data.scene_version;
      update->nodes.insert(scene_node_id, scene_node.Pass());
      container_node->child_node_ids.push_back(scene_node_id);
    }

    // TODO(jeffbrown): Reenable once everything works or make configurable.
    if (false) {
      // Add the fallback scene content, use last available version.
      const uint32_t fallback_node_id =
          container_node_id + kViewFallbackSceneNodeIdOffset;
      auto fallback_node = mojo::gfx::composition::Node::New();
      fallback_node->op = mojo::gfx::composition::NodeOp::New();
      fallback_node->op->set_scene(mojo::gfx::composition::SceneNodeOp::New());
      fallback_node->op->get_scene()->scene_resource_id = scene_resource_id;
      update->nodes.insert(fallback_node_id, fallback_node.Pass());
      container_node->child_node_ids.push_back(fallback_node_id);
    }
    if (false) {
      // Add the fallback color content, fill with solid color.
      const uint32_t fallback_node_id =
          container_node_id + kViewFallbackColorNodeIdOffset;
      auto fallback_node = mojo::gfx::composition::Node::New();
      fallback_node->op = mojo::gfx::composition::NodeOp::New();
      fallback_node->op->set_rect(mojo::gfx::composition::RectNodeOp::New());
      fallback_node->op->get_rect()->content_rect = extent.Clone();
      fallback_node->op->get_rect()->color =
          mojo::gfx::composition::Color::New();
      fallback_node->op->get_rect()->color->red = 255;
      fallback_node->op->get_rect()->color->alpha = 255;
      update->nodes.insert(fallback_node_id, fallback_node.Pass());
      container_node->child_node_ids.push_back(fallback_node_id);
    }

    // Add the container.
    update->nodes.insert(container_node_id, container_node.Pass());
    root_node->child_node_ids.push_back(container_node_id);
  }

  // Add the root node.
  update->nodes.insert(kRootNodeId, root_node.Pass());
  scene()->Update(update.Pass());

  // Publish the scene.
  auto metadata = mojo::gfx::composition::SceneMetadata::New();
  metadata->version = scene_version();
  scene()->Publish(metadata.Pass());
}

TileView::ViewData::ViewData(const std::string& url, uint32_t key)
    : url(url), key(key) {}

TileView::ViewData::~ViewData() {}

}  // namespace examples
