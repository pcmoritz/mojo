// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:_mojo_for_test_only/test/echo_service.mojom.dart';

/// DummyEchoServiceImpl is unused in the corresponding test_app.
class DummyEchoServiceImpl implements EchoService {
  dynamic echoString(String value, [Function responseFactory]) => null;

  dynamic delayedEchoString(String value, int millis,
      [Function responseFactory]) => null;

  void quit() {}
}

class EchoApplication extends Application {
  EchoApplication.fromHandle(MojoHandle handle) : super.fromHandle(handle);

  @override
  void acceptConnection(String requestorUrl, String resolvedUrl,
      ApplicationConnection connection) {
    connection.provideService(EchoService.serviceName,
      (endpoint) => new DummyEchoServiceImpl(),
      description: EchoServiceStub.serviceDescription);
  }
}

main(List args) {
  MojoHandle appHandle = new MojoHandle(args[0]);
  String url = args[1];
  new EchoApplication.fromHandle(appHandle)
    ..onError = ((_) {
      MojoHandle.reportLeakedHandles();
    });
}
