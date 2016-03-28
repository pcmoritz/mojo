// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/backend/gpu_output.h"

#include <utility>

#include "base/bind.h"
#include "base/location.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "services/gfx/compositor/backend/gpu_rasterizer.h"
#include "services/gfx/compositor/render/render_frame.h"

namespace compositor {
namespace {
// Maximum number of frames to hold in the queue for rendering.
constexpr size_t kMaxPipelineDepth = 1;
}

template <typename T>
static void Drop(scoped_ptr<T> ptr) {}

static scoped_ptr<base::MessagePump> CreateMessagePumpMojo() {
  return base::MessageLoop::CreateMessagePumpForType(
      base::MessageLoop::TYPE_DEFAULT);
}

GpuOutput::GpuOutput(
    mojo::InterfaceHandle<mojo::ContextProvider> context_provider,
    const SchedulerCallbacks& scheduler_callbacks,
    const base::Closure& error_callback)
    : scheduler_(new VsyncScheduler(base::MessageLoop::current()->task_runner(),
                                    scheduler_callbacks)),
      rasterizer_delegate_(make_scoped_ptr(new RasterizerDelegate())) {
  DCHECK(context_provider);

  rasterizer_delegate_->PostInitialize(
      std::move(context_provider), scheduler_,
      base::MessageLoop::current()->task_runner(), error_callback);
}

GpuOutput::~GpuOutput() {
  // Ensure destruction happens on the correct thread.
  rasterizer_delegate_->PostDestroy(rasterizer_delegate_.Pass());
}

Scheduler* GpuOutput::GetScheduler() {
  return scheduler_.get();
}

void GpuOutput::SubmitFrame(const scoped_refptr<RenderFrame>& frame) {
  rasterizer_delegate_->PostFrame(frame);
}

GpuOutput::RasterizerDelegate::RasterizerDelegate() {
  base::Thread::Options options;
  options.message_pump_factory = base::Bind(&CreateMessagePumpMojo);

  thread_.reset(new base::Thread("gpu_rasterizer"));
  thread_->StartWithOptions(options);
  task_runner_ = thread_->message_loop()->task_runner();
}

GpuOutput::RasterizerDelegate::~RasterizerDelegate() {}

void GpuOutput::RasterizerDelegate::PostInitialize(
    mojo::InterfaceHandle<mojo::ContextProvider> context_provider,
    const scoped_refptr<VsyncScheduler>& scheduler,
    const scoped_refptr<base::TaskRunner>& task_runner,
    const base::Closure& error_callback) {
  task_runner_->PostTask(
      FROM_HERE,
      base::Bind(&RasterizerDelegate::InitializeTask, base::Unretained(this),
                 base::Passed(std::move(context_provider)), scheduler,
                 base::MessageLoop::current()->task_runner(), error_callback));
}

void GpuOutput::RasterizerDelegate::PostDestroy(
    scoped_ptr<RasterizerDelegate> self) {
  task_runner_->PostTask(
      FROM_HERE, base::Bind(&Drop<RasterizerDelegate>, base::Passed(&self)));
}

void GpuOutput::RasterizerDelegate::PostFrame(
    const scoped_refptr<RenderFrame>& frame) {
  bool was_empty;
  scoped_refptr<RenderFrame> dropped_frame;
  {
    std::lock_guard<std::mutex> lock(mutex_);
    was_empty = frames_.empty();
    if (frames_.size() == kMaxPipelineDepth) {
      // TODO(jeffbrown): Adjust scheduler behavior to compensate.
      DVLOG(3) << "Renderer pipeline stalled, dropping a frame to catch up.";
      dropped_frame = frames_.front();  // drop an old frame outside the lock
      frames_.pop();
    }
    frames_.push(frame);
  }

  if (was_empty)
    PostSubmit();
}

void GpuOutput::RasterizerDelegate::PostSubmit() {
  task_runner_->PostTask(FROM_HERE, base::Bind(&RasterizerDelegate::SubmitTask,
                                               base::Unretained(this)));
}

void GpuOutput::RasterizerDelegate::InitializeTask(
    mojo::InterfaceHandle<mojo::ContextProvider> context_provider,
    const scoped_refptr<VsyncScheduler>& scheduler,
    const scoped_refptr<base::TaskRunner>& task_runner,
    const base::Closure& error_callback) {
  rasterizer_.reset(new GpuRasterizer(
      mojo::ContextProviderPtr::Create(std::move(context_provider)), scheduler,
      task_runner, error_callback));
}

void GpuOutput::RasterizerDelegate::SubmitTask() {
  bool have_more;
  scoped_refptr<RenderFrame> frame;
  {
    std::lock_guard<std::mutex> lock(mutex_);
    DCHECK(!frames_.empty());
    frame = frames_.front();
    frames_.pop();
    have_more = !frames_.empty();
  }

  if (have_more)
    PostSubmit();

  int64_t submit_time = MojoGetTimeTicksNow();
  rasterizer_->SubmitFrame(
      frame, base::Bind(&RasterizerDelegate::OnFrameSubmitted,
                        base::Unretained(this), frame->frame_info().frame_time,
                        frame->frame_info().presentation_time, submit_time));
}

void GpuOutput::RasterizerDelegate::OnFrameSubmitted(int64_t frame_time,
                                                     int64_t presentation_time,
                                                     int64_t submit_time,
                                                     bool presented) {
  // TODO(jeffbrown): Adjust scheduler behavior based on observed timing.
  // Note: These measurements don't account for systematic downstream delay
  // in the display pipeline (how long it takes pixels to actually light up).
  int64_t complete_time = MojoGetTimeTicksNow();
  if (presented) {
    DVLOG(3) << "Frame presented: submission latency "
             << (submit_time - frame_time) << " us, rasterization latency "
             << (complete_time - submit_time) << " us, total latency "
             << (complete_time - frame_time) << " us, presentation time error "
             << (complete_time - presentation_time);
  } else {
    DVLOG(3) << "Frame deferred.";
  }
}

}  // namespace compositor
