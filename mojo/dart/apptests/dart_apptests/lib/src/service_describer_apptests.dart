// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library service_describer_apptests;

import 'dart:async';

import 'package:mojo_apptest/apptest.dart';
import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart'
    as service_describer;
import 'package:_mojo_for_test_only/test/echo_service.mojom.dart'
    as echo_service;

// Tests that demonstrate that a service describer is able to obtain the same
// mojom type information present in a service's service description.
// If the descriptions match, it means that you can see what services are
// described by a mojo application without importing any of their mojom files.
tests(Application application, String url) {
  group('Service Describer Apptests', () {
    test('Echo Service Verification', () async {
      var serviceDescriberProxy =
          new service_describer.ServiceDescriberProxy.connectToService(
              application, "mojo:dart_echo_with_service_describer");

      var serviceDescriptionProxy =
          new service_describer.ServiceDescriptionProxy.unbound();
      await serviceDescriberProxy.ptr
          .describeService("test::EchoService", serviceDescriptionProxy);

      expect(serviceDescriptionProxy.impl, isNotNull);
      expect(serviceDescriptionProxy.ptr, isNotNull);

      // Compare the service description obtained by the service describer and
      // the expected description taken from the echo service import.
      var sd = serviceDescriptionProxy.ptr;
      var ed = echo_service.EchoServiceStub.serviceDescription;

      Function identity = (v) => v;

      // Top-level Mojom Interfaces must match.
      mojom_types.MojomInterface a =
          (await sd.getTopLevelInterface()).mojomInterface;
      mojom_types.MojomInterface b = ed.getTopLevelInterface(identity);
      _compare(a, b);

      String interfaceID = "echo_service_EchoService__";
      mojom_types.MojomInterface c =
          (await sd.getTypeDefinition(interfaceID)).type.interfaceType;
      mojom_types.MojomInterface d =
          ed.getTypeDefinition(interfaceID, identity).interfaceType;
      _compare(a, c);
      _compare(c, d);

      // Check that the mojom type definitions match between mappings.
      // For simplicity, check in a shallow manner.
      var actualDescriptions = (await sd.getAllTypeDefinitions()).definitions;
      var expectedDescriptions = ed.getAllTypeDefinitions(identity);
      actualDescriptions.keys.forEach((String key) {
        var a = actualDescriptions[key];
        var e = expectedDescriptions[key];
        expect(e, isNotNull);
        expect(a.runtimeType, equals(e.runtimeType));
      });

      await serviceDescriptionProxy.close();
      await serviceDescriberProxy.close();
    });
  });
}

// Helper to compare two mojom interfaces for matches.
void _compare(mojom_types.MojomInterface a, mojom_types.MojomInterface b) {
  // Match the generated decl data.
  expect(a.declData, isNotNull);
  expect(b.declData, isNotNull);
  expect(a.declData.shortName, equals(b.declData.shortName));
  expect(a.declData.fullIdentifier, equals(b.declData.fullIdentifier));

  // Verify that the number of methods matches the expected ones.
  expect(a.methods.length, equals(b.methods.length));

  // Each MojomMethod must be named, typed, and "ordinal"ed the same way.
  a.methods.forEach((int ordinal, mojom_types.MojomMethod methodA) {
    mojom_types.MojomMethod methodB = b.methods[ordinal];
    expect(methodB, isNotNull);

    // Compare declData.
    expect(methodA.declData, isNotNull);
    expect(methodB.declData, isNotNull);
    expect(methodA.declData.shortName, equals(methodB.declData.shortName));

    // Lastly, compare parameters and responses (generally).
    expect(methodA.parameters.fields.length,
        equals(methodB.parameters.fields.length));
    mojom_types.MojomStruct responseA = methodA.responseParams;
    mojom_types.MojomStruct responseB = methodB.responseParams;
    expect(responseA == null, equals(responseB == null));
    if (responseA != null) {
      expect(responseA.fields.length, equals(responseB.fields.length));
    }
  });
}
