// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library test_enums_mojom;
import 'dart:collection';
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

mojom_types.MojomEnum _testEnumsTestEnum() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'TestEnum'
      ..fullIdentifier = 'mojo.test.TestEnum')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Test')
        ..enumTypeKey = 'test_enums_TestEnum__'
        ..intValue = 0,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'V')
        ..enumTypeKey = 'test_enums_TestEnum__'
        ..intValue = 1,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Foo')
        ..enumTypeKey = 'test_enums_TestEnum__'
        ..intValue = 2,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Bar')
        ..enumTypeKey = 'test_enums_TestEnum__'
        ..intValue = 3,];
}




Map<String, mojom_types.UserDefinedType> _initDescriptions() {
  var map = new HashMap<String, mojom_types.UserDefinedType>();
  map["test_enums_TestEnum__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _testEnumsTestEnum();
  return map;
}

var _mojomDesc;
Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  if (_mojomDesc == null) {
    _mojomDesc = _initDescriptions();
  }
  return _mojomDesc;
}

