// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_
#define SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_

#include <memory>
#include <mutex>
#include <queue>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "base/memory/scoped_ptr.h"
#include "base/task_runner.h"
#include "base/threading/thread.h"
#include "mojo/services/gpu/interfaces/context_provider.mojom.h"
#include "services/gfx/compositor/backend/output.h"
#include "services/gfx/compositor/backend/vsync_scheduler.h"

namespace compositor {

class GpuRasterizer;

// Renderer backed by a ContextProvider.
class GpuOutput : public Output {
 public:
  GpuOutput(mojo::InterfaceHandle<mojo::ContextProvider> context_provider,
            const SchedulerCallbacks& scheduler_callbacks,
            const base::Closure& error_callback);
  ~GpuOutput() override;

  Scheduler* GetScheduler() override;
  void SubmitFrame(const scoped_refptr<RenderFrame>& frame) override;

 private:
  // Wrapper around state which is made available to the rasterizer thread.
  class RasterizerDelegate {
   public:
    RasterizerDelegate();
    ~RasterizerDelegate();

    void PostInitialize(
        mojo::InterfaceHandle<mojo::ContextProvider> context_provider,
        const std::shared_ptr<VsyncScheduler>& scheduler,
        const scoped_refptr<base::TaskRunner>& task_runner,
        const base::Closure& error_callback);

    void PostDestroy(scoped_ptr<RasterizerDelegate> self);

    void PostFrame(const scoped_refptr<RenderFrame>& frame);

   private:
    void PostSubmit();

    // Called on rasterizer thread.
    void InitializeTask(
        mojo::InterfaceHandle<mojo::ContextProvider> context_provider,
        const std::shared_ptr<VsyncScheduler>& scheduler,
        const scoped_refptr<base::TaskRunner>& task_runner,
        const base::Closure& error_callback);

    // Called on rasterizer thread.
    void SubmitTask();

    // Called on rasterizer thread.
    void OnFrameSubmitted(int64_t frame_time,
                          int64_t presentation_time,
                          int64_t submit_time,
                          bool presented);

    std::unique_ptr<base::Thread> thread_;
    scoped_refptr<base::SingleThreadTaskRunner> task_runner_;
    std::unique_ptr<GpuRasterizer> rasterizer_;

    std::mutex mutex_;
    std::queue<scoped_refptr<RenderFrame>> frames_;  // guarded by |mutex_|

    DISALLOW_COPY_AND_ASSIGN(RasterizerDelegate);
  };

  std::shared_ptr<VsyncScheduler> scheduler_;
  scoped_ptr<RasterizerDelegate> rasterizer_delegate_;  // can't use unique_ptr
                                                        // here due to
                                                        // base::Bind (sadness)

  DISALLOW_COPY_AND_ASSIGN(GpuOutput);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_
