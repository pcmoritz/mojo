// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/common/tracing_impl.h"

#include "base/trace_event/trace_event_impl.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/interface_handle.h"
#include "mojo/public/cpp/bindings/interface_request.h"
#include "mojo/public/interfaces/application/service_provider.mojom.h"

namespace mojo {

TracingImpl::TracingImpl() {}

TracingImpl::~TracingImpl() {}

void TracingImpl::Initialize(ApplicationImpl* app) {
  InterfaceHandle<ServiceProvider> outgoing_sp_handle;
  InterfaceRequest<ServiceProvider> outgoing_sp_request =
      GetProxy(&outgoing_sp_handle);
  app->shell()->ConnectToApplication("mojo:tracing", nullptr,
                                     outgoing_sp_handle.Pass());
  outgoing_sp_for_tracing_service_.Bind(outgoing_sp_request.Pass());
  outgoing_sp_for_tracing_service_.AddService(this);

#ifdef NDEBUG
  if (app->HasArg("--early-tracing")) {
    provider_impl_.ForceEnableTracing();
  }
#else
  provider_impl_.ForceEnableTracing();
#endif
}

void TracingImpl::Create(ApplicationConnection* connection,
                         InterfaceRequest<tracing::TraceProvider> request) {
  provider_impl_.Bind(request.Pass());
}

}  // namespace mojo
