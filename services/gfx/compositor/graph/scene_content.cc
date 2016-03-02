// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/scene_content.h"

#include <ostream>

#include "base/logging.h"
#include "services/gfx/compositor/graph/scene_def.h"

namespace compositor {

SceneContent::SceneContent(const SceneLabel& label,
                           uint32_t version,
                           size_t max_resources,
                           size_t max_nodes)
    : label_(label),
      version_(version),
      resources_(max_resources),
      nodes_(max_nodes) {}

SceneContent::~SceneContent() {}

const ResourceDef* SceneContent::GetResource(
    uint32_t resource_id,
    ResourceDef::Type resource_type) const {
  auto it = resources_.find(resource_id);
  DCHECK(it != resources_.end());
  DCHECK(it->second->type() == resource_type);
  return it->second.get();
}

const NodeDef* SceneContent::GetNode(uint32_t node_id) const {
  auto it = nodes_.find(node_id);
  DCHECK(it != nodes_.end());
  return it->second.get();
}

const NodeDef* SceneContent::GetRootNodeIfExists() const {
  auto it = nodes_.find(mojo::gfx::composition::kSceneRootNodeId);
  return it != nodes_.end() ? it->second.get() : nullptr;
}

SceneContentBuilder::SceneContentBuilder(const SceneDef* scene,
                                         uint32_t version,
                                         std::ostream& err,
                                         size_t max_resources,
                                         size_t max_nodes)
    : content_(
          new SceneContent(scene->label(), version, max_resources, max_nodes)),
      scene_(scene),
      err_(err) {
  DCHECK(scene);
}

SceneContentBuilder::~SceneContentBuilder() {}

const ResourceDef* SceneContentBuilder::RequireResource(
    uint32_t resource_id,
    ResourceDef::Type resource_type,
    uint32_t referrer_node_id) {
  DCHECK(content_);

  auto it = content_->resources_.find(resource_id);
  if (it != content_->resources_.end())
    return it->second.get();

  const ResourceDef* resource = scene_->FindResource(resource_id);
  if (!resource) {
    err_ << "Missing resource " << resource_id << " referenced from node "
         << content_->FormattedLabelForNode(referrer_node_id);
    return nullptr;
  }

  if (resource->type() != resource_type) {
    err_ << "Resource " << resource_id << " referenced from node "
         << content_->FormattedLabelForNode(referrer_node_id)
         << " has incorrect type for its intended usage";
    return nullptr;
  }

  content_->resources_.emplace(std::make_pair(resource_id, resource));
  return resource;
}

const NodeDef* SceneContentBuilder::RequireNode(uint32_t node_id,
                                                uint32_t referrer_node_id) {
  DCHECK(content_);

  auto it = content_->nodes_.find(node_id);
  if (it != content_->nodes_.end()) {
    if (it->second)
      return it->second.get();
    err_ << "Cycle detected at node " << node_id << " referenced from node "
         << content_->FormattedLabelForNode(referrer_node_id);
    return nullptr;
  }

  const NodeDef* node = scene_->FindNode(node_id);
  if (!node) {
    err_ << "Missing node " << node_id << " referenced from node "
         << content_->FormattedLabelForNode(referrer_node_id);
    return nullptr;
  }

  return AddNode(node) ? node : nullptr;
}

bool SceneContentBuilder::AddNode(const NodeDef* node) {
  DCHECK(content_);
  DCHECK(node);

  // Reserve a spot in the table to mark the node recording in progress.
  DCHECK(content_->nodes_.size() < content_->nodes_.bucket_count());
  auto storage = content_->nodes_.emplace(node->node_id(), nullptr);
  DCHECK(storage.second);

  // Record the node's content.
  // This performs a depth first search of the node.  If it succeeds, we
  // will know that this part of the graph has no cycles.  Note that this
  // function may recurse back into |AddNode| to add additional nodes.
  if (!node->RecordContent(this))
    return false;

  // Store the node in the table.
  // It is safe to use the interator returned by emplace even though additional
  // nodes may have been added since the map's bucket count was initialized
  // at creation time to the total number of nodes so it should never be
  // rehashed during this traversal.
  storage.first->second = node;
  return true;
}

scoped_refptr<const SceneContent> SceneContentBuilder::Build() {
  DCHECK(content_);

  const NodeDef* root = scene_->FindRootNode();
  return !root || AddNode(root) ? std::move(content_) : nullptr;
}

}  // namespace compositor
