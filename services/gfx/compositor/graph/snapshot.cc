// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/snapshot.h"

#include "base/logging.h"
#include "services/gfx/compositor/graph/scene_content.h"
#include "services/gfx/compositor/graph/scene_def.h"
#include "services/gfx/compositor/render/render_frame.h"
#include "third_party/skia/include/core/SkPictureRecorder.h"
#include "third_party/skia/include/core/SkRect.h"

namespace compositor {

Snapshot::Snapshot() {}

Snapshot::~Snapshot() {}

bool Snapshot::Invalidate() {
  if (valid_) {
    valid_ = false;
    dependencies_.clear();
    ClearContent();
    return true;
  }
  return false;
}

bool Snapshot::InvalidateScene(const SceneDef* scene_def) {
  DCHECK(scene_def);
  return valid_ &&
         dependencies_.find(scene_def->label().token()) !=
             dependencies_.end() &&
         Invalidate();
}

void Snapshot::ClearContent() {
  root_scene_content_ = nullptr;
  resolved_scene_contents_.clear();
  node_dispositions_.clear();
  frame_.reset();
}

bool Snapshot::IsBlocked(const NodeDef* node) const {
  DCHECK(valid_);
  auto it = node_dispositions_.find(node);
  DCHECK(it != node_dispositions_.end());
  DCHECK(it->second == Disposition::kSuccess ||
         it->second == Disposition::kBlocked);
  return it->second == Disposition::kBlocked;
}

const SceneContent* Snapshot::GetResolvedSceneContent(
    const SceneNodeDef* scene_node) const {
  DCHECK(valid_);
  auto it = resolved_scene_contents_.find(scene_node);
  DCHECK(it != resolved_scene_contents_.end());
  return it->second.get();
}

SnapshotBuilder::SnapshotBuilder(std::ostream* block_log)
    : block_log_(block_log), snapshot_(new Snapshot()) {}

SnapshotBuilder::~SnapshotBuilder() {}

Snapshot::Disposition SnapshotBuilder::SnapshotNode(
    const NodeDef* node,
    const SceneContent* content) {
  DCHECK(snapshot_);
  DCHECK(node);
  DCHECK(content);
  DCHECK(node != content->GetRootNodeIfExists());

  auto it = snapshot_->node_dispositions_.find(node);
  if (it != snapshot_->node_dispositions_.end())
    return it->second;

  Snapshot::Disposition disposition = node->RecordSnapshot(content, this);
  snapshot_->node_dispositions_[node] = disposition;
  return disposition;
}

Snapshot::Disposition SnapshotBuilder::SnapshotRootAndDetectCycles(
    const NodeDef* node,
    const SceneContent* content) {
  DCHECK(snapshot_);
  DCHECK(node);
  DCHECK(content);
  DCHECK(node == content->GetRootNodeIfExists());

  auto storage = snapshot_->node_dispositions_.emplace(
      node, Snapshot::Disposition::kCycle);
  if (!storage.second) {
    if (storage.first->second == Snapshot::Disposition::kCycle)
      cycle_ = content;  // start unwinding, remember where to stop
    return storage.first->second;
  }

  Snapshot::Disposition disposition = node->RecordSnapshot(content, this);
  if (disposition == Snapshot::Disposition::kSuccess) {
    snapshot_->node_dispositions_[node] = disposition;
    return disposition;
  }

  // We cannot reuse the iterator in |storage.first| because it may have
  // been invalidated by the call to |RecordSnapshot| due to rehashing so
  // we must look up the node again just in case.
  snapshot_->node_dispositions_[node] = Snapshot::Disposition::kBlocked;

  if (disposition == Snapshot::Disposition::kCycle) {
    DCHECK(cycle_);
    if (block_log_) {
      *block_log_ << "Scene blocked because it is part of a cycle: "
                  << content->FormattedLabel() << std::endl;
    }
    if (cycle_ == content) {
      cycle_ = nullptr;  // found the ouroboros tail, stop unwinding
      disposition = Snapshot::Disposition::kBlocked;
    }
  }
  return disposition;
}
Snapshot::Disposition SnapshotBuilder::SnapshotScene(
    const SceneDef* scene,
    uint32_t version,
    const SceneNodeDef* referrer_node,
    const SceneContent* referrer_content) {
  DCHECK(snapshot_);
  DCHECK(scene);
  DCHECK(referrer_node);
  DCHECK(referrer_content);

  // This function should only ever be called once when snapshotting the
  // referring |SceneNodeDef| at which point the result will be memoized
  // by |SnapshotNode| as usual so reentrance should not occur.
  DCHECK(snapshot_->resolved_scene_contents_.find(referrer_node) ==
         snapshot_->resolved_scene_contents_.end());

  snapshot_->dependencies_.insert(scene->label().token());

  const SceneContent* content = scene->FindContent(version);
  if (!content) {
    if (block_log_) {
      *block_log_ << "Scene node blocked because its referenced scene is not "
                     "available with the requested version: "
                  << referrer_node->FormattedLabel(referrer_content)
                  << ", scene " << scene->label().FormattedLabel()
                  << ", requested version " << version << ", current version "
                  << scene->version() << std::endl;
    }
    return Snapshot::Disposition::kBlocked;
  }

  const NodeDef* root = content->GetRootNodeIfExists();
  if (!root) {
    if (block_log_) {
      *block_log_ << "Scene node blocked because its referenced scene has no "
                     "root node: "
                  << referrer_node->FormattedLabel(referrer_content)
                  << ", scene " << content->FormattedLabel() << std::endl;
    }
    return Snapshot::Disposition::kBlocked;
  }

  snapshot_->resolved_scene_contents_[referrer_node] = content;
  return SnapshotRootAndDetectCycles(root, content);
}

Snapshot::Disposition SnapshotBuilder::SnapshotRenderer(const SceneDef* scene) {
  DCHECK(!snapshot_->root_scene_content_);

  snapshot_->dependencies_.insert(scene->label().token());

  const SceneContent* content =
      scene->FindContent(mojo::gfx::composition::kSceneVersionNone);
  if (!content) {
    if (block_log_) {
      *block_log_ << "Rendering blocked because the root scene has no content: "
                  << scene->label().FormattedLabel() << std::endl;
    }
    return Snapshot::Disposition::kBlocked;
  }

  const NodeDef* root = content->GetRootNodeIfExists();
  if (!root) {
    if (block_log_) {
      *block_log_ << "Rendering blocked the root scene has no root node: "
                  << content->FormattedLabel() << std::endl;
    }
    return Snapshot::Disposition::kBlocked;
  }

  snapshot_->root_scene_content_ = content;
  return SnapshotRootAndDetectCycles(root, content);
}

std::unique_ptr<Snapshot> SnapshotBuilder::Build(
    const SceneDef* root_scene,
    const mojo::Rect& viewport,
    const mojo::gfx::composition::FrameInfo& frame_info) {
  DCHECK(snapshot_);
  DCHECK(root_scene);

  Snapshot::Disposition disposition = SnapshotRenderer(root_scene);
  DCHECK(!cycle_);  // must have properly unwound any cycles by now

  if (disposition == Snapshot::Disposition::kSuccess) {
    SkRect sk_viewport = SkRect::MakeXYWH(viewport.x, viewport.y,
                                          viewport.width, viewport.height);
    SkPictureRecorder recorder;
    recorder.beginRecording(sk_viewport);

    const NodeDef* root_node =
        snapshot_->root_scene_content_->GetRootNodeIfExists();
    DCHECK(root_node);  // otherwise would have failed to snapshot
    root_node->RecordPicture(snapshot_->root_scene_content_.get(),
                             snapshot_.get(), recorder.getRecordingCanvas());

    snapshot_->frame_ =
        RenderFrame::Create(skia::AdoptRef(recorder.endRecordingAsPicture()),
                            sk_viewport, frame_info);
  } else {
    snapshot_->ClearContent();
  }
  return std::move(snapshot_);
}

}  // namespace compositor
