// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This example demonstrates the simple use of SynchronousInterfacePtr<>, which
// is the blocking, synchronous version of mojom interface calls (typically used
// via InterfacePtr<>).

#include <memory>
#include <utility>

#include "examples/echo/echo.mojom-sync.h"
#include "examples/echo/echo.mojom.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/bindings/synchronous_interface_ptr.h"
#include "mojo/public/cpp/environment/logging.h"
#include "mojo/public/cpp/utility/run_loop.h"

namespace mojo {
namespace examples {

class EchoClientDelegate : public ApplicationDelegate {
 public:
  void Initialize(ApplicationImpl* app) override {
    EchoPtr echo;
    app->ConnectToService("mojo:echo_server", &echo);

    mojo::String out = "yo!";
    auto echo_proxy =
        SynchronousInterfacePtr<Echo>::Create(echo.PassInterfaceHandle());
    MOJO_CHECK(echo_proxy->EchoString("hello", &out));
    MOJO_LOG(INFO) << "Got response: " << out;
    RunLoop::current()->Quit();
  }
};

}  // namespace examples
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<mojo::examples::EchoClientDelegate>(
          new mojo::examples::EchoClientDelegate()));
  return runner.Run(application_request);
}
