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
import 'package:_mojo_for_test_only/test/pingpong_service.mojom.dart'
    as pingpong_service;

// Tests that demonstrate that a service describer is able to obtain the same
// mojom type information present in a service's service description.
// If the descriptions match, it means that you can see what services are
// described by a mojo application without importing any of their mojom files.
tests(Application application, String url) {
  group('Service Describer Apptests', () {
    test('PingPong Service Verification', () async {
      var serviceDescriberProxy = new service_describer.ServiceDescriberProxy.
          unbound();
      serviceDescriberProxy.errorFuture.then((v) =>
          fail('There was an error $v'));
      application.connectToService("mojo:dart_pingpong", serviceDescriberProxy);

      var serviceDescriptionProxy =
          new service_describer.ServiceDescriptionProxy.unbound();
      serviceDescriptionProxy.errorFuture.then(
          (v) => fail('There was an error $v'));

      serviceDescriberProxy.ptr.describeService(
          "test::PingPongService", serviceDescriptionProxy);

      // Compare the service description obtained by the service describer and
      // the expected description taken from the pingpong service import.
      var serviceDescription = serviceDescriptionProxy.ptr;
      var serviceDescription2 = pingpong_service.PingPongServiceStub.
        serviceDescription;

      Function identity = (v) => v;


      // Top-level Mojom Interfaces must match.
      mojom_types.MojomInterface interfaceA =
          (await serviceDescriptionProxy.responseOrError(
              serviceDescription.getTopLevelInterface())).mojomInterface;

      mojom_types.MojomInterface interfaceB = serviceDescription2.
          getTopLevelInterface(identity);
      _compare(interfaceA, interfaceB);

      // Get the type key for the type of the first parameter of the
      // first method of the interface.
      mojom_types.MojomMethod setClientMethod = interfaceA.methods[0];
      mojom_types.StructField firstParam = setClientMethod.parameters.fields[0];
      String typeKey = firstParam.type.typeReference.typeKey;

      // Use getTypeDefinition() to get the type and check that it
      // is named "PingPongClient".
      mojom_types.MojomInterface pingPongClientInterface =
         (await serviceDescriptionProxy.responseOrError(
              serviceDescription.getTypeDefinition(typeKey))).type.
             interfaceType;
      expect(pingPongClientInterface.declData.shortName,
          equals("PingPongClient"));

      // Check that the mojom type definitions match between mappings.
      // For simplicity, check in a shallow manner.
      var actualDescriptions = (await serviceDescriptionProxy.responseOrError(
          serviceDescription.getAllTypeDefinitions())).definitions;
      var expectedDescriptions = serviceDescription2.
          getAllTypeDefinitions(identity);
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
