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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/5JggAABKG0ApdHFYTQHGo2uzgGJz4ikThmIpYE4JDLANd7bNdIqNz8rX68ktbhELwRIuOaV5sLNY8RiH7o9H6C0BwMm+A8EMH9YIInhUg8zF2QXzDFSQLYQEONwJoZ7mIGYFYjDgdgfiPUz8nNT9YtKU/JzM/NSi/RB5ugXFyVDGAWlSTmZyfqZeSWpRWmJyanF+kmZeSmZeenF+iC7IGR8KtC2Yj2QhlwGDaCZLECsALUvgxFCb2CC0D+YUeNPAxZ+jKjuVGBE9Te1wo8H6r4Q1+AQEF8eiMWxhp8eWAl6+IH0MtEw/IhNfwLQuGRgIC08GakcnpxQM8OgfBkgFsEenmHY0iPrIAtPRhLDk4nK4ckNdYebvz+YLwfEYtjDE6wEPTzZBll4MpEYnsw0Ck8nxyBC4QlWgh6e7IMsPGHhAwgAAP//ez9ctxAHAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
