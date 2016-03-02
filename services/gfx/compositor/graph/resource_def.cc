// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/resource_def.h"

#include "base/logging.h"

namespace compositor {

ResourceDef::ResourceDef() {}

ResourceDef::~ResourceDef() {}

SceneResourceDef::SceneResourceDef(
    const mojo::gfx::composition::SceneToken& scene_token,
    const base::WeakPtr<SceneDef>& referenced_scene)
    : scene_token_(scene_token), referenced_scene_(referenced_scene) {}

SceneResourceDef::~SceneResourceDef() {}

scoped_refptr<const SceneResourceDef> SceneResourceDef::Unlink() const {
  return new SceneResourceDef(scene_token_, base::WeakPtr<SceneDef>());
}

ResourceDef::Type SceneResourceDef::type() const {
  return Type::kScene;
}

ImageResourceDef::ImageResourceDef(const std::shared_ptr<RenderImage>& image)
    : image_(image) {
  DCHECK(image);
}

ImageResourceDef::~ImageResourceDef() {}

ResourceDef::Type ImageResourceDef::type() const {
  return Type::kImage;
}

}  // namespace compositor
