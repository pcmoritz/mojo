// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/resources.h"

#include "base/logging.h"

namespace compositor {

Resource::Resource() {}

Resource::~Resource() {}

SceneResource::SceneResource(
    const mojo::gfx::composition::SceneToken& scene_token,
    const base::WeakPtr<SceneDef>& referenced_scene)
    : scene_token_(scene_token), referenced_scene_(referenced_scene) {}

SceneResource::~SceneResource() {}

scoped_refptr<const SceneResource> SceneResource::Unlink() const {
  return new SceneResource(scene_token_, base::WeakPtr<SceneDef>());
}

Resource::Type SceneResource::type() const {
  return Type::kScene;
}

ImageResource::ImageResource(const scoped_refptr<RenderImage>& image)
    : image_(image) {
  DCHECK(image);
}

ImageResource::~ImageResource() {}

Resource::Type ImageResource::type() const {
  return Type::kImage;
}

}  // namespace compositor
