#include "base/at_exit.h"
#include "base/command_line.h"
#include "mojo/edk/embedder/embedder.h"
#include "mojo/edk/embedder/simple_platform_support.h"
#include "mojo/public/cpp/environment/environment.h"
#include "base/message_loop/message_loop.h"
#include "base/run_loop.h"

#include "base/bind.h"

#include "mojo/message_pump/message_pump_mojo.h"

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

#include "mojo/edk/base_edk/platform_task_runner_impl.h"
#include "base/thread_task_runner_handle.h"

#include "mojo/edk/platform/scoped_platform_handle.h"
#include "mojo/edk/platform/platform_handle_watcher.h"

#include "mojo/edk/base_edk/platform_handle_watcher_impl.h"

#include "base/posix/global_descriptors.h"
#include "mojo/edk/util/make_unique.h"

#include "exchange_file_descriptor.h"

using mojo::platform::PlatformHandle;
using mojo::platform::PlatformHandleWatcher;
using mojo::platform::ScopedPlatformHandle;
using mojo::platform::TaskRunner;
using mojo::util::MakeRefCounted;
using mojo::util::MakeUnique;
using mojo::util::RefPtr;

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

}


int main(int argc, char** argv) {
  base::AtExitManager exit_manager;
	base::CommandLine::Init(argc, argv);

  std::string child_connection_id = base::CommandLine::ForCurrentProcess()->GetSwitchValueASCII("child_connection_id");

	mojo::Environment env;
	mojo::embedder::Init(mojo::embedder::CreateSimplePlatformSupport());

  base::MessageLoop message_loop;

  // scoped_ptr<shell::TaskRunners> task_runners;
  // task_runners.reset(
  // shell::TaskRunners* task_runners = new shell::TaskRunners(base::MessageLoop::current()->task_runner());

  FileDescriptorReceiver receiver("/home/pcmoritz/server");
  int fd = receiver.Receive();

  mojo::platform::ScopedPlatformHandle platform_handle((mojo::platform::PlatformHandle(fd)));

  /*
  mojo::embedder::InitIPCSupport(mojo::embedder::ProcessType::SLAVE,
                                 task_runners->shell_runner().Clone(), new ScopedIPCSupport(),
                                 task_runners->io_runner().Clone(),
                                 task_runners->io_watcher(),
                                 platform_handle.Pass());
  */


  // from child_main.cc:

  base::Thread io_thread("io_thread");

  // Create and start our I/O thread.
  base::Thread::Options io_thread_options(base::MessageLoop::TYPE_IO, 0);
  CHECK(io_thread.StartWithOptions(io_thread_options));
  RefPtr<TaskRunner> io_runner = MakeRefCounted<base_edk::PlatformTaskRunnerImpl>(
      io_thread.task_runner());
  CHECK(io_runner);
  std::unique_ptr<PlatformHandleWatcher> io_watcher = MakeUnique<base_edk::PlatformHandleWatcherImpl>(
      static_cast<base::MessageLoopForIO*>(io_thread.message_loop()));

  // Create and start our controller thread.
  base::Thread::Options controller_thread_options;
  controller_thread_options.message_loop_type =
      base::MessageLoop::TYPE_CUSTOM;
  controller_thread_options.message_pump_factory =
      base::Bind(&mojo::common::MessagePumpMojo::Create);

  base::Thread controller_thread("controller_thread");
  CHECK(controller_thread.StartWithOptions(controller_thread_options));
  RefPtr<TaskRunner> controller_runner = MakeRefCounted<base_edk::PlatformTaskRunnerImpl>(
        controller_thread.task_runner());
  CHECK(controller_runner);

  mojo::embedder::InitIPCSupport(mojo::embedder::ProcessType::SLAVE,
                             controller_runner.Clone(), new ScopedIPCSupport(),
                             io_runner.Clone(),
                             io_watcher.get(),
                             platform_handle.Pass());

  mojo::util::RefPtr<mojo::platform::TaskRunner> mojo_task_runner(mojo::util::MakeRefCounted<base_edk::PlatformTaskRunnerImpl>(
        base::ThreadTaskRunnerHandle::Get()));


  mojo::embedder::ChannelInfo* channel_info;

  mojo::ScopedMessagePipeHandle host_message_pipe(
    mojo::embedder::ConnectToMaster(child_connection_id, []() {}, mojo_task_runner.Clone(), &channel_info));

  mojo::ApplicationRunner(std::unique_ptr<mojo::ApplicationDelegate>(
                                    new HelloMojoClientApp()))
  .Run(host_message_pipe.get().value());
}
