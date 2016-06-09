#include "base/at_exit.h"
#include "base/command_line.h"
#include "mojo/edk/embedder/embedder.h"
#include "mojo/edk/embedder/simple_platform_support.h"
#include "mojo/public/cpp/environment/environment.h"
#include "base/message_loop/message_loop.h"
#include "base/run_loop.h"

#include <iostream>

// from hello_mojo_client

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

#include "mojo/edk/embedder/channel_info_forward.h"
#include "mojo/edk/util/waitable_event.h"
#include "mojo/edk/embedder/multiprocess_embedder.h"

#include "shell/task_runners.h"
#include "mojo/edk/embedder/process_delegate.h"
#include "mojo/edk/platform/platform_pipe.h"

#include "exchange_file_descriptor.h"

using examples::HelloMojoPtr;

namespace {

class HelloMojoClientApp : public mojo::ApplicationDelegate {
 public:
  HelloMojoClientApp() {}
  ~HelloMojoClientApp() override {}

  void Initialize(mojo::ApplicationImpl* application) override {
    mojo::ConnectToService(application->shell(), "mojo:hello_mojo_server",
                           GetProxy(&hello_mojo_));

    std::cout << "initializing" << std::endl;

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

class ScopedIPCSupport final : public mojo::embedder::ProcessDelegate {
 public:
  ScopedIPCSupport();
  ~ScopedIPCSupport() override;

 private:
  // |ProcessDelegate| implementation:
  // Note: Executed on the I/O thread.
  void OnShutdownComplete() override;

  MOJO_DISALLOW_COPY_AND_ASSIGN(ScopedIPCSupport);
};

ScopedIPCSupport::ScopedIPCSupport() {
}

ScopedIPCSupport::~ScopedIPCSupport() {
}

void ScopedIPCSupport::OnShutdownComplete() {
}


int main(int argc, char** argv) {
  base::AtExitManager exit_manager;
	base::CommandLine::Init(argc, argv);

	mojo::Environment env;
	mojo::embedder::Init(mojo::embedder::CreateSimplePlatformSupport());

  base::MessageLoop message_loop;

  // scoped_ptr<shell::TaskRunners> task_runners;
  // task_runners.reset(
  shell::TaskRunners* task_runners = new shell::TaskRunners(base::MessageLoop::current()->task_runner());

  mojo::embedder::InitIPCSupport(mojo::embedder::ProcessType::MASTER,
                                 task_runners->shell_runner().Clone(), new ScopedIPCSupport(),
                                 task_runners->io_runner().Clone(),
                                 task_runners->io_watcher(),
                                 mojo::platform::ScopedPlatformHandle());

  std::unique_ptr<mojo::platform::PlatformPipe> platform_pipe(new mojo::platform::PlatformPipe());

  mojo::platform::ScopedPlatformHandle server_platform_handle = platform_pipe->handle0.Pass();

  std::cout << "first handle is " << platform_pipe->handle1.Pass().get().fd << std::endl;

  std::string connection_id;
  mojo::util::ManualResetWaitableEvent event;
  mojo::embedder::ChannelInfo* channel_info = nullptr;

  mojo::ScopedMessagePipeHandle mp = mojo::embedder::ConnectToSlave(
    nullptr, server_platform_handle.Pass(),
    [&event]() { event.Signal(); }, nullptr, &connection_id, &channel_info);

  std::cout << "initialized with connection id " << connection_id << std::endl;

  FileDescriptorSender sender("/home/pcmoritz/server");
  sender.Send(platform_pipe->handle1.Pass().get().fd);

  std::cout << "sent fd" << std::endl;

	// mojo::ApplicationRunner(std::unique_ptr<mojo::ApplicationDelegate>(
  //                                   new HelloMojoClientApp()))
      // .Run(16);

	// base::MessageLoopForIO message_loop;
  // base::RunLoop run_loop;

	// run_loop.Run();

  // base::MessageLoop message_loop;

  // // message_loop.Run();

  mojo::ApplicationRunner(std::unique_ptr<mojo::ApplicationDelegate>(
                                     new HelloMojoServerApp()))
      .Run(mp.get().value());

  // mojo::ApplicationRunner(std::unique_ptr<mojo::ApplicationDelegate>(
  //                                  new HelloMojoClientApp()))
  // .Run(1);

  // https://chromiumcodereview.appspot.com/1832813002/diff/80001/content/browser/mojo_shell_browsertest.cc
  // https://chromium.googlesource.com/experimental/chromium/src/+/refs/wip/bajones/webvr/content/browser/mojo/mojo_app_connection_impl.cc

  return 0;
}
