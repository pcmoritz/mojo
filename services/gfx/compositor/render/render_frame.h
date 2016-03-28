// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_
#define SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_

#include <memory>

#include "base/macros.h"
#include "mojo/services/gfx/composition/interfaces/scheduling.mojom.h"
#include "skia/ext/refptr.h"
#include "third_party/skia/include/core/SkPicture.h"
#include "third_party/skia/include/core/SkRect.h"

class SkCanvas;

namespace compositor {

// Describes a frame to be rendered.
//
// Render objects are thread-safe, immutable, and reference counted via
// std::shared_ptr.  They have no direct references to the scene graph.
class RenderFrame {
 public:
  RenderFrame(const SkIRect& viewport,
              const mojo::gfx::composition::FrameInfo& frame_info,
              const skia::RefPtr<SkPicture>& picture);
  ~RenderFrame();

  static std::shared_ptr<RenderFrame> CreateFromPicture(
      const SkIRect& viewport,
      const mojo::gfx::composition::FrameInfo& frame_info,
      const skia::RefPtr<SkPicture>& picture) {
    return std::make_shared<RenderFrame>(viewport, frame_info, picture);
  }

  static std::shared_ptr<RenderFrame> CreateEmpty(
      const SkIRect& viewport,
      const mojo::gfx::composition::FrameInfo& frame_info) {
    return std::make_shared<RenderFrame>(viewport, frame_info,
                                         skia::RefPtr<SkPicture>());
  }

  // Gets the frame's viewport in pixels.
  const SkIRect& viewport() const { return viewport_; }

  // Gets information about the frame to be rendered.
  const mojo::gfx::composition::FrameInfo& frame_info() const {
    return frame_info_;
  }

  // Gets the underlying picture to rasterize, or null if the frame is empty.
  const skia::RefPtr<SkPicture>& picture() const { return picture_; }

  // Paints the frame to a canvas.
  void Paint(SkCanvas* canvas) const;

 private:
  friend class RenderFrameBuilder;

  SkIRect viewport_;
  mojo::gfx::composition::FrameInfo frame_info_;
  skia::RefPtr<SkPicture> picture_;

  DISALLOW_COPY_AND_ASSIGN(RenderFrame);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_
