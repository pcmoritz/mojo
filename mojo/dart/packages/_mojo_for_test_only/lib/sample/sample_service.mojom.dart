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
