// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/node_def.h"

#include <ostream>

#include "base/logging.h"
#include "mojo/services/gfx/composition/cpp/formatting.h"
#include "mojo/skia/type_converters.h"
#include "services/gfx/compositor/graph/scene_content.h"
#include "services/gfx/compositor/graph/scene_def.h"
#include "services/gfx/compositor/graph/snapshot.h"
#include "services/gfx/compositor/render/render_image.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkColor.h"
#include "third_party/skia/include/core/SkPaint.h"
#include "third_party/skia/include/core/SkRect.h"

namespace compositor {
namespace {
SkColor MakeSkColor(const mojo::gfx::composition::Color& color) {
  return SkColorSetARGBInline(color.alpha, color.red, color.green, color.blue);
}

void SetPaintForBlend(SkPaint* paint, mojo::gfx::composition::Blend* blend) {
  DCHECK(paint);
  if (blend)
    paint->setAlpha(blend->alpha);
}
}  // namespace

NodeDef::NodeDef(uint32_t node_id,
                 mojo::TransformPtr content_transform,
                 mojo::RectPtr content_clip,
                 Combinator combinator,
                 const std::vector<uint32_t>& child_node_ids)
    : node_id_(node_id),
      content_transform_(content_transform.Pass()),
      content_clip_(content_clip.Pass()),
      combinator_(combinator),
      child_node_ids_(child_node_ids) {}

NodeDef::~NodeDef() {}

std::string NodeDef::FormattedLabel(const SceneContent* content) const {
  return content->FormattedLabelForNode(node_id_);
}

bool NodeDef::RecordContent(SceneContentBuilder* builder) const {
  DCHECK(builder);

  for (const auto& child_node_id : child_node_ids_) {
    if (!builder->RequireNode(child_node_id, node_id_))
      return false;
  }
  return true;
}

Snapshot::Disposition NodeDef::RecordSnapshot(const SceneContent* content,
                                              SnapshotBuilder* builder) const {
  DCHECK(content);
  DCHECK(builder);

  switch (combinator_) {
    // MERGE: All or nothing.
    case Combinator::MERGE: {
      for (uint32_t child_node_id : child_node_ids_) {
        const NodeDef* child_node = content->GetNode(child_node_id);
        DCHECK(child_node);
        Snapshot::Disposition disposition =
            builder->SnapshotNode(child_node, content);
        if (disposition == Snapshot::Disposition::kCycle)
          return disposition;
        if (disposition == Snapshot::Disposition::kBlocked) {
          if (builder->block_log()) {
            *builder->block_log()
                << "Node with MERGE combinator blocked since "
                   "one of its children is blocked: "
                << FormattedLabel(content) << ", blocked child "
                << child_node->FormattedLabel(content) << std::endl;
          }
          return disposition;
        }
      }
      return Snapshot::Disposition::kSuccess;
    }

    // PRUNE: Silently discard blocked children.
    case Combinator::PRUNE: {
      for (uint32_t child_node_id : child_node_ids_) {
        const NodeDef* child_node = content->GetNode(child_node_id);
        DCHECK(child_node);
        Snapshot::Disposition disposition =
            builder->SnapshotNode(child_node, content);
        if (disposition == Snapshot::Disposition::kCycle)
          return disposition;
      }
      return Snapshot::Disposition::kSuccess;
    }

    // FALLBACK: Keep only the first unblocked child.
    case Combinator::FALLBACK: {
      if (child_node_ids_.empty())
        return Snapshot::Disposition::kSuccess;
      for (uint32_t child_node_id : child_node_ids_) {
        const NodeDef* child_node = content->GetNode(child_node_id);
        DCHECK(child_node);
        Snapshot::Disposition disposition =
            builder->SnapshotNode(child_node, content);
        if (disposition != Snapshot::Disposition::kBlocked)
          return disposition;
      }
      if (builder->block_log()) {
        *builder->block_log() << "Node with FALLBACK combinator blocked since "
                                 "all of its children are blocked: "
                              << FormattedLabel(content) << std::endl;
      }
      return Snapshot::Disposition::kBlocked;
    }

    default: {
      if (builder->block_log()) {
        *builder->block_log()
            << "Unrecognized combinator: " << FormattedLabel(content)
            << std::endl;
      }
      return Snapshot::Disposition::kBlocked;
    }
  }
}

template <typename Func>
void NodeDef::TraverseSnapshottedChildren(const SceneContent* content,
                                          const Snapshot* snapshot,
                                          const Func& func) const {
  DCHECK(content);
  DCHECK(snapshot);

  switch (combinator_) {
    // MERGE: All or nothing.
    case Combinator::MERGE: {
      for (uint32_t child_node_id : child_node_ids_) {
        const NodeDef* child_node = content->GetNode(child_node_id);
        DCHECK(child_node);
        DCHECK(!snapshot->IsBlocked(child_node));
        if (!func(child_node))
          return;
      }
      return;
    }

    // PRUNE: Silently discard blocked children.
    case Combinator::PRUNE: {
      for (uint32_t child_node_id : child_node_ids_) {
        const NodeDef* child_node = content->GetNode(child_node_id);
        DCHECK(child_node);
        if (!snapshot->IsBlocked(child_node) && !func(child_node))
          return;
      }
      return;
    }

    // FALLBACK: Keep only the first unblocked child.
    case Combinator::FALLBACK: {
      if (child_node_ids_.empty())
        return;
      for (uint32_t child_node_id : child_node_ids_) {
        const NodeDef* child_node = content->GetNode(child_node_id);
        DCHECK(child_node);
        if (!snapshot->IsBlocked(child_node)) {
          func(child_node);  // don't care about the result because we
          return;            // always stop after the first one
        }
      }
      NOTREACHED();
      return;
    }

    default: {
      NOTREACHED();
      return;
    }
  }
}

void NodeDef::RecordPicture(const SceneContent* content,
                            const Snapshot* snapshot,
                            SkCanvas* canvas) const {
  DCHECK(content);
  DCHECK(snapshot);
  DCHECK(canvas);

  const bool must_save = content_transform_ || content_clip_;
  if (must_save) {
    canvas->save();
    if (content_transform_)
      canvas->concat(content_transform_.To<SkMatrix>());
    if (content_clip_)
      canvas->clipRect(content_clip_->To<SkRect>());
  }

  RecordPictureInner(content, snapshot, canvas);

  if (must_save)
    canvas->restore();
}

void NodeDef::RecordPictureInner(const SceneContent* content,
                                 const Snapshot* snapshot,
                                 SkCanvas* canvas) const {
  DCHECK(content);
  DCHECK(snapshot);
  DCHECK(canvas);

  TraverseSnapshottedChildren(
      content, snapshot,
      [this, content, snapshot, canvas](const NodeDef* child_node) -> bool {
        child_node->RecordPicture(content, snapshot, canvas);
        return true;
      });
}

RectNodeDef::RectNodeDef(uint32_t node_id,
                         mojo::TransformPtr content_transform,
                         mojo::RectPtr content_clip,
                         Combinator combinator,
                         const std::vector<uint32_t>& child_node_ids,
                         const mojo::Rect& content_rect,
                         const mojo::gfx::composition::Color& color)
    : NodeDef(node_id,
              content_transform.Pass(),
              content_clip.Pass(),
              combinator,
              child_node_ids),
      content_rect_(content_rect),
      color_(color) {}

RectNodeDef::~RectNodeDef() {}

void RectNodeDef::RecordPictureInner(const SceneContent* content,
                                     const Snapshot* snapshot,
                                     SkCanvas* canvas) const {
  DCHECK(content);
  DCHECK(snapshot);
  DCHECK(canvas);

  SkPaint paint;
  paint.setColor(MakeSkColor(color_));
  canvas->drawRect(content_rect_.To<SkRect>(), paint);

  NodeDef::RecordPictureInner(content, snapshot, canvas);
}

ImageNodeDef::ImageNodeDef(uint32_t node_id,
                           mojo::TransformPtr content_transform,
                           mojo::RectPtr content_clip,
                           Combinator combinator,
                           const std::vector<uint32_t>& child_node_ids,
                           const mojo::Rect& content_rect,
                           mojo::RectPtr image_rect,
                           uint32 image_resource_id,
                           mojo::gfx::composition::BlendPtr blend)
    : NodeDef(node_id,
              content_transform.Pass(),
              content_clip.Pass(),
              combinator,
              child_node_ids),
      content_rect_(content_rect),
      image_rect_(image_rect.Pass()),
      image_resource_id_(image_resource_id),
      blend_(blend.Pass()) {}

ImageNodeDef::~ImageNodeDef() {}

bool ImageNodeDef::RecordContent(SceneContentBuilder* builder) const {
  DCHECK(builder);

  return NodeDef::RecordContent(builder) &&
         builder->RequireResource(image_resource_id_, ResourceDef::Type::kImage,
                                  node_id());
}

void ImageNodeDef::RecordPictureInner(const SceneContent* content,
                                      const Snapshot* snapshot,
                                      SkCanvas* canvas) const {
  DCHECK(content);
  DCHECK(snapshot);
  DCHECK(canvas);

  auto image_resource = static_cast<const ImageResourceDef*>(
      content->GetResource(image_resource_id_, ResourceDef::Type::kImage));
  DCHECK(image_resource);

  SkPaint paint;
  SetPaintForBlend(&paint, blend_.get());

  canvas->drawImageRect(image_resource->image()->image().get(),
                        image_rect_
                            ? image_rect_->To<SkRect>()
                            : SkRect::MakeWH(image_resource->image()->width(),
                                             image_resource->image()->height()),
                        content_rect_.To<SkRect>(), &paint);

  NodeDef::RecordPictureInner(content, snapshot, canvas);
}

SceneNodeDef::SceneNodeDef(uint32_t node_id,
                           mojo::TransformPtr content_transform,
                           mojo::RectPtr content_clip,
                           Combinator combinator,
                           const std::vector<uint32_t>& child_node_ids,
                           uint32_t scene_resource_id,
                           uint32_t scene_version)
    : NodeDef(node_id,
              content_transform.Pass(),
              content_clip.Pass(),
              combinator,
              child_node_ids),
      scene_resource_id_(scene_resource_id),
      scene_version_(scene_version) {}

SceneNodeDef::~SceneNodeDef() {}

bool SceneNodeDef::RecordContent(SceneContentBuilder* builder) const {
  DCHECK(builder);

  return NodeDef::RecordContent(builder) &&
         builder->RequireResource(scene_resource_id_, ResourceDef::Type::kScene,
                                  node_id());
}

Snapshot::Disposition SceneNodeDef::RecordSnapshot(
    const SceneContent* content,
    SnapshotBuilder* builder) const {
  DCHECK(content);
  DCHECK(builder);

  auto scene_resource = static_cast<const SceneResourceDef*>(
      content->GetResource(scene_resource_id_, ResourceDef::Type::kScene));
  DCHECK(scene_resource);

  SceneDef* referenced_scene = scene_resource->referenced_scene().get();
  if (!referenced_scene) {
    if (builder->block_log()) {
      *builder->block_log()
          << "Scene node blocked because its referenced scene is unavailable: "
          << FormattedLabel(content) << std::endl;
    }
    return Snapshot::Disposition::kBlocked;
  }

  Snapshot::Disposition disposition =
      builder->SnapshotScene(referenced_scene, scene_version_, this, content);
  if (disposition != Snapshot::Disposition::kSuccess)
    return disposition;
  return NodeDef::RecordSnapshot(content, builder);
}

void SceneNodeDef::RecordPictureInner(const SceneContent* content,
                                      const Snapshot* snapshot,
                                      SkCanvas* canvas) const {
  DCHECK(content);
  DCHECK(snapshot);
  DCHECK(canvas);

  const SceneContent* resolved_content =
      snapshot->GetResolvedSceneContent(this);
  DCHECK(resolved_content);

  const NodeDef* root_node = resolved_content->GetRootNodeIfExists();
  DCHECK(root_node);  // must have a root otherwise would have been blocked
  root_node->RecordPicture(resolved_content, snapshot, canvas);

  NodeDef::RecordPictureInner(content, snapshot, canvas);
}

LayerNodeDef::LayerNodeDef(uint32_t node_id,
                           mojo::TransformPtr content_transform,
                           mojo::RectPtr content_clip,
                           Combinator combinator,
                           const std::vector<uint32_t>& child_node_ids,
                           const mojo::Size& size,
                           mojo::gfx::composition::BlendPtr blend)
    : NodeDef(node_id,
              content_transform.Pass(),
              content_clip.Pass(),
              combinator,
              child_node_ids),
      size_(size),
      blend_(blend.Pass()) {}

LayerNodeDef::~LayerNodeDef() {}

void LayerNodeDef::RecordPictureInner(const SceneContent* content,
                                      const Snapshot* snapshot,
                                      SkCanvas* canvas) const {
  DCHECK(content);
  DCHECK(snapshot);
  DCHECK(canvas);

  SkPaint paint;
  SetPaintForBlend(&paint, blend_.get());

  canvas->saveLayer(SkRect::MakeWH(size_.width, size_.height), &paint);
  NodeDef::RecordPictureInner(content, snapshot, canvas);
  canvas->restore();
}

}  // namespace compositor
