// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_GRAPH_RESOURCE_DEF_H_
#define SERVICES_GFX_COMPOSITOR_GRAPH_RESOURCE_DEF_H_

#include <memory>

#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "base/memory/weak_ptr.h"
#include "mojo/services/gfx/composition/interfaces/resources.mojom.h"
#include "services/gfx/compositor/render/render_image.h"

namespace compositor {

class SceneDef;

// Abstract scene graph resource definition.
//
// Instances of this class are immutable and reference counted so they may
// be shared by multiple versions of the same scene.
class ResourceDef : public base::RefCounted<ResourceDef> {
 public:
  enum class Type { kScene, kImage };

  ResourceDef();

  // Gets the resource type.
  virtual Type type() const = 0;

 protected:
  friend class base::RefCounted<ResourceDef>;
  virtual ~ResourceDef();

 private:
  DISALLOW_COPY_AND_ASSIGN(ResourceDef);
};

// Reference to another scene expressed as a resource definition.
class SceneResourceDef : public ResourceDef {
 public:
  explicit SceneResourceDef(
      const mojo::gfx::composition::SceneToken& scene_token,
      const base::WeakPtr<SceneDef>& referenced_scene);

  Type type() const override;

  const mojo::gfx::composition::SceneToken& scene_token() const {
    return scene_token_;
  }

  // The referenced scene, may be null if the scene is unavailable.
  const base::WeakPtr<SceneDef>& referenced_scene() const {
    return referenced_scene_;
  }

  // Returns a copy of the resource without its referenced scene.
  scoped_refptr<const SceneResourceDef> Unlink() const;

 protected:
  ~SceneResourceDef() override;

 private:
  mojo::gfx::composition::SceneToken scene_token_;
  base::WeakPtr<SceneDef> referenced_scene_;

  DISALLOW_COPY_AND_ASSIGN(SceneResourceDef);
};

// Reference to an image expressed as a resource definition.
class ImageResourceDef : public ResourceDef {
 public:
  explicit ImageResourceDef(const std::shared_ptr<RenderImage>& image);

  Type type() const override;

  // The referenced image, never null.
  const std::shared_ptr<RenderImage>& image() const { return image_; }

 protected:
  ~ImageResourceDef() override;

 private:
  std::shared_ptr<RenderImage> image_;

  DISALLOW_COPY_AND_ASSIGN(ImageResourceDef);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_GRAPH_RESOURCE_DEF_H_
