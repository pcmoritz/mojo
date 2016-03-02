// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_
#define SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_

#include <memory>

#include "base/macros.h"
#include "mojo/services/gfx/composition/interfaces/scheduling.mojom.h"
#include "skia/ext/refptr.h"
#include "third_party/skia/include/core/SkRect.h"

class SkCanvas;
class SkPicture;

namespace compositor {

// Describes a frame to be rendered.
//
// Render objects are thread-safe, immutable, and reference counted via
// std::shared_ptr.  They have no direct references to the scene graph.
class RenderFrame {
 public:
  RenderFrame(const skia::RefPtr<SkPicture>& picture,
              const SkRect& viewport,
              const mojo::gfx::composition::FrameInfo& frame_info);
  ~RenderFrame();

  static std::shared_ptr<RenderFrame> Create(
      const skia::RefPtr<SkPicture>& picture,
      const SkRect& viewport,
      const mojo::gfx::composition::FrameInfo& frame_info) {
    return std::make_shared<RenderFrame>(picture, viewport, frame_info);
  }

  // Gets the underlying picture to rasterize.
  const skia::RefPtr<SkPicture>& picture() const { return picture_; }

  // Gets the frame's viewport.
  const SkRect& viewport() const { return viewport_; }

  // Gets information about the frame to be rendered.
  const mojo::gfx::composition::FrameInfo& frame_info() const {
    return frame_info_;
  }

  // Paints the frame to a canvas.
  void Paint(SkCanvas* canvas) const;

 private:
  friend class RenderFrameBuilder;

  skia::RefPtr<SkPicture> picture_;
  SkRect viewport_;
  mojo::gfx::composition::FrameInfo frame_info_;

  DISALLOW_COPY_AND_ASSIGN(RenderFrame);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_
