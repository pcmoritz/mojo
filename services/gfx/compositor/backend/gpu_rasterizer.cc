// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/backend/gpu_rasterizer.h"

#ifndef GL_GLEXT_PROTOTYPES
#define GL_GLEXT_PROTOTYPES
#endif

#include <GLES2/gl2.h>
#include <GLES2/gl2extmojo.h>
#include <MGL/mgl.h>
#include <MGL/mgl_onscreen.h>
#include <MGL/mgl_signal_sync_point.h>

#include "base/bind.h"
#include "base/location.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "base/time/time.h"
#include "services/gfx/compositor/backend/vsync_scheduler.h"
#include "services/gfx/compositor/render/render_frame.h"

namespace compositor {
namespace {
constexpr int64_t kViewportParameterTimeoutMs = 1000;
constexpr int64_t kDefaultVsyncIntervalUs = 100000;  // deliberately sluggish
}

GpuRasterizer::GpuRasterizer(mojo::ContextProviderPtr context_provider,
                             const scoped_refptr<VsyncScheduler>& scheduler,
                             const scoped_refptr<base::TaskRunner>& task_runner,
                             const base::Closure& error_callback)
    : context_provider_(context_provider.Pass()),
      scheduler_(scheduler),
      task_runner_(task_runner),
      error_callback_(error_callback),
      viewport_parameter_listener_binding_(this),
      viewport_parameter_timeout_(false, false),
      weak_ptr_factory_(this) {
  DCHECK(context_provider_);
  DCHECK(scheduler_);
  DCHECK(task_runner_);

  context_provider_.set_connection_error_handler(
      base::Bind(&GpuRasterizer::OnContextProviderConnectionError,
                 base::Unretained(this)));
  CreateContext();
}

GpuRasterizer::~GpuRasterizer() {
  DestroyContext();
}

void GpuRasterizer::CreateContext() {
  DCHECK(!gl_context_);

  have_viewport_parameters_ = false;

  mojo::ViewportParameterListenerPtr viewport_parameter_listener;
  viewport_parameter_listener_binding_.Bind(
      GetProxy(&viewport_parameter_listener));
  context_provider_->Create(
      viewport_parameter_listener.Pass(),
      base::Bind(&GpuRasterizer::InitContext, base::Unretained(this)));
}

void GpuRasterizer::InitContext(
    mojo::InterfaceHandle<mojo::CommandBuffer> command_buffer) {
  DCHECK(!gl_context_);
  DCHECK(!ganesh_context_);
  DCHECK(!ganesh_surface_);

  if (!command_buffer) {
    LOG(ERROR) << "Could not create GL context.";
    PostErrorCallback();
    return;
  }

  gl_context_ = mojo::GLContext::CreateFromCommandBuffer(
      mojo::CommandBufferPtr::Create(std::move(command_buffer)));
  gl_context_->AddObserver(this);
  ganesh_context_ = new mojo::skia::GaneshContext(gl_context_);

  if (have_viewport_parameters_) {
    ApplyViewportParameters();
  } else {
    viewport_parameter_timeout_.Start(
        FROM_HERE,
        base::TimeDelta::FromMilliseconds(kViewportParameterTimeoutMs),
        base::Bind(&GpuRasterizer::OnViewportParameterTimeout,
                   base::Unretained(this)));
  }

  if (frame_)
    Draw();
}

void GpuRasterizer::AbandonContext() {
  if (gl_context_)
    scheduler_->Stop();

  if (viewport_parameter_listener_binding_.is_bound()) {
    viewport_parameter_timeout_.Stop();
    viewport_parameter_listener_binding_.Close();
  }
}

void GpuRasterizer::DestroyContext() {
  AbandonContext();

  if (gl_context_) {
    ganesh_context_ = nullptr;
    gl_context_ = nullptr;

    // Do this after releasing the GL context so that we will already have
    // told the Ganesh context to abandon its context.
    ganesh_surface_.reset();
  }
}

void GpuRasterizer::OnContextProviderConnectionError() {
  LOG(ERROR) << "Context provider connection lost.";
  PostErrorCallback();
}

void GpuRasterizer::OnContextLost() {
  LOG(WARNING) << "GL context lost!";

  AbandonContext();

  base::MessageLoop::current()->PostTask(
      FROM_HERE, base::Bind(&GpuRasterizer::RecreateContextAfterLoss,
                            weak_ptr_factory_.GetWeakPtr()));
}

void GpuRasterizer::RecreateContextAfterLoss() {
  LOG(WARNING) << "Recreating GL context.";

  DestroyContext();
  CreateContext();
}

void GpuRasterizer::OnViewportParameterTimeout() {
  DCHECK(!have_viewport_parameters_);

  LOG(WARNING) << "Viewport parameter listener timeout after "
               << kViewportParameterTimeoutMs << " ms: assuming "
               << kDefaultVsyncIntervalUs
               << " us vsync interval, rendering will be janky!";

  OnVSyncParametersUpdated(0, kDefaultVsyncIntervalUs);
}

void GpuRasterizer::OnVSyncParametersUpdated(int64_t timebase,
                                             int64_t interval) {
  DVLOG(1) << "Vsync parameters: timebase=" << timebase
           << ", interval=" << interval;

  if (!have_viewport_parameters_) {
    viewport_parameter_timeout_.Stop();
    have_viewport_parameters_ = true;
  }
  vsync_timebase_ = timebase;
  vsync_interval_ = interval;

  if (gl_context_ && !gl_context_->is_lost())
    ApplyViewportParameters();
}

void GpuRasterizer::ApplyViewportParameters() {
  DCHECK(have_viewport_parameters_);
  DCHECK(gl_context_);

  // TODO(jeffbrown): This shouldn't be hardcoded.
  // Need to do some real tuning and possibly determine values adaptively.
  int64_t update_phase = -vsync_interval_;
  int64_t snapshot_phase = -vsync_interval_ / 6;
  int64_t presentation_phase = vsync_interval_;
  if (!scheduler_->Start(vsync_timebase_, vsync_interval_, update_phase,
                         snapshot_phase, presentation_phase)) {
    LOG(ERROR) << "Received invalid vsync parameters: timebase="
               << vsync_timebase_ << ", interval=" << vsync_interval_;
    PostErrorCallback();
  }
}

void GpuRasterizer::SubmitFrame(const scoped_refptr<RenderFrame>& frame,
                                const FrameCallback& frame_callback) {
  DCHECK(frame);

  if (frame_ && !frame_callback_.is_null())
    frame_callback_.Run(false);  // frame discarded

  frame_ = frame;
  frame_callback_ = frame_callback;

  if (gl_context_ && !gl_context_->is_lost())
    Draw();
}

void GpuRasterizer::Draw() {
  DCHECK(gl_context_);
  DCHECK(ganesh_context_);
  DCHECK(frame_);

  mojo::GLContext::Scope gl_scope(gl_context_);

  // Update the viewport.
  const SkIRect& viewport = frame_->viewport();
  bool stale_surface = false;
  if (!ganesh_surface_ ||
      ganesh_surface_->surface()->width() != viewport.width() ||
      ganesh_surface_->surface()->height() != viewport.height()) {
    glResizeCHROMIUM(viewport.width(), viewport.height(), 1.0f);
    glViewport(viewport.x(), viewport.y(), viewport.width(), viewport.height());
    stale_surface = true;
  }

  // Paint the frame.
  {
    mojo::skia::GaneshContext::Scope ganesh_scope(ganesh_context_);

    if (stale_surface) {
      ganesh_surface_.reset(
          new mojo::skia::GaneshFramebufferSurface(ganesh_scope));
    }

    frame_->Paint(ganesh_surface_->canvas());
  }

  // Swap buffers and listen for completion.
  // TODO: Investigate using |MGLSignalSyncPoint| to wait for completion.
  MGLSwapBuffers();

  // Signal pending callback for backpressure.
  if (!frame_callback_.is_null()) {
    frame_callback_.Run(true);
    frame_callback_.Reset();
  }
}

void GpuRasterizer::PostErrorCallback() {
  task_runner_->PostTask(FROM_HERE, error_callback_);
}

}  // namespace compositor
