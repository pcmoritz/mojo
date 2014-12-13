// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_NATIVE_VIEWPORT_PLATFORM_VIEWPORT_ANDROID_H_
#define SERVICES_NATIVE_VIEWPORT_PLATFORM_VIEWPORT_ANDROID_H_

#include "base/android/jni_weak_ref.h"
#include "base/android/scoped_java_ref.h"
#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "services/native_viewport/platform_viewport.h"
#include "ui/events/event_constants.h"
#include "ui/gfx/rect.h"
#include "ui/gfx/sequential_id_generator.h"
#include "ui/gfx/size.h"

namespace gpu {
class GLInProcessContext;
}

struct ANativeWindow;

namespace native_viewport {

class PlatformViewportAndroid : public PlatformViewport {
 public:
  static bool Register(JNIEnv* env);

  explicit PlatformViewportAndroid(Delegate* delegate);
  virtual ~PlatformViewportAndroid();

  void Destroy(JNIEnv* env, jobject obj);
  void SurfaceCreated(JNIEnv* env, jobject obj, jobject jsurface);
  void SurfaceDestroyed(JNIEnv* env, jobject obj);
  void SurfaceSetSize(JNIEnv* env, jobject obj, jint width, jint height);
  bool TouchEvent(JNIEnv* env, jobject obj, jint pointer_id, jint action,
                  jfloat x, jfloat y, jlong time_ms);

 private:
  // Overridden from PlatformViewport:
  virtual void Init(const gfx::Rect& bounds) override;
  virtual void Show() override;
  virtual void Hide() override;
  virtual void Close() override;
  virtual gfx::Size GetSize() override;
  virtual void SetBounds(const gfx::Rect& bounds) override;
  virtual void SetCapture() override;
  virtual void ReleaseCapture() override;

  void ReleaseWindow();

  Delegate* delegate_;
  ANativeWindow* window_;
  gfx::Rect bounds_;
  ui::SequentialIDGenerator id_generator_;

  base::WeakPtrFactory<PlatformViewportAndroid> weak_factory_;

  DISALLOW_COPY_AND_ASSIGN(PlatformViewportAndroid);
};

}  // namespace native_viewport

#endif  // SERVICES_NATIVE_VIEWPORT_PLATFORM_VIEWPORT_ANDROID_H_
