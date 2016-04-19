// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_GANESH_VIEW_H_
#define MOJO_UI_GANESH_VIEW_H_

#include "mojo/gpu/gl_context.h"
#include "mojo/skia/ganesh_context.h"
#include "mojo/ui/base_view.h"
#include "mojo/ui/ganesh_renderer.h"

class SkSurface;

namespace mojo {
namespace ui {

// Abstract base implementation of the View interface for simple applications
// which use Ganesh for rendering.  Subclasses must handle layout and provide
// content for the scene.
class GaneshView : public BaseView {
 public:
  GaneshView(mojo::ApplicationImpl* app_impl,
             mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
             const std::string& label);

  ~GaneshView() override;

  // Gets the GL context, never null.
  const scoped_refptr<mojo::GLContext>& gl_context() const {
    return ganesh_renderer_.gl_context();
  }

  // Gets the Ganesh context, never null.
  const scoped_refptr<mojo::skia::GaneshContext>& ganesh_context() const {
    return ganesh_renderer_.ganesh_context();
  }

  // Gets the Ganesh renderer, never null.
  mojo::ui::GaneshRenderer* ganesh_renderer() { return &ganesh_renderer_; }

 private:
  mojo::ui::GaneshRenderer ganesh_renderer_;

  DISALLOW_COPY_AND_ASSIGN(GaneshView);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_GANESH_VIEW_H_
