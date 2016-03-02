// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_GRAPH_SNAPSHOT_H_
#define SERVICES_GFX_COMPOSITOR_GRAPH_SNAPSHOT_H_

#include <iosfwd>
#include <memory>
#include <unordered_map>
#include <unordered_set>

#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "mojo/services/geometry/interfaces/geometry.mojom.h"
#include "mojo/services/gfx/composition/interfaces/scheduling.mojom.h"

namespace compositor {

class NodeDef;
class SceneDef;
class SceneContent;
class SceneNodeDef;
class RenderFrame;

// Describes a single frame snapshot of the scene graph, sufficient for
// rendering and hit testing.  When the snapshot is made, all predicated and
// blocked scene nodes are evaluated to produce a final description of
// the frame along with its dependencies.
//
// The snapshot holds a list of dependencies for the scenes whose state was
// originally used to produce it.  The snapshot must be invalidated whenever
// any of these scenes change.  Note that the snapshot will contain a list
// of dependencies even in the case where a frame could not be produced,
// in which case the dependencies express the set of scenes which, if updated,
// might allow composition to be unblocked and make progress on a subsequent
// frame.
//
// Snapshot objects are not thread-safe since they have direct references to
// the scene graph definition.  However, the snapshot's frame is thread-safe
// and is intended to be sent to the backend rasterizer.
class Snapshot {
 public:
  // Describes the result of a snapshot operation.
  enum class Disposition {
    kSuccess,  // The snapshot was successful.
    kBlocked,  // The node was blocked from rendering.
    kCycle,    // The node was blocked due to a cycle, must unwind fully.
  };

  ~Snapshot();

  // Returns true if the snapshot is valid.
  bool valid() const { return valid_; }

  // Gets the frame produced from this snapshot, or null if none.
  //
  // This is always null if |valid()| is false but it may be null even
  // when |valid()| is true if composition was blocked and unable to produce
  // a frame during the snapshot operation.
  const std::shared_ptr<RenderFrame>& frame() const { return frame_; }

  // Unconditionally marks the snapshot as invalid.
  //
  // Returns true if the snapshot became invalid as a result of this operation,
  // or false if it was already invalid.
  bool Invalidate();

  // Invalidates the snapshot if it has a dependency on the specified scene.
  // When this occurs, the entire list of dependencies is flushed (we no longer
  // need them) in case the scene in question or its contents are about to
  // be destroyed.
  //
  // Returns true if the snapshot became invalid as a result of this operation,
  // or false if it was already invalid.
  bool InvalidateScene(const SceneDef* scene_def);

  // Returns true if the specified node was blocked from rendering.
  // Only meaningful while the snapshot is valid.
  bool IsBlocked(const NodeDef* node) const;

  // Gets the scene content which was resolved by following a scene node link.
  // Only meaningful while the snapshot is valid.
  const SceneContent* GetResolvedSceneContent(
      const SceneNodeDef* scene_node) const;

 private:
  friend class SnapshotBuilder;

  Snapshot();

  void ClearContent();

  // Just the set of dependent scene tokens.  Used for invalidation.
  std::unordered_set<uint32_t> dependencies_;

  // The root scene in the graph.
  // This reference together with |resolved_scenes| retains all of the
  // nodes used by the snapshot so that we can use bare pointers for nodes
  // and avoid excess reference counting overhead in other data structures.
  scoped_refptr<const SceneContent> root_scene_content_;

  // Map of scenes which were resolved from scene nodes.
  std::unordered_map<const SceneNodeDef*, scoped_refptr<const SceneContent>>
      resolved_scene_contents_;

  // Node states, true if snapshotted successfully, false if blocked.
  std::unordered_map<const NodeDef*, Disposition> node_dispositions_;

  // A frame ready to be rendered.
  std::shared_ptr<RenderFrame> frame_;

  // True if the snapshot is still valid.
  bool valid_ = true;

  DISALLOW_COPY_AND_ASSIGN(Snapshot);
};

// Builds a table of all of the state which will be required for rendering
// a scene graph.
class SnapshotBuilder {
 public:
  explicit SnapshotBuilder(std::ostream* block_log);
  ~SnapshotBuilder();

  // If not null, the snapshotter will append information to this stream
  // describing the parts of the scene graph for which composition was blocked.
  std::ostream* block_log() { return block_log_; }

  // Snapshots the requested node.
  Snapshot::Disposition SnapshotNode(const NodeDef* node,
                                     const SceneContent* content);

  // Snapshots the requested scene.
  Snapshot::Disposition SnapshotScene(const SceneDef* scene,
                                      uint32_t version,
                                      const SceneNodeDef* referrer_node,
                                      const SceneContent* referrer_content);

  // Builds a snapshot rooted at the specified scene.
  std::unique_ptr<Snapshot> Build(
      const SceneDef* root_scene,
      const mojo::Rect& viewport,
      const mojo::gfx::composition::FrameInfo& frame_info);

 private:
  // Snapshots the root scene of a renderer.
  // This is just like |SnapshotScene| but the errors are reported a little
  // differently since there is no referrer node.
  Snapshot::Disposition SnapshotRenderer(const SceneDef* scene);

  // Snapshots the root node of a scene and detects cycles.
  // This is just like |SnapshotNode| but performs cycle detection which
  // isn't otherwise needed.
  Snapshot::Disposition SnapshotRootAndDetectCycles(
      const NodeDef* node,
      const SceneContent* content);

  std::ostream* const block_log_;
  std::unique_ptr<Snapshot> snapshot_;
  const SceneContent* cycle_ = nullptr;  // point where a cycle was detected

  DISALLOW_COPY_AND_ASSIGN(SnapshotBuilder);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_GRAPH_SNAPSHOT_H_
