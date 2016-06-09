// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>

#include <memory>
#include <string>

#include "examples/hello_mojo/hello_mojo.mojom.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/public/cpp/utility/run_loop.h"

using examples::HelloMojoPtr;

namespace {

class HelloMojoClientApp : public mojo::ApplicationDelegate {
 public:
  HelloMojoClientApp() {}
  ~HelloMojoClientApp() override {}

  void Initialize(mojo::ApplicationImpl* application) override {
    mojo::ConnectToService(application->shell(), "mojo:hello_mojo_server",
                           GetProxy(&hello_mojo_));

    DoIt("hello");

    GetHandle("test");

    DoIt("goodbye");
  }

 private:
  void DoIt(const std::string& request) {
    hello_mojo_->Say(request, [request](const mojo::String& response) {
      printf("%s --> %s\n", request.c_str(), response.get().c_str());
    });
  }

  void GetHandle(const std::string& request) {
    hello_mojo_->Register(request, [request](const mojo::ScopedSharedBufferHandle& response) {
      void* pointer = nullptr;
      assert(MOJO_RESULT_OK == mojo::MapBuffer(response.get(), 0, sizeof(int), &pointer, MOJO_MAP_BUFFER_FLAG_NONE));
      int* int_pointer = reinterpret_cast<int*>(pointer);
      printf("got handle %d, value is %d\n", response.get().value(), *int_pointer);
    });
  }

  HelloMojoPtr hello_mojo_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(HelloMojoClientApp);
};

}  // namespace

MojoResult MojoMain(MojoHandle application_request) {
  printf("mojo handle is %d\n", application_request);
  //return mojo::ApplicationRunner(std::unique_ptr<mojo::ApplicationDelegate>(
  //                                   new HelloMojoClientApp()))
  //    .Run(application_request);
  // while (true) {

  // }
  return 0;
}
