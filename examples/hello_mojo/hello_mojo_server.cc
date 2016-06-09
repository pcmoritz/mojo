// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <memory>
#include <string>
#include <utility>

#include "examples/hello_mojo/hello_mojo.mojom.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/bindings/interface_request.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/system/macros.h"

#include "mojo/public/cpp/system/buffer.h"
#include "mojo/public/cpp/system/macros.h"

#include <iostream>

using examples::HelloMojo;

namespace {

class HelloMojoImpl : public HelloMojo {
 public:
  explicit HelloMojoImpl(mojo::InterfaceRequest<HelloMojo> hello_mojo_request)
      : strong_binding_(this, std::move(hello_mojo_request)) {}
  ~HelloMojoImpl() override {}

  // |examples::HelloMojo| implementation:
  void Say(const mojo::String& request,
           const mojo::Callback<void(mojo::String)>& callback) override {
    callback.Run((request.get() == "hello") ? "mojo" : "WAT");
  }

  void Register(const mojo::String& request,
                const mojo::Callback<void(mojo::ScopedSharedBufferHandle)>& callback) override {
    std::cout << "registered " << request << std::endl;
    mojo::ScopedSharedBufferHandle handle;
    assert(MOJO_RESULT_OK == mojo::CreateSharedBuffer(nullptr, 1024, &handle));
    void* pointer = nullptr;
    assert(MOJO_RESULT_OK == mojo::MapBuffer(handle.get(), 0, sizeof(int), &pointer, MOJO_MAP_BUFFER_FLAG_NONE));
    int* int_pointer = reinterpret_cast<int*>(pointer);
    *int_pointer = 42;
    mojo::ScopedSharedBufferHandle handle_copy;
    mojo::DuplicateBuffer(handle.get(), nullptr, &handle_copy);
    memory_handles_.push_back(std::move(handle));
    callback.Run(std::move(handle_copy));
  }

 private:
  mojo::StrongBinding<HelloMojo> strong_binding_;
  std::vector<mojo::ScopedSharedBufferHandle> memory_handles_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(HelloMojoImpl);
};

class HelloMojoServerApp : public mojo::ApplicationDelegate,
                           public mojo::InterfaceFactory<HelloMojo> {
 public:
  HelloMojoServerApp() {}
  ~HelloMojoServerApp() override {}

  // |mojo::ApplicationDelegate| implementation:
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* application_connection) override {
    application_connection->AddService<HelloMojo>(this);
    return true;
  }

  // |mojo::InterfaceFactory<HelloMojo>| implementation:
  void Create(mojo::ApplicationConnection* application_connection,
              mojo::InterfaceRequest<HelloMojo> hello_mojo_request) override {
    new HelloMojoImpl(std::move(hello_mojo_request));  // Owns itself.
  }

 private:
  MOJO_DISALLOW_COPY_AND_ASSIGN(HelloMojoServerApp);
};

}  // namespace

MojoResult MojoMain(MojoHandle application_request) {
  return mojo::ApplicationRunner(std::unique_ptr<mojo::ApplicationDelegate>(
                                     new HelloMojoServerApp()))
      .Run(application_request);
}
