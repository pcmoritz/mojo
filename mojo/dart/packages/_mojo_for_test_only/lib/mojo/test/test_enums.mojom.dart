// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library test_enums_mojom;
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;


class TestEnum extends bindings.MojoEnum {
  static const TestEnum test = const TestEnum._(0);
  static const TestEnum v = const TestEnum._(1);
  static const TestEnum foo = const TestEnum._(2);
  static const TestEnum bar = const TestEnum._(3);

  const TestEnum._(int v) : super(v);

  static const Map<String, TestEnum> valuesMap = const {
    "test": test,
    "v": v,
    "foo": foo,
    "bar": bar,
  };
  static const List<TestEnum> values = const [
    test,
    v,
    foo,
    bar,
  ];

  static TestEnum valueOf(String name) => valuesMap[name];

  factory TestEnum(int v) {
    switch (v) {
      case 0:
        return TestEnum.test;
      case 1:
        return TestEnum.v;
      case 2:
        return TestEnum.foo;
      case 3:
        return TestEnum.bar;
      default:
        return null;
    }
  }

  static TestEnum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    TestEnum result = new TestEnum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum TestEnum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case test:
        return 'TestEnum.test';
      case v:
        return 'TestEnum.v';
      case foo:
        return 'TestEnum.foo';
      case bar:
        return 'TestEnum.bar';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class TestEnum2 extends bindings.MojoEnum {
  static const TestEnum2 test = const TestEnum2._(0);
  static const TestEnum2 v = const TestEnum2._(1);
  static const TestEnum2 foo = const TestEnum2._(2);
  static const TestEnum2 bar = const TestEnum2._(3);

  const TestEnum2._(int v) : super(v);

  static const Map<String, TestEnum2> valuesMap = const {
    "test": test,
    "v": v,
    "foo": foo,
    "bar": bar,
  };
  static const List<TestEnum2> values = const [
    test,
    v,
    foo,
    bar,
  ];

  static TestEnum2 valueOf(String name) => valuesMap[name];

  factory TestEnum2(int v) {
    switch (v) {
      case 0:
        return TestEnum2.test;
      case 1:
        return TestEnum2.v;
      case 2:
        return TestEnum2.foo;
      case 3:
        return TestEnum2.bar;
      default:
        return null;
    }
  }

  static TestEnum2 decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    TestEnum2 result = new TestEnum2(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum TestEnum2.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case test:
        return 'TestEnum2.test';
      case v:
        return 'TestEnum2.v';
      case foo:
        return 'TestEnum2.foo';
      case bar:
        return 'TestEnum2.bar';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



mojom_types.RuntimeTypeInfo getRuntimeTypeInfo() => _runtimeTypeInfo ??
    _initRuntimeTypeInfo();

Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  return getRuntimeTypeInfo().typeMap;
}

var _runtimeTypeInfo;
mojom_types.RuntimeTypeInfo  _initRuntimeTypeInfo() {
  // serializedRuntimeTypeInfo contains the bytes of the Mojo serialization of
  // a mojom_types.RuntimeTypeInfo struct describing the Mojom types in this
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+SVTU/yQBDHoYXnUUGD78bXJnrg1BJOxhOa1Jh4gGiD4UQEqtbYlrTwHfyoHvkGOrudJjLuAomlHpjk32mXYXf21+nsXiayEvoKejoe+yXiaVz/27gimPcUdACyWg2zfWu2Llz/1dcHdjjQLbiY3tDlcWegw8lxVRZXJuvQfN7z4vEP9LXMuMV5nqP/RLvJiK2ELOKk9uF+AyTZ1o88VBBL8QFUBxkvvmsbwbDnu45nBwabxwiDbnTTH3benK7heAM7eHrs2qHRcbye4z2HBlsrurZtWC3U2R9czicH0uL9ZXHfSuQbauTL+LtG8huR/f6WVxHzscx7iz2fgHaFvHQeQnnl8H3Pi1cJ30ls07hkE+KyjHM18ZnV/paYS1NUR/mUuGRn5KIkxKWA617X6/z5GLQj5sJDKJd/KXFRZuSiJszl6vJuGhceQrn8T4mLKunLoykcaoRDQ8JhHb+dsUMBz5hNIY+qMJ+VlPuwhh9SBQunJunDMku6D2vIRMCLN2LKqzDn+vmrvnsE2pZwaArqprggfVd+Tld546VcVhek707iwmIol7WU++5XAAAA//9rPPmt4AsAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
