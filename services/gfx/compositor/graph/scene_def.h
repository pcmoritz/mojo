// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_GRAPH_SCENE_DEF_H_
#define SERVICES_GFX_COMPOSITOR_GRAPH_SCENE_DEF_H_

#include <iosfwd>
#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "base/memory/weak_ptr.h"
#include "mojo/services/gfx/composition/interfaces/scenes.mojom.h"
#include "services/gfx/compositor/graph/nodes.h"
#include "services/gfx/compositor/graph/resources.h"
#include "services/gfx/compositor/graph/scene_label.h"

namespace compositor {

class SceneContent;
class SceneDef;
class SnapshotBuilder;

// Resolves a scene token to a scene definition.
using SceneResolver = base::Callback<base::WeakPtr<SceneDef>(
    const mojo::gfx::composition::SceneToken&)>;

// Sends a scene unavailable message with the specified resource id.
using SceneUnavailableSender = base::Callback<void(uint32_t)>;

// Scene definition.
//
// Contains the client-supplied content that makes up a scene in an
// incrementally updatable form.  As part of preparing the scene for
// presentation, the content is gathered up into an immutable
// |SceneContent| object.
class SceneDef {
 public:
  // Outcome of a call to |Present|.
  enum class Disposition {
    kUnchanged,
    kSucceeded,
    kFailed,
  };

  SceneDef(const SceneLabel& label);
  ~SceneDef();

  base::WeakPtr<SceneDef> GetWeakPtr() { return weak_factory_.GetWeakPtr(); }

  // Gets the scene label.
  const SceneLabel& label() const { return label_; }
  std::string FormattedLabel() const {
    return label_.FormattedLabelForVersion(version_);
  }

  // Gets the currently published scene graph version.
  uint32_t version() const { return version_; }

  // Enqueues a pending update event to the scene graph.
  void EnqueueUpdate(mojo::gfx::composition::SceneUpdatePtr update);

  // Enqueues a pending publish event to the scene graph.
  // The changes are not applied until |ApplyChanges| is called.
  void EnqueuePublish(mojo::gfx::composition::SceneMetadataPtr metadata);

  // Applies published updates to the scene up to the point indicated by
  // |presentation_time|.
  //
  // Returns a value which indicates whether the updates succeded.
  // If the result is |kFailed|, the scene graph was left in an unusable
  // and inconsistent state and must be destroyed.
  Disposition Present(int64_t presentation_time,
                      const SceneResolver& resolver,
                      const SceneUnavailableSender& unavailable_sender,
                      std::ostream& err);

  // Unlinks references to another scene which has been unregistered.
  // Causes |OnResourceUnavailable()| to be delivered to the scene for all
  // invalidated scene resources.  Returns true if any changes were made.
  bool UnlinkReferencedScene(SceneDef* scene,
                             const SceneUnavailableSender& unavailable_sender);

  // Finds resources or nodes in the current version, returns nullptr if absent.
  const Resource* FindResource(uint32_t resource_id) const;
  const Node* FindNode(uint32_t node_id) const;
  const Node* FindRootNode() const {
    return FindNode(mojo::gfx::composition::kSceneRootNodeId);
  }

  // Finds the most recently presented content of the specified version,
  // returns nullptr if absent.
  // If the version is |kSceneVersionNone| returns the current version.
  const SceneContent* FindContent(uint32_t version) const;

 private:
  struct Publication {
    Publication(mojo::gfx::composition::SceneMetadataPtr metadata);
    ~Publication();

    bool is_due(int64_t presentation_time) const {
      return metadata->presentation_time <= presentation_time;
    }

    mojo::gfx::composition::SceneMetadataPtr metadata;
    std::vector<mojo::gfx::composition::SceneUpdatePtr> updates;

   private:
    DISALLOW_COPY_AND_ASSIGN(Publication);
  };

  bool ApplyUpdate(mojo::gfx::composition::SceneUpdatePtr update,
                   const SceneResolver& resolver,
                   const SceneUnavailableSender& unavailable_sender,
                   std::ostream& err);

  scoped_refptr<const Resource> CreateResource(
      uint32_t resource_id,
      mojo::gfx::composition::ResourcePtr resource_decl,
      const SceneResolver& resolver,
      const SceneUnavailableSender& unavailable_sender,
      std::ostream& err);
  scoped_refptr<const Node> CreateNode(
      uint32_t node_id,
      mojo::gfx::composition::NodePtr node_decl,
      std::ostream& err);

  const SceneLabel label_;

  std::vector<mojo::gfx::composition::SceneUpdatePtr> pending_updates_;
  std::vector<std::unique_ptr<Publication>> pending_publications_;

  uint32_t version_ = mojo::gfx::composition::kSceneVersionNone;
  std::unordered_map<uint32_t, scoped_refptr<const Resource>> resources_;
  std::unordered_map<uint32_t, scoped_refptr<const Node>> nodes_;

  scoped_refptr<const SceneContent> content_;

  base::WeakPtrFactory<SceneDef> weak_factory_;

  DISALLOW_COPY_AND_ASSIGN(SceneDef);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_GRAPH_SCENE_DEF_H_
