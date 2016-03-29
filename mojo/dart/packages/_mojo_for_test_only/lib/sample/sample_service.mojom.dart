// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_service_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:_mojo_for_test_only/imported/sample_import.mojom.dart' as sample_import_mojom;
import 'package:_mojo_for_test_only/imported/sample_import2.mojom.dart' as sample_import2_mojom;
const int kTwelve = 12;



class BarType extends bindings.MojoEnum {
  static const BarType vertical = const BarType._(1);
  static const BarType horizontal = const BarType._(2);
  static const BarType both = const BarType._(3);
  static const BarType invalid = const BarType._(4);

  const BarType._(int v) : super(v);

  static const Map<String, BarType> valuesMap = const {
    "vertical": vertical,
    "horizontal": horizontal,
    "both": both,
    "invalid": invalid,
  };
  static const List<BarType> values = const [
    vertical,
    horizontal,
    both,
    invalid,
  ];

  static BarType valueOf(String name) => valuesMap[name];

  factory BarType(int v) {
    switch (v) {
      case 1:
        return BarType.vertical;
      case 2:
        return BarType.horizontal;
      case 3:
        return BarType.both;
      case 4:
        return BarType.invalid;
      default:
        return null;
    }
  }

  static BarType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    BarType result = new BarType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum BarType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case vertical:
        return 'BarType.vertical';
      case horizontal:
        return 'BarType.horizontal';
      case both:
        return 'BarType.both';
      case invalid:
        return 'BarType.invalid';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class Bar extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int alpha = 255;
  int beta = 0;
  int gamma = 0;
  BarType type = new BarType(1);

  Bar() : super(kVersions.last.size);

  static Bar deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Bar decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Bar result = new Bar();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.alpha = decoder0.decodeUint8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.beta = decoder0.decodeUint8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.gamma = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
        result.type = BarType.decode(decoder0, 12);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable BarType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8(alpha, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "alpha of struct Bar: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(beta, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "beta of struct Bar: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(gamma, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "gamma of struct Bar: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct Bar: $e";
      rethrow;
    }
  }

  String toString() {
    return "Bar("
           "alpha: $alpha" ", "
           "beta: $beta" ", "
           "gamma: $gamma" ", "
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["alpha"] = alpha;
    map["beta"] = beta;
    map["gamma"] = gamma;
    map["type"] = type;
    return map;
  }
}


class Foo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(96, 0)
  ];
  static const String kFooby = "Fooby";
  int x = 0;
  int y = 0;
  bool a = true;
  bool b = false;
  bool c = false;
  core.MojoMessagePipeEndpoint source = null;
  Bar bar = null;
  List<int> data = null;
  List<Bar> extraBars = null;
  String name = "Fooby";
  List<core.MojoDataPipeConsumer> inputStreams = null;
  List<core.MojoDataPipeProducer> outputStreams = null;
  List<List<bool>> arrayOfArrayOfBools = null;
  List<List<List<String>>> multiArrayOfStrings = null;
  List<bool> arrayOfBools = null;

  Foo() : super(kVersions.last.size);

  static Foo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Foo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Foo result = new Foo();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeInt32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a = decoder0.decodeBool(16, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.b = decoder0.decodeBool(16, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.c = decoder0.decodeBool(16, 2);
    }
    if (mainDataHeader.version >= 0) {
      
      result.source = decoder0.decodeMessagePipeHandle(20, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      result.bar = Bar.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.data = decoder0.decodeUint8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, true);
      if (decoder1 == null) {
        result.extraBars = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.extraBars = new List<Bar>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.extraBars[i1] = Bar.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(48, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.inputStreams = decoder0.decodeConsumerHandleArray(56, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.outputStreams = decoder0.decodeProducerHandleArray(64, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(72, true);
      if (decoder1 == null) {
        result.arrayOfArrayOfBools = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.arrayOfArrayOfBools = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.arrayOfArrayOfBools[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, true);
      if (decoder1 == null) {
        result.multiArrayOfStrings = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.multiArrayOfStrings = new List<List<List<String>>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            result.multiArrayOfStrings[i1] = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                result.multiArrayOfStrings[i1][i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  result.multiArrayOfStrings[i1][i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.arrayOfBools = decoder0.decodeBoolArray(88, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(a, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(b, 16, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(c, 16, 2);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "c of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(source, 20, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "source of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(bar, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "bar of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(data, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct Foo: $e";
      rethrow;
    }
    try {
      if (extraBars == null) {
        encoder0.encodeNullPointer(40, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(extraBars.length, 40, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < extraBars.length; ++i0) {
          encoder1.encodeStruct(extraBars[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "extraBars of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(name, 48, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandleArray(inputStreams, 56, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "inputStreams of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeProducerHandleArray(outputStreams, 64, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "outputStreams of struct Foo: $e";
      rethrow;
    }
    try {
      if (arrayOfArrayOfBools == null) {
        encoder0.encodeNullPointer(72, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(arrayOfArrayOfBools.length, 72, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < arrayOfArrayOfBools.length; ++i0) {
          encoder1.encodeBoolArray(arrayOfArrayOfBools[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "arrayOfArrayOfBools of struct Foo: $e";
      rethrow;
    }
    try {
      if (multiArrayOfStrings == null) {
        encoder0.encodeNullPointer(80, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(multiArrayOfStrings.length, 80, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < multiArrayOfStrings.length; ++i0) {
          if (multiArrayOfStrings[i0] == null) {
            encoder1.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
          } else {
            var encoder2 = encoder1.encodePointerArray(multiArrayOfStrings[i0].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < multiArrayOfStrings[i0].length; ++i1) {
              if (multiArrayOfStrings[i0][i1] == null) {
                encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
              } else {
                var encoder3 = encoder2.encodePointerArray(multiArrayOfStrings[i0][i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
                for (int i2 = 0; i2 < multiArrayOfStrings[i0][i1].length; ++i2) {
                  encoder3.encodeString(multiArrayOfStrings[i0][i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "multiArrayOfStrings of struct Foo: $e";
      rethrow;
    }
    try {
      encoder0.encodeBoolArray(arrayOfBools, 88, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "arrayOfBools of struct Foo: $e";
      rethrow;
    }
  }

  String toString() {
    return "Foo("
           "x: $x" ", "
           "y: $y" ", "
           "a: $a" ", "
           "b: $b" ", "
           "c: $c" ", "
           "source: $source" ", "
           "bar: $bar" ", "
           "data: $data" ", "
           "extraBars: $extraBars" ", "
           "name: $name" ", "
           "inputStreams: $inputStreams" ", "
           "outputStreams: $outputStreams" ", "
           "arrayOfArrayOfBools: $arrayOfArrayOfBools" ", "
           "multiArrayOfStrings: $multiArrayOfStrings" ", "
           "arrayOfBools: $arrayOfBools" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DefaultsTest extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(184, 0)
  ];
  int a0 = -12;
  int a1 = 12;
  int a2 = 1234;
  int a3 = 34567;
  bool a11 = true;
  bool a12 = false;
  int a4 = 123456;
  int a5 = 3456789012;
  int a6 = -111111111111;
  int a7 = 9999999999999999999;
  int a8 = 74565;
  int a9 = -74565;
  int a10 = 1234;
  double a13 = 123.25;
  double a14 = 1234567890.123;
  double a15 = 10000000000.0;
  double a16 = -1.2e+20;
  double a17 = 1.23e-20;
  List<int> a18 = null;
  String a19 = null;
  BarType a20 = new BarType(3);
  double a29 = double.INFINITY;
  sample_import_mojom.Point a21 = null;
  sample_import2_mojom.Thing a22 = new sample_import2_mojom.Thing();
  int a23 = 18446744073709551615;
  int a24 = 4886718345;
  int a25 = -4886718345;
  double a26 = double.INFINITY;
  double a27 = double.NEGATIVE_INFINITY;
  double a28 = double.NAN;
  double a30 = double.NEGATIVE_INFINITY;
  double a31 = double.NAN;

  DefaultsTest() : super(kVersions.last.size);

  static DefaultsTest deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DefaultsTest decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DefaultsTest result = new DefaultsTest();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.a0 = decoder0.decodeInt8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a1 = decoder0.decodeUint8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a2 = decoder0.decodeInt16(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a3 = decoder0.decodeUint16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a11 = decoder0.decodeBool(14, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a12 = decoder0.decodeBool(14, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a4 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a5 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a6 = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a7 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a8 = decoder0.decodeInt32(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a9 = decoder0.decodeInt32(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a10 = decoder0.decodeInt32(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a13 = decoder0.decodeFloat(52);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a14 = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a15 = decoder0.decodeDouble(64);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a16 = decoder0.decodeDouble(72);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a17 = decoder0.decodeDouble(80);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a18 = decoder0.decodeUint8Array(88, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a19 = decoder0.decodeString(96, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.a20 = BarType.decode(decoder0, 104);
        if (result.a20 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable BarType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.a29 = decoder0.decodeFloat(108);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(112, false);
      result.a21 = sample_import_mojom.Point.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(120, false);
      result.a22 = sample_import2_mojom.Thing.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a23 = decoder0.decodeUint64(128);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a24 = decoder0.decodeInt64(136);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a25 = decoder0.decodeInt64(144);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a26 = decoder0.decodeDouble(152);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a27 = decoder0.decodeDouble(160);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a28 = decoder0.decodeDouble(168);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a30 = decoder0.decodeFloat(176);
    }
    if (mainDataHeader.version >= 0) {
      
      result.a31 = decoder0.decodeFloat(180);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt8(a0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a0 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(a1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a1 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(a2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a2 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(a3, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a3 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(a11, 14, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a11 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(a12, 14, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a12 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(a4, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a4 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(a5, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a5 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(a6, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a6 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(a7, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a7 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(a8, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a8 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(a9, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a9 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(a10, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a10 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(a13, 52);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a13 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(a14, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a14 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(a15, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a15 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(a16, 72);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a16 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(a17, 80);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a17 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(a18, 88, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a18 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(a19, 96, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a19 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(a20, 104);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a20 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(a29, 108);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a29 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(a21, 112, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a21 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(a22, 120, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a22 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(a23, 128);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a23 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(a24, 136);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a24 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(a25, 144);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a25 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(a26, 152);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a26 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(a27, 160);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a27 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(a28, 168);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a28 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(a30, 176);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a30 of struct DefaultsTest: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(a31, 180);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a31 of struct DefaultsTest: $e";
      rethrow;
    }
  }

  String toString() {
    return "DefaultsTest("
           "a0: $a0" ", "
           "a1: $a1" ", "
           "a2: $a2" ", "
           "a3: $a3" ", "
           "a11: $a11" ", "
           "a12: $a12" ", "
           "a4: $a4" ", "
           "a5: $a5" ", "
           "a6: $a6" ", "
           "a7: $a7" ", "
           "a8: $a8" ", "
           "a9: $a9" ", "
           "a10: $a10" ", "
           "a13: $a13" ", "
           "a14: $a14" ", "
           "a15: $a15" ", "
           "a16: $a16" ", "
           "a17: $a17" ", "
           "a18: $a18" ", "
           "a19: $a19" ", "
           "a20: $a20" ", "
           "a29: $a29" ", "
           "a21: $a21" ", "
           "a22: $a22" ", "
           "a23: $a23" ", "
           "a24: $a24" ", "
           "a25: $a25" ", "
           "a26: $a26" ", "
           "a27: $a27" ", "
           "a28: $a28" ", "
           "a30: $a30" ", "
           "a31: $a31" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a0"] = a0;
    map["a1"] = a1;
    map["a2"] = a2;
    map["a3"] = a3;
    map["a11"] = a11;
    map["a12"] = a12;
    map["a4"] = a4;
    map["a5"] = a5;
    map["a6"] = a6;
    map["a7"] = a7;
    map["a8"] = a8;
    map["a9"] = a9;
    map["a10"] = a10;
    map["a13"] = a13;
    map["a14"] = a14;
    map["a15"] = a15;
    map["a16"] = a16;
    map["a17"] = a17;
    map["a18"] = a18;
    map["a19"] = a19;
    map["a20"] = a20;
    map["a29"] = a29;
    map["a21"] = a21;
    map["a22"] = a22;
    map["a23"] = a23;
    map["a24"] = a24;
    map["a25"] = a25;
    map["a26"] = a26;
    map["a27"] = a27;
    map["a28"] = a28;
    map["a30"] = a30;
    map["a31"] = a31;
    return map;
  }
}


class StructWithHoleV1 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int v1 = 1;
  int v2 = 2;

  StructWithHoleV1() : super(kVersions.last.size);

  static StructWithHoleV1 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithHoleV1 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithHoleV1 result = new StructWithHoleV1();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.v1 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.v2 = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(v1, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "v1 of struct StructWithHoleV1: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(v2, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "v2 of struct StructWithHoleV1: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructWithHoleV1("
           "v1: $v1" ", "
           "v2: $v2" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["v1"] = v1;
    map["v2"] = v2;
    return map;
  }
}


class StructWithHoleV2 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int v1 = 1;
  int v3 = 3;
  int v2 = 2;

  StructWithHoleV2() : super(kVersions.last.size);

  static StructWithHoleV2 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithHoleV2 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithHoleV2 result = new StructWithHoleV2();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.v1 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.v3 = decoder0.decodeInt32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.v2 = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(v1, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "v1 of struct StructWithHoleV2: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(v3, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "v3 of struct StructWithHoleV2: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(v2, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "v2 of struct StructWithHoleV2: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructWithHoleV2("
           "v1: $v1" ", "
           "v3: $v3" ", "
           "v2: $v2" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["v1"] = v1;
    map["v3"] = v3;
    map["v2"] = v2;
    return map;
  }
}


class NonNullableMapStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Map<String, String> mapField = null;

  NonNullableMapStruct() : super(kVersions.last.size);

  static NonNullableMapStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NonNullableMapStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NonNullableMapStruct result = new NonNullableMapStruct();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<String> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              values0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        result.mapField = new Map<String, String>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (mapField == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encoderForMap(8);
        var keys0 = mapField.keys.toList();
        var values0 = mapField.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeString(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mapField of struct NonNullableMapStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "NonNullableMapStruct("
           "mapField: $mapField" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["mapField"] = mapField;
    return map;
  }
}


class _ServiceFrobinateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  Foo foo = null;
  ServiceBazOptions baz = null;
  Object port = null;

  _ServiceFrobinateParams() : super(kVersions.last.size);

  static _ServiceFrobinateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ServiceFrobinateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ServiceFrobinateParams result = new _ServiceFrobinateParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.foo = Foo.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
        result.baz = ServiceBazOptions.decode(decoder0, 16);
        if (result.baz == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ServiceBazOptions.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.port = decoder0.decodeServiceInterface(20, true, PortProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(foo, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "foo of struct _ServiceFrobinateParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(baz, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "baz of struct _ServiceFrobinateParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(port, 20, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "port of struct _ServiceFrobinateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ServiceFrobinateParams("
           "foo: $foo" ", "
           "baz: $baz" ", "
           "port: $port" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ServiceFrobinateResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int result = 0;

  ServiceFrobinateResponseParams() : super(kVersions.last.size);

  static ServiceFrobinateResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ServiceFrobinateResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ServiceFrobinateResponseParams result = new ServiceFrobinateResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.result = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(result, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct ServiceFrobinateResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ServiceFrobinateResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _ServiceGetPortParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object port = null;

  _ServiceGetPortParams() : super(kVersions.last.size);

  static _ServiceGetPortParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ServiceGetPortParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ServiceGetPortParams result = new _ServiceGetPortParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.port = decoder0.decodeInterfaceRequest(8, false, PortStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(port, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "port of struct _ServiceGetPortParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ServiceGetPortParams("
           "port: $port" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _PortPostMessageParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String messageText = null;
  Object port = null;

  _PortPostMessageParams() : super(kVersions.last.size);

  static _PortPostMessageParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PortPostMessageParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PortPostMessageParams result = new _PortPostMessageParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.messageText = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.port = decoder0.decodeServiceInterface(16, false, PortProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(messageText, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "messageText of struct _PortPostMessageParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(port, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "port of struct _PortPostMessageParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PortPostMessageParams("
           "messageText: $messageText" ", "
           "port: $port" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _serviceMethodFrobinateName = 0;
const int _serviceMethodGetPortName = 1;
  
class ServiceBazOptions extends bindings.MojoEnum {
  static const ServiceBazOptions regular = const ServiceBazOptions._(0);
  static const ServiceBazOptions extra = const ServiceBazOptions._(1);

  const ServiceBazOptions._(int v) : super(v);

  static const Map<String, ServiceBazOptions> valuesMap = const {
    "regular": regular,
    "extra": extra,
  };
  static const List<ServiceBazOptions> values = const [
    regular,
    extra,
  ];

  static ServiceBazOptions valueOf(String name) => valuesMap[name];

  factory ServiceBazOptions(int v) {
    switch (v) {
      case 0:
        return ServiceBazOptions.regular;
      case 1:
        return ServiceBazOptions.extra;
      default:
        return null;
    }
  }

  static ServiceBazOptions decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ServiceBazOptions result = new ServiceBazOptions(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ServiceBazOptions.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case regular:
        return 'ServiceBazOptions.regular';
      case extra:
        return 'ServiceBazOptions.extra';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class _ServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Service {
  static const String serviceName = null;
  dynamic frobinate(Foo foo,ServiceBazOptions baz,Object port,[Function responseFactory = null]);
  void getPort(Object port);
  static const int kFavoriteBaz = 1;
}


class _ServiceProxyImpl extends bindings.Proxy {
  _ServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ServiceProxyImpl.unbound() : super.unbound();

  static _ServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ServiceProxyImpl"));
    return new _ServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _serviceMethodFrobinateName:
        var r = ServiceFrobinateResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_ServiceProxyImpl($superString)";
  }
}


class _ServiceProxyCalls implements Service {
  _ServiceProxyImpl _proxyImpl;

  _ServiceProxyCalls(this._proxyImpl);
    dynamic frobinate(Foo foo,ServiceBazOptions baz,Object port,[Function responseFactory = null]) {
      var params = new _ServiceFrobinateParams();
      params.foo = foo;
      params.baz = baz;
      params.port = port;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _serviceMethodFrobinateName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getPort(Object port) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ServiceGetPortParams();
      params.port = port;
      _proxyImpl.sendMessage(params, _serviceMethodGetPortName);
    }
}


class ServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Service ptr;

  ServiceProxy(_ServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ServiceProxyCalls(proxyImpl);

  ServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ServiceProxyCalls(impl);
  }

  ServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ServiceProxyImpl.fromHandle(handle) {
    ptr = new _ServiceProxyCalls(impl);
  }

  ServiceProxy.unbound() :
      impl = new _ServiceProxyImpl.unbound() {
    ptr = new _ServiceProxyCalls(impl);
  }

  factory ServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ServiceProxy p = new ServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ServiceProxy"));
    return new ServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Service.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ServiceProxy($impl)";
  }
}


class ServiceStub extends bindings.Stub {
  Service _impl = null;

  ServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ServiceStub.unbound() : super.unbound();

  static ServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ServiceStub"));
    return new ServiceStub.fromEndpoint(endpoint);
  }


  ServiceFrobinateResponseParams _serviceFrobinateResponseParamsFactory(int result) {
    var result = new ServiceFrobinateResponseParams();
    result.result = result;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _serviceMethodFrobinateName:
        var params = _ServiceFrobinateParams.deserialize(
            message.payload);
        var response = _impl.frobinate(params.foo,params.baz,params.port,_serviceFrobinateResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _serviceMethodFrobinateName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _serviceMethodFrobinateName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _serviceMethodGetPortName:
        var params = _ServiceGetPortParams.deserialize(
            message.payload);
        _impl.getPort(params.port);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Service get impl => _impl;
  set impl(Service d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _portMethodPostMessageName = 0;

class _PortServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Port {
  static const String serviceName = null;
  void postMessage(String messageText, Object port);
}


class _PortProxyImpl extends bindings.Proxy {
  _PortProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _PortProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _PortProxyImpl.unbound() : super.unbound();

  static _PortProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _PortProxyImpl"));
    return new _PortProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _PortServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_PortProxyImpl($superString)";
  }
}


class _PortProxyCalls implements Port {
  _PortProxyImpl _proxyImpl;

  _PortProxyCalls(this._proxyImpl);
    void postMessage(String messageText, Object port) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PortPostMessageParams();
      params.messageText = messageText;
      params.port = port;
      _proxyImpl.sendMessage(params, _portMethodPostMessageName);
    }
}


class PortProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Port ptr;

  PortProxy(_PortProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _PortProxyCalls(proxyImpl);

  PortProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _PortProxyImpl.fromEndpoint(endpoint) {
    ptr = new _PortProxyCalls(impl);
  }

  PortProxy.fromHandle(core.MojoHandle handle) :
      impl = new _PortProxyImpl.fromHandle(handle) {
    ptr = new _PortProxyCalls(impl);
  }

  PortProxy.unbound() :
      impl = new _PortProxyImpl.unbound() {
    ptr = new _PortProxyCalls(impl);
  }

  factory PortProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    PortProxy p = new PortProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static PortProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PortProxy"));
    return new PortProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Port.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "PortProxy($impl)";
  }
}


class PortStub extends bindings.Stub {
  Port _impl = null;

  PortStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  PortStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  PortStub.unbound() : super.unbound();

  static PortStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PortStub"));
    return new PortStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _portMethodPostMessageName:
        var params = _PortPostMessageParams.deserialize(
            message.payload);
        _impl.postMessage(params.messageText, params.port);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Port get impl => _impl;
  set impl(Port d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "PortStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _PortServiceDescription();
    }
    return _cachedServiceDescription;
  }
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
  var serializedRuntimeTypeInfo = "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";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  sample_import_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
          _runtimeTypeInfo.typeMap[s] = udt;
      });

  sample_import2_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
          _runtimeTypeInfo.typeMap[s] = udt;
      });

  return _runtimeTypeInfo;
}
