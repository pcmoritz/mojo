// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library validation_test_interfaces_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class BasicEnum extends bindings.MojoEnum {
  static const BasicEnum a = const BasicEnum._(0);
  static const BasicEnum b = const BasicEnum._(1);
  static const BasicEnum c = const BasicEnum._(0);
  static const BasicEnum d = const BasicEnum._(-3);
  static const BasicEnum e = const BasicEnum._(10);

  const BasicEnum._(int v) : super(v);

  static const Map<String, BasicEnum> valuesMap = const {
    "a": a,
    "b": b,
    "c": c,
    "d": d,
    "e": e,
  };
  static const List<BasicEnum> values = const [
    a,
    b,
    c,
    d,
    e,
  ];

  static BasicEnum valueOf(String name) => valuesMap[name];

  factory BasicEnum(int v) {
    switch (v) {
      case 0:
        return BasicEnum.a;
      case 1:
        return BasicEnum.b;
      case 0:
        return BasicEnum.c;
      case -3:
        return BasicEnum.d;
      case 10:
        return BasicEnum.e;
      default:
        return null;
    }
  }

  static BasicEnum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    BasicEnum result = new BasicEnum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum BasicEnum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case a:
        return 'BasicEnum.a';
      case b:
        return 'BasicEnum.b';
      case c:
        return 'BasicEnum.c';
      case d:
        return 'BasicEnum.d';
      case e:
        return 'BasicEnum.e';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class StructA extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int i = 0;

  StructA() : super(kVersions.last.size);

  static StructA deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructA decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructA result = new StructA();

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
      
      result.i = decoder0.decodeUint64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(i, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "i of struct StructA: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructA("
           "i: $i" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["i"] = i;
    return map;
  }
}


class StructB extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  StructA structA = null;

  StructB() : super(kVersions.last.size);

  static StructB deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructB decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructB result = new StructB();

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
      result.structA = StructA.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(structA, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "structA of struct StructB: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructB("
           "structA: $structA" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["structA"] = structA;
    return map;
  }
}


class StructC extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> data = null;

  StructC() : super(kVersions.last.size);

  static StructC deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructC decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructC result = new StructC();

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
      
      result.data = decoder0.decodeUint8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(data, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct StructC: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructC("
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    return map;
  }
}


class StructD extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<core.MojoMessagePipeEndpoint> messagePipes = null;

  StructD() : super(kVersions.last.size);

  static StructD deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructD decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructD result = new StructD();

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
      
      result.messagePipes = decoder0.decodeMessagePipeHandleArray(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandleArray(messagePipes, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "messagePipes of struct StructD: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructD("
           "messagePipes: $messagePipes" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class StructE extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  StructD structD = null;
  core.MojoDataPipeConsumer dataPipeConsumer = null;

  StructE() : super(kVersions.last.size);

  static StructE deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructE decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructE result = new StructE();

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
      result.structD = StructD.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.dataPipeConsumer = decoder0.decodeConsumerHandle(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(structD, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "structD of struct StructE: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(dataPipeConsumer, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "dataPipeConsumer of struct StructE: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructE("
           "structD: $structD" ", "
           "dataPipeConsumer: $dataPipeConsumer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class StructF extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> fixedSizeArray = null;

  StructF() : super(kVersions.last.size);

  static StructF deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructF decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructF result = new StructF();

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
      
      result.fixedSizeArray = decoder0.decodeUint8Array(8, bindings.kNothingNullable, 3);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(fixedSizeArray, 8, bindings.kNothingNullable, 3);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fixedSizeArray of struct StructF: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructF("
           "fixedSizeArray: $fixedSizeArray" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fixedSizeArray"] = fixedSizeArray;
    return map;
  }
}


class StructG extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3)
  ];
  int i = 0;
  bool b = false;
  StructA structA = null;
  String str = null;

  StructG() : super(kVersions.last.size);

  static StructG deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructG decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructG result = new StructG();

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
      
      result.i = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 3) {
      
      result.b = decoder0.decodeBool(12, 0);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.structA = StructA.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.str = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(i, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "i of struct StructG: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(b, 12, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct StructG: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(structA, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "structA of struct StructG: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(str, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "str of struct StructG: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructG("
           "i: $i" ", "
           "b: $b" ", "
           "structA: $structA" ", "
           "str: $str" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["i"] = i;
    map["b"] = b;
    map["structA"] = structA;
    map["str"] = str;
    return map;
  }
}


class StructH extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  bool a = false;
  int b = 0;
  UnionA c = null;
  List<UnionA> d = null;
  Map<int, UnionA> e = null;

  StructH() : super(kVersions.last.size);

  static StructH deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructH decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructH result = new StructH();

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
      
      result.a = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.b = decoder0.decodeUint8(9);
    }
    if (mainDataHeader.version >= 0) {
      
        result.c = UnionA.decode(decoder0, 16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, true);
      if (decoder1 == null) {
        result.d = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForUnionArray(bindings.kUnspecifiedArrayLength);
        result.d = new List<UnionA>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
            result.d[i1] = UnionA.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1);
            if (result.d[i1] == null) {
              throw new bindings.MojoCodecError(
                'Trying to decode null union for non-nullable UnionA.');
            }
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, true);
      if (decoder1 == null) {
        result.e = null;
      } else {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<UnionA> values0;
        {
          
          keys0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
            values0 = new List<UnionA>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
                values0[i2] = UnionA.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
                if (values0[i2] == null) {
                  throw new bindings.MojoCodecError(
                    'Trying to decode null union for non-nullable UnionA.');
                }
            }
          }
        }
        result.e = new Map<int, UnionA>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(a, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct StructH: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(b, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct StructH: $e";
      rethrow;
    }
    try {
      encoder0.encodeUnion(c, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "c of struct StructH: $e";
      rethrow;
    }
    try {
      if (d == null) {
        encoder0.encodeNullPointer(32, true);
      } else {
        var encoder1 = encoder0.encodeUnionArray(d.length, 32, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < d.length; ++i0) {
          encoder1.encodeUnion(d[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "d of struct StructH: $e";
      rethrow;
    }
    try {
      if (e == null) {
        encoder0.encodeNullPointer(40, true);
      } else {
        var encoder1 = encoder0.encoderForMap(40);
        var keys0 = e.keys.toList();
        var values0 = e.values.toList();
        encoder1.encodeUint8Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "e of struct StructH: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructH("
           "a: $a" ", "
           "b: $b" ", "
           "c: $c" ", "
           "d: $d" ", "
           "e: $e" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    map["b"] = b;
    map["c"] = c;
    map["d"] = d;
    map["e"] = e;
    return map;
  }
}


class BasicStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int a = 0;

  BasicStruct() : super(kVersions.last.size);

  static BasicStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static BasicStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    BasicStruct result = new BasicStruct();

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
      
      result.a = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct BasicStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "BasicStruct("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class StructWithEnumEnumWithin extends bindings.MojoEnum {
  static const StructWithEnumEnumWithin a = const StructWithEnumEnumWithin._(0);
  static const StructWithEnumEnumWithin b = const StructWithEnumEnumWithin._(1);
  static const StructWithEnumEnumWithin c = const StructWithEnumEnumWithin._(2);
  static const StructWithEnumEnumWithin d = const StructWithEnumEnumWithin._(3);

  const StructWithEnumEnumWithin._(int v) : super(v);

  static const Map<String, StructWithEnumEnumWithin> valuesMap = const {
    "a": a,
    "b": b,
    "c": c,
    "d": d,
  };
  static const List<StructWithEnumEnumWithin> values = const [
    a,
    b,
    c,
    d,
  ];

  static StructWithEnumEnumWithin valueOf(String name) => valuesMap[name];

  factory StructWithEnumEnumWithin(int v) {
    switch (v) {
      case 0:
        return StructWithEnumEnumWithin.a;
      case 1:
        return StructWithEnumEnumWithin.b;
      case 2:
        return StructWithEnumEnumWithin.c;
      case 3:
        return StructWithEnumEnumWithin.d;
      default:
        return null;
    }
  }

  static StructWithEnumEnumWithin decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    StructWithEnumEnumWithin result = new StructWithEnumEnumWithin(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum StructWithEnumEnumWithin.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case a:
        return 'StructWithEnumEnumWithin.a';
      case b:
        return 'StructWithEnumEnumWithin.b';
      case c:
        return 'StructWithEnumEnumWithin.c';
      case d:
        return 'StructWithEnumEnumWithin.d';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class StructWithEnum extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  StructWithEnum() : super(kVersions.last.size);

  static StructWithEnum deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithEnum decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithEnum result = new StructWithEnum();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "StructWithEnum("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _BoundsCheckTestInterfaceMethod0Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int param0 = 0;

  _BoundsCheckTestInterfaceMethod0Params() : super(kVersions.last.size);

  static _BoundsCheckTestInterfaceMethod0Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _BoundsCheckTestInterfaceMethod0Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _BoundsCheckTestInterfaceMethod0Params result = new _BoundsCheckTestInterfaceMethod0Params();

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
      
      result.param0 = decoder0.decodeUint8(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8(param0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _BoundsCheckTestInterfaceMethod0Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_BoundsCheckTestInterfaceMethod0Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class BoundsCheckTestInterfaceMethod0ResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int param0 = 0;

  BoundsCheckTestInterfaceMethod0ResponseParams() : super(kVersions.last.size);

  static BoundsCheckTestInterfaceMethod0ResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static BoundsCheckTestInterfaceMethod0ResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    BoundsCheckTestInterfaceMethod0ResponseParams result = new BoundsCheckTestInterfaceMethod0ResponseParams();

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
      
      result.param0 = decoder0.decodeUint8(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8(param0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct BoundsCheckTestInterfaceMethod0ResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "BoundsCheckTestInterfaceMethod0ResponseParams("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _BoundsCheckTestInterfaceMethod1Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int param0 = 0;

  _BoundsCheckTestInterfaceMethod1Params() : super(kVersions.last.size);

  static _BoundsCheckTestInterfaceMethod1Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _BoundsCheckTestInterfaceMethod1Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _BoundsCheckTestInterfaceMethod1Params result = new _BoundsCheckTestInterfaceMethod1Params();

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
      
      result.param0 = decoder0.decodeUint8(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8(param0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _BoundsCheckTestInterfaceMethod1Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_BoundsCheckTestInterfaceMethod1Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod0Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double param0 = 0.0;

  _ConformanceTestInterfaceMethod0Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod0Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod0Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod0Params result = new _ConformanceTestInterfaceMethod0Params();

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
      
      result.param0 = decoder0.decodeFloat(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeFloat(param0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod0Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod0Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod1Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  StructA param0 = null;

  _ConformanceTestInterfaceMethod1Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod1Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod1Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod1Params result = new _ConformanceTestInterfaceMethod1Params();

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
      result.param0 = StructA.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod1Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod1Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod2Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  StructB param0 = null;
  StructA param1 = null;

  _ConformanceTestInterfaceMethod2Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod2Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod2Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod2Params result = new _ConformanceTestInterfaceMethod2Params();

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
      result.param0 = StructB.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.param1 = StructA.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod2Params: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(param1, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param1 of struct _ConformanceTestInterfaceMethod2Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod2Params("
           "param0: $param0" ", "
           "param1: $param1" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    map["param1"] = param1;
    return map;
  }
}


class _ConformanceTestInterfaceMethod3Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<bool> param0 = null;

  _ConformanceTestInterfaceMethod3Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod3Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod3Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod3Params result = new _ConformanceTestInterfaceMethod3Params();

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
      
      result.param0 = decoder0.decodeBoolArray(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBoolArray(param0, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod3Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod3Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod4Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  StructC param0 = null;
  List<int> param1 = null;

  _ConformanceTestInterfaceMethod4Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod4Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod4Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod4Params result = new _ConformanceTestInterfaceMethod4Params();

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
      result.param0 = StructC.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.param1 = decoder0.decodeUint8Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod4Params: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(param1, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param1 of struct _ConformanceTestInterfaceMethod4Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod4Params("
           "param0: $param0" ", "
           "param1: $param1" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    map["param1"] = param1;
    return map;
  }
}


class _ConformanceTestInterfaceMethod5Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  StructE param0 = null;
  core.MojoDataPipeProducer param1 = null;

  _ConformanceTestInterfaceMethod5Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod5Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod5Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod5Params result = new _ConformanceTestInterfaceMethod5Params();

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
      result.param0 = StructE.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.param1 = decoder0.decodeProducerHandle(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod5Params: $e";
      rethrow;
    }
    try {
      encoder0.encodeProducerHandle(param1, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param1 of struct _ConformanceTestInterfaceMethod5Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod5Params("
           "param0: $param0" ", "
           "param1: $param1" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ConformanceTestInterfaceMethod6Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<List<int>> param0 = null;

  _ConformanceTestInterfaceMethod6Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod6Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod6Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod6Params result = new _ConformanceTestInterfaceMethod6Params();

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
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.param0 = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.param0[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (param0 == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(param0.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < param0.length; ++i0) {
          encoder1.encodeUint8Array(param0[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod6Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod6Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod7Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  StructF param0 = null;
  List<List<int>> param1 = null;

  _ConformanceTestInterfaceMethod7Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod7Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod7Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod7Params result = new _ConformanceTestInterfaceMethod7Params();

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
      result.param0 = StructF.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(2);
        result.param1 = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.param1[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kArrayNullable, 3);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod7Params: $e";
      rethrow;
    }
    try {
      if (param1 == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(param1.length, 16, 2);
        for (int i0 = 0; i0 < param1.length; ++i0) {
          encoder1.encodeUint8Array(param1[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kArrayNullable, 3);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param1 of struct _ConformanceTestInterfaceMethod7Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod7Params("
           "param0: $param0" ", "
           "param1: $param1" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    map["param1"] = param1;
    return map;
  }
}


class _ConformanceTestInterfaceMethod8Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<List<String>> param0 = null;

  _ConformanceTestInterfaceMethod8Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod8Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod8Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod8Params result = new _ConformanceTestInterfaceMethod8Params();

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
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.param0 = new List<List<String>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
          if (decoder2 == null) {
            result.param0[i1] = null;
          } else {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            result.param0[i1] = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              result.param0[i1][i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (param0 == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(param0.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < param0.length; ++i0) {
          if (param0[i0] == null) {
            encoder1.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, true);
          } else {
            var encoder2 = encoder1.encodePointerArray(param0[i0].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < param0[i0].length; ++i1) {
              encoder2.encodeString(param0[i0][i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod8Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod8Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod9Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<List<core.MojoHandle>> param0 = null;

  _ConformanceTestInterfaceMethod9Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod9Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod9Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod9Params result = new _ConformanceTestInterfaceMethod9Params();

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
      if (decoder1 == null) {
        result.param0 = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.param0 = new List<List<core.MojoHandle>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.param0[i1] = decoder1.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kElementNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (param0 == null) {
        encoder0.encodeNullPointer(8, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(param0.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < param0.length; ++i0) {
          encoder1.encodeHandleArray(param0[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kElementNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod9Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod9Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ConformanceTestInterfaceMethod10Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Map<String, int> param0 = null;

  _ConformanceTestInterfaceMethod10Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod10Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod10Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod10Params result = new _ConformanceTestInterfaceMethod10Params();

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
        List<int> values0;
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
          
          values0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.param0 = new Map<String, int>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (param0 == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encoderForMap(8);
        var keys0 = param0.keys.toList();
        var values0 = param0.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        encoder1.encodeUint8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod10Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod10Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod11Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  StructG param0 = null;

  _ConformanceTestInterfaceMethod11Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod11Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod11Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod11Params result = new _ConformanceTestInterfaceMethod11Params();

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
      result.param0 = StructG.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod11Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod11Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod12Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double param0 = 0.0;

  _ConformanceTestInterfaceMethod12Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod12Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod12Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod12Params result = new _ConformanceTestInterfaceMethod12Params();

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
      
      result.param0 = decoder0.decodeFloat(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeFloat(param0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod12Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod12Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class ConformanceTestInterfaceMethod12ResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double param0 = 0.0;

  ConformanceTestInterfaceMethod12ResponseParams() : super(kVersions.last.size);

  static ConformanceTestInterfaceMethod12ResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ConformanceTestInterfaceMethod12ResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ConformanceTestInterfaceMethod12ResponseParams result = new ConformanceTestInterfaceMethod12ResponseParams();

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
      
      result.param0 = decoder0.decodeFloat(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeFloat(param0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct ConformanceTestInterfaceMethod12ResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ConformanceTestInterfaceMethod12ResponseParams("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod13Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  Object param0 = null;
  int param1 = 0;
  Object param2 = null;

  _ConformanceTestInterfaceMethod13Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod13Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod13Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod13Params result = new _ConformanceTestInterfaceMethod13Params();

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
      
      result.param0 = decoder0.decodeServiceInterface(8, true, InterfaceAProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.param1 = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.param2 = decoder0.decodeServiceInterface(20, true, InterfaceAProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(param0, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod13Params: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(param1, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param1 of struct _ConformanceTestInterfaceMethod13Params: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(param2, 20, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param2 of struct _ConformanceTestInterfaceMethod13Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod13Params("
           "param0: $param0" ", "
           "param1: $param1" ", "
           "param2: $param2" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ConformanceTestInterfaceMethod14Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  UnionA param0 = null;

  _ConformanceTestInterfaceMethod14Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod14Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod14Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod14Params result = new _ConformanceTestInterfaceMethod14Params();

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
      
        result.param0 = UnionA.decode(decoder0, 8);
        if (result.param0 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable UnionA.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod14Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod14Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _ConformanceTestInterfaceMethod15Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  StructH param0 = null;

  _ConformanceTestInterfaceMethod15Params() : super(kVersions.last.size);

  static _ConformanceTestInterfaceMethod15Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ConformanceTestInterfaceMethod15Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ConformanceTestInterfaceMethod15Params result = new _ConformanceTestInterfaceMethod15Params();

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
      result.param0 = StructH.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _ConformanceTestInterfaceMethod15Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ConformanceTestInterfaceMethod15Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class _IntegrationTestInterfaceMethod0Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  BasicStruct param0 = null;

  _IntegrationTestInterfaceMethod0Params() : super(kVersions.last.size);

  static _IntegrationTestInterfaceMethod0Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IntegrationTestInterfaceMethod0Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IntegrationTestInterfaceMethod0Params result = new _IntegrationTestInterfaceMethod0Params();

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
      result.param0 = BasicStruct.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(param0, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct _IntegrationTestInterfaceMethod0Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_IntegrationTestInterfaceMethod0Params("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}


class IntegrationTestInterfaceMethod0ResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> param0 = null;

  IntegrationTestInterfaceMethod0ResponseParams() : super(kVersions.last.size);

  static IntegrationTestInterfaceMethod0ResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IntegrationTestInterfaceMethod0ResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IntegrationTestInterfaceMethod0ResponseParams result = new IntegrationTestInterfaceMethod0ResponseParams();

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
      
      result.param0 = decoder0.decodeUint8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(param0, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "param0 of struct IntegrationTestInterfaceMethod0ResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "IntegrationTestInterfaceMethod0ResponseParams("
           "param0: $param0" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["param0"] = param0;
    return map;
  }
}



enum UnionATag {
  a,
  b,
  c,
  d,
  e,
  f,
  g,
  h,
  i,
  j,
  unknown
}

class UnionA extends bindings.Union {
  static final _tagToInt = const {
    UnionATag.a: 0,
    UnionATag.b: 1,
    UnionATag.c: 2,
    UnionATag.d: 3,
    UnionATag.e: 4,
    UnionATag.f: 5,
    UnionATag.g: 6,
    UnionATag.h: 7,
    UnionATag.i: 8,
    UnionATag.j: 9,
  };

  static final _intToTag = const {
    0: UnionATag.a,
    1: UnionATag.b,
    2: UnionATag.c,
    3: UnionATag.d,
    4: UnionATag.e,
    5: UnionATag.f,
    6: UnionATag.g,
    7: UnionATag.h,
    8: UnionATag.i,
    9: UnionATag.j,
  };

  var _data;
  UnionATag _tag = UnionATag.unknown;

  UnionATag get tag => _tag;
  int get a {
    if (_tag != UnionATag.a) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.a);
    }
    return _data;
  }

  set a(int value) {
    _tag = UnionATag.a;
    _data = value;
  }
  int get b {
    if (_tag != UnionATag.b) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.b);
    }
    return _data;
  }

  set b(int value) {
    _tag = UnionATag.b;
    _data = value;
  }
  StructA get c {
    if (_tag != UnionATag.c) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.c);
    }
    return _data;
  }

  set c(StructA value) {
    _tag = UnionATag.c;
    _data = value;
  }
  List<int> get d {
    if (_tag != UnionATag.d) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.d);
    }
    return _data;
  }

  set d(List<int> value) {
    _tag = UnionATag.d;
    _data = value;
  }
  Map<String, int> get e {
    if (_tag != UnionATag.e) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.e);
    }
    return _data;
  }

  set e(Map<String, int> value) {
    _tag = UnionATag.e;
    _data = value;
  }
  UnionB get f {
    if (_tag != UnionATag.f) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.f);
    }
    return _data;
  }

  set f(UnionB value) {
    _tag = UnionATag.f;
    _data = value;
  }
  StructA get g {
    if (_tag != UnionATag.g) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.g);
    }
    return _data;
  }

  set g(StructA value) {
    _tag = UnionATag.g;
    _data = value;
  }
  List<int> get h {
    if (_tag != UnionATag.h) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.h);
    }
    return _data;
  }

  set h(List<int> value) {
    _tag = UnionATag.h;
    _data = value;
  }
  Map<String, int> get i {
    if (_tag != UnionATag.i) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.i);
    }
    return _data;
  }

  set i(Map<String, int> value) {
    _tag = UnionATag.i;
    _data = value;
  }
  UnionB get j {
    if (_tag != UnionATag.j) {
      throw new bindings.UnsetUnionTagError(_tag, UnionATag.j);
    }
    return _data;
  }

  set j(UnionB value) {
    _tag = UnionATag.j;
    _data = value;
  }

  static UnionA decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    UnionA result = new UnionA();

    
    UnionATag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case UnionATag.a:
        
        result.a = decoder0.decodeUint16(offset + 8);
        break;
      case UnionATag.b:
        
        result.b = decoder0.decodeUint32(offset + 8);
        break;
      case UnionATag.c:
        
        var decoder1 = decoder0.decodePointer(offset + 8, true);
        result.c = StructA.decode(decoder1);
        break;
      case UnionATag.d:
        
        result.d = decoder0.decodeUint8Array(offset + 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
        break;
      case UnionATag.e:
        
        var decoder1 = decoder0.decodePointer(offset + 8, true);
        if (decoder1 == null) {
          result.e = null;
        } else {
          decoder1.decodeDataHeaderForMap();
          List<String> keys0;
          List<int> values0;
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
            
            values0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
          }
          result.e = new Map<String, int>.fromIterables(
              keys0, values0);
        }
        break;
      case UnionATag.f:
        var decoder1 = decoder0.decodePointer(offset + 8, true);
        result.f = UnionB.decode(decoder1, 0);
        break;
      case UnionATag.g:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.g = StructA.decode(decoder1);
        break;
      case UnionATag.h:
        
        result.h = decoder0.decodeUint8Array(offset + 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        break;
      case UnionATag.i:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<String> keys0;
          List<int> values0;
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
            
            values0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
          }
          result.i = new Map<String, int>.fromIterables(
              keys0, values0);
        }
        break;
      case UnionATag.j:
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.j = UnionB.decode(decoder1, 0);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case UnionATag.a:
        encoder0.encodeUint16(a, offset + 8);
        break;
      case UnionATag.b:
        encoder0.encodeUint32(b, offset + 8);
        break;
      case UnionATag.c:
        encoder0.encodeStruct(c, offset + 8, true);
        break;
      case UnionATag.d:
        encoder0.encodeUint8Array(d, offset + 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
        break;
      case UnionATag.e:
        if (e == null) {
          encoder0.encodeNullPointer(offset + 8, true);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = e.keys.toList();
          var values0 = e.values.toList();
          
          {
            var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < keys0.length; ++i1) {
              encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
          encoder1.encodeUint8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        break;
      case UnionATag.f:
        encoder0.encodeNestedUnion(f, offset + 8, true);
        break;
      case UnionATag.g:
        encoder0.encodeStruct(g, offset + 8, false);
        break;
      case UnionATag.h:
        encoder0.encodeUint8Array(h, offset + 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        break;
      case UnionATag.i:
        if (i == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = i.keys.toList();
          var values0 = i.values.toList();
          
          {
            var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < keys0.length; ++i1) {
              encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
          encoder1.encodeUint8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        break;
      case UnionATag.j:
        encoder0.encodeNestedUnion(j, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "UnionA(";
    switch (_tag) {
      case UnionATag.a:
        result += "a";
        break;
      case UnionATag.b:
        result += "b";
        break;
      case UnionATag.c:
        result += "c";
        break;
      case UnionATag.d:
        result += "d";
        break;
      case UnionATag.e:
        result += "e";
        break;
      case UnionATag.f:
        result += "f";
        break;
      case UnionATag.g:
        result += "g";
        break;
      case UnionATag.h:
        result += "h";
        break;
      case UnionATag.i:
        result += "i";
        break;
      case UnionATag.j:
        result += "j";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum UnionBTag {
  a,
  b,
  c,
  d,
  unknown
}

class UnionB extends bindings.Union {
  static final _tagToInt = const {
    UnionBTag.a: 0,
    UnionBTag.b: 1,
    UnionBTag.c: 2,
    UnionBTag.d: 3,
  };

  static final _intToTag = const {
    0: UnionBTag.a,
    1: UnionBTag.b,
    2: UnionBTag.c,
    3: UnionBTag.d,
  };

  var _data;
  UnionBTag _tag = UnionBTag.unknown;

  UnionBTag get tag => _tag;
  int get a {
    if (_tag != UnionBTag.a) {
      throw new bindings.UnsetUnionTagError(_tag, UnionBTag.a);
    }
    return _data;
  }

  set a(int value) {
    _tag = UnionBTag.a;
    _data = value;
  }
  int get b {
    if (_tag != UnionBTag.b) {
      throw new bindings.UnsetUnionTagError(_tag, UnionBTag.b);
    }
    return _data;
  }

  set b(int value) {
    _tag = UnionBTag.b;
    _data = value;
  }
  int get c {
    if (_tag != UnionBTag.c) {
      throw new bindings.UnsetUnionTagError(_tag, UnionBTag.c);
    }
    return _data;
  }

  set c(int value) {
    _tag = UnionBTag.c;
    _data = value;
  }
  int get d {
    if (_tag != UnionBTag.d) {
      throw new bindings.UnsetUnionTagError(_tag, UnionBTag.d);
    }
    return _data;
  }

  set d(int value) {
    _tag = UnionBTag.d;
    _data = value;
  }

  static UnionB decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    UnionB result = new UnionB();

    
    UnionBTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case UnionBTag.a:
        
        result.a = decoder0.decodeUint16(offset + 8);
        break;
      case UnionBTag.b:
        
        result.b = decoder0.decodeUint32(offset + 8);
        break;
      case UnionBTag.c:
        
        result.c = decoder0.decodeUint64(offset + 8);
        break;
      case UnionBTag.d:
        
        result.d = decoder0.decodeUint32(offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case UnionBTag.a:
        encoder0.encodeUint16(a, offset + 8);
        break;
      case UnionBTag.b:
        encoder0.encodeUint32(b, offset + 8);
        break;
      case UnionBTag.c:
        encoder0.encodeUint64(c, offset + 8);
        break;
      case UnionBTag.d:
        encoder0.encodeUint32(d, offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "UnionB(";
    switch (_tag) {
      case UnionBTag.a:
        result += "a";
        break;
      case UnionBTag.b:
        result += "b";
        break;
      case UnionBTag.c:
        result += "c";
        break;
      case UnionBTag.d:
        result += "d";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}

class _InterfaceAServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class InterfaceA {
  static const String serviceName = null;
}


class _InterfaceAProxyImpl extends bindings.Proxy {
  _InterfaceAProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InterfaceAProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _InterfaceAProxyImpl.unbound() : super.unbound();

  static _InterfaceAProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _InterfaceAProxyImpl"));
    return new _InterfaceAProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _InterfaceAServiceDescription();

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
    return "_InterfaceAProxyImpl($superString)";
  }
}


class _InterfaceAProxyCalls implements InterfaceA {
  _InterfaceAProxyCalls(_InterfaceAProxyImpl _);
}


class InterfaceAProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  InterfaceA ptr;

  InterfaceAProxy(_InterfaceAProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _InterfaceAProxyCalls(proxyImpl);

  InterfaceAProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _InterfaceAProxyImpl.fromEndpoint(endpoint) {
    ptr = new _InterfaceAProxyCalls(impl);
  }

  InterfaceAProxy.fromHandle(core.MojoHandle handle) :
      impl = new _InterfaceAProxyImpl.fromHandle(handle) {
    ptr = new _InterfaceAProxyCalls(impl);
  }

  InterfaceAProxy.unbound() :
      impl = new _InterfaceAProxyImpl.unbound() {
    ptr = new _InterfaceAProxyCalls(impl);
  }

  factory InterfaceAProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InterfaceAProxy p = new InterfaceAProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static InterfaceAProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InterfaceAProxy"));
    return new InterfaceAProxy.fromEndpoint(endpoint);
  }

  String get serviceName => InterfaceA.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "InterfaceAProxy($impl)";
  }
}


class InterfaceAStub extends bindings.Stub {
  InterfaceA _impl = null;

  InterfaceAStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  InterfaceAStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  InterfaceAStub.unbound() : super.unbound();

  static InterfaceAStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InterfaceAStub"));
    return new InterfaceAStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  InterfaceA get impl => _impl;
  set impl(InterfaceA d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "InterfaceAStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _InterfaceAServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _boundsCheckTestInterfaceMethodMethod0Name = 0;
const int _boundsCheckTestInterfaceMethodMethod1Name = 1;

class _BoundsCheckTestInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().servicesByName["this.is.the.service.name.for.BoundsCheckTestInterface"].topLevelInterface;
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class BoundsCheckTestInterface {
  static const String serviceName = "this.is.the.service.name.for.BoundsCheckTestInterface";
  dynamic method0(int param0,[Function responseFactory = null]);
  void method1(int param0);
}


class _BoundsCheckTestInterfaceProxyImpl extends bindings.Proxy {
  _BoundsCheckTestInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _BoundsCheckTestInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _BoundsCheckTestInterfaceProxyImpl.unbound() : super.unbound();

  static _BoundsCheckTestInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _BoundsCheckTestInterfaceProxyImpl"));
    return new _BoundsCheckTestInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _BoundsCheckTestInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _boundsCheckTestInterfaceMethodMethod0Name:
        var r = BoundsCheckTestInterfaceMethod0ResponseParams.deserialize(
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
    return "_BoundsCheckTestInterfaceProxyImpl($superString)";
  }
}


class _BoundsCheckTestInterfaceProxyCalls implements BoundsCheckTestInterface {
  _BoundsCheckTestInterfaceProxyImpl _proxyImpl;

  _BoundsCheckTestInterfaceProxyCalls(this._proxyImpl);
    dynamic method0(int param0,[Function responseFactory = null]) {
      var params = new _BoundsCheckTestInterfaceMethod0Params();
      params.param0 = param0;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _boundsCheckTestInterfaceMethodMethod0Name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void method1(int param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _BoundsCheckTestInterfaceMethod1Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _boundsCheckTestInterfaceMethodMethod1Name);
    }
}


class BoundsCheckTestInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  BoundsCheckTestInterface ptr;

  BoundsCheckTestInterfaceProxy(_BoundsCheckTestInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _BoundsCheckTestInterfaceProxyCalls(proxyImpl);

  BoundsCheckTestInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _BoundsCheckTestInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _BoundsCheckTestInterfaceProxyCalls(impl);
  }

  BoundsCheckTestInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _BoundsCheckTestInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _BoundsCheckTestInterfaceProxyCalls(impl);
  }

  BoundsCheckTestInterfaceProxy.unbound() :
      impl = new _BoundsCheckTestInterfaceProxyImpl.unbound() {
    ptr = new _BoundsCheckTestInterfaceProxyCalls(impl);
  }

  factory BoundsCheckTestInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    BoundsCheckTestInterfaceProxy p = new BoundsCheckTestInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static BoundsCheckTestInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For BoundsCheckTestInterfaceProxy"));
    return new BoundsCheckTestInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => BoundsCheckTestInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "BoundsCheckTestInterfaceProxy($impl)";
  }
}


class BoundsCheckTestInterfaceStub extends bindings.Stub {
  BoundsCheckTestInterface _impl = null;

  BoundsCheckTestInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  BoundsCheckTestInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  BoundsCheckTestInterfaceStub.unbound() : super.unbound();

  static BoundsCheckTestInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For BoundsCheckTestInterfaceStub"));
    return new BoundsCheckTestInterfaceStub.fromEndpoint(endpoint);
  }


  BoundsCheckTestInterfaceMethod0ResponseParams _boundsCheckTestInterfaceMethod0ResponseParamsFactory(int param0) {
    var result = new BoundsCheckTestInterfaceMethod0ResponseParams();
    result.param0 = param0;
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
      case _boundsCheckTestInterfaceMethodMethod0Name:
        var params = _BoundsCheckTestInterfaceMethod0Params.deserialize(
            message.payload);
        var response = _impl.method0(params.param0,_boundsCheckTestInterfaceMethod0ResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _boundsCheckTestInterfaceMethodMethod0Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _boundsCheckTestInterfaceMethodMethod0Name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _boundsCheckTestInterfaceMethodMethod1Name:
        var params = _BoundsCheckTestInterfaceMethod1Params.deserialize(
            message.payload);
        _impl.method1(params.param0);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  BoundsCheckTestInterface get impl => _impl;
  set impl(BoundsCheckTestInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "BoundsCheckTestInterfaceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _BoundsCheckTestInterfaceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _conformanceTestInterfaceMethodMethod0Name = 0;
const int _conformanceTestInterfaceMethodMethod1Name = 1;
const int _conformanceTestInterfaceMethodMethod2Name = 2;
const int _conformanceTestInterfaceMethodMethod3Name = 3;
const int _conformanceTestInterfaceMethodMethod4Name = 4;
const int _conformanceTestInterfaceMethodMethod5Name = 5;
const int _conformanceTestInterfaceMethodMethod6Name = 6;
const int _conformanceTestInterfaceMethodMethod7Name = 7;
const int _conformanceTestInterfaceMethodMethod8Name = 8;
const int _conformanceTestInterfaceMethodMethod9Name = 9;
const int _conformanceTestInterfaceMethodMethod10Name = 10;
const int _conformanceTestInterfaceMethodMethod11Name = 11;
const int _conformanceTestInterfaceMethodMethod12Name = 12;
const int _conformanceTestInterfaceMethodMethod13Name = 13;
const int _conformanceTestInterfaceMethodMethod14Name = 14;
const int _conformanceTestInterfaceMethodMethod15Name = 15;

class _ConformanceTestInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ConformanceTestInterface {
  static const String serviceName = null;
  void method0(double param0);
  void method1(StructA param0);
  void method2(StructB param0, StructA param1);
  void method3(List<bool> param0);
  void method4(StructC param0, List<int> param1);
  void method5(StructE param0, core.MojoDataPipeProducer param1);
  void method6(List<List<int>> param0);
  void method7(StructF param0, List<List<int>> param1);
  void method8(List<List<String>> param0);
  void method9(List<List<core.MojoHandle>> param0);
  void method10(Map<String, int> param0);
  void method11(StructG param0);
  dynamic method12(double param0,[Function responseFactory = null]);
  void method13(Object param0, int param1, Object param2);
  void method14(UnionA param0);
  void method15(StructH param0);
}


class _ConformanceTestInterfaceProxyImpl extends bindings.Proxy {
  _ConformanceTestInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ConformanceTestInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ConformanceTestInterfaceProxyImpl.unbound() : super.unbound();

  static _ConformanceTestInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ConformanceTestInterfaceProxyImpl"));
    return new _ConformanceTestInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ConformanceTestInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _conformanceTestInterfaceMethodMethod12Name:
        var r = ConformanceTestInterfaceMethod12ResponseParams.deserialize(
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
    return "_ConformanceTestInterfaceProxyImpl($superString)";
  }
}


class _ConformanceTestInterfaceProxyCalls implements ConformanceTestInterface {
  _ConformanceTestInterfaceProxyImpl _proxyImpl;

  _ConformanceTestInterfaceProxyCalls(this._proxyImpl);
    void method0(double param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod0Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod0Name);
    }
    void method1(StructA param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod1Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod1Name);
    }
    void method2(StructB param0, StructA param1) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod2Params();
      params.param0 = param0;
      params.param1 = param1;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod2Name);
    }
    void method3(List<bool> param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod3Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod3Name);
    }
    void method4(StructC param0, List<int> param1) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod4Params();
      params.param0 = param0;
      params.param1 = param1;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod4Name);
    }
    void method5(StructE param0, core.MojoDataPipeProducer param1) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod5Params();
      params.param0 = param0;
      params.param1 = param1;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod5Name);
    }
    void method6(List<List<int>> param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod6Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod6Name);
    }
    void method7(StructF param0, List<List<int>> param1) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod7Params();
      params.param0 = param0;
      params.param1 = param1;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod7Name);
    }
    void method8(List<List<String>> param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod8Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod8Name);
    }
    void method9(List<List<core.MojoHandle>> param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod9Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod9Name);
    }
    void method10(Map<String, int> param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod10Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod10Name);
    }
    void method11(StructG param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod11Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod11Name);
    }
    dynamic method12(double param0,[Function responseFactory = null]) {
      var params = new _ConformanceTestInterfaceMethod12Params();
      params.param0 = param0;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _conformanceTestInterfaceMethodMethod12Name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void method13(Object param0, int param1, Object param2) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod13Params();
      params.param0 = param0;
      params.param1 = param1;
      params.param2 = param2;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod13Name);
    }
    void method14(UnionA param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod14Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod14Name);
    }
    void method15(StructH param0) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ConformanceTestInterfaceMethod15Params();
      params.param0 = param0;
      _proxyImpl.sendMessage(params, _conformanceTestInterfaceMethodMethod15Name);
    }
}


class ConformanceTestInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ConformanceTestInterface ptr;

  ConformanceTestInterfaceProxy(_ConformanceTestInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ConformanceTestInterfaceProxyCalls(proxyImpl);

  ConformanceTestInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ConformanceTestInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ConformanceTestInterfaceProxyCalls(impl);
  }

  ConformanceTestInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ConformanceTestInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _ConformanceTestInterfaceProxyCalls(impl);
  }

  ConformanceTestInterfaceProxy.unbound() :
      impl = new _ConformanceTestInterfaceProxyImpl.unbound() {
    ptr = new _ConformanceTestInterfaceProxyCalls(impl);
  }

  factory ConformanceTestInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ConformanceTestInterfaceProxy p = new ConformanceTestInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ConformanceTestInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ConformanceTestInterfaceProxy"));
    return new ConformanceTestInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ConformanceTestInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ConformanceTestInterfaceProxy($impl)";
  }
}


class ConformanceTestInterfaceStub extends bindings.Stub {
  ConformanceTestInterface _impl = null;

  ConformanceTestInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ConformanceTestInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ConformanceTestInterfaceStub.unbound() : super.unbound();

  static ConformanceTestInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ConformanceTestInterfaceStub"));
    return new ConformanceTestInterfaceStub.fromEndpoint(endpoint);
  }


  ConformanceTestInterfaceMethod12ResponseParams _conformanceTestInterfaceMethod12ResponseParamsFactory(double param0) {
    var result = new ConformanceTestInterfaceMethod12ResponseParams();
    result.param0 = param0;
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
      case _conformanceTestInterfaceMethodMethod0Name:
        var params = _ConformanceTestInterfaceMethod0Params.deserialize(
            message.payload);
        _impl.method0(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod1Name:
        var params = _ConformanceTestInterfaceMethod1Params.deserialize(
            message.payload);
        _impl.method1(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod2Name:
        var params = _ConformanceTestInterfaceMethod2Params.deserialize(
            message.payload);
        _impl.method2(params.param0, params.param1);
        break;
      case _conformanceTestInterfaceMethodMethod3Name:
        var params = _ConformanceTestInterfaceMethod3Params.deserialize(
            message.payload);
        _impl.method3(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod4Name:
        var params = _ConformanceTestInterfaceMethod4Params.deserialize(
            message.payload);
        _impl.method4(params.param0, params.param1);
        break;
      case _conformanceTestInterfaceMethodMethod5Name:
        var params = _ConformanceTestInterfaceMethod5Params.deserialize(
            message.payload);
        _impl.method5(params.param0, params.param1);
        break;
      case _conformanceTestInterfaceMethodMethod6Name:
        var params = _ConformanceTestInterfaceMethod6Params.deserialize(
            message.payload);
        _impl.method6(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod7Name:
        var params = _ConformanceTestInterfaceMethod7Params.deserialize(
            message.payload);
        _impl.method7(params.param0, params.param1);
        break;
      case _conformanceTestInterfaceMethodMethod8Name:
        var params = _ConformanceTestInterfaceMethod8Params.deserialize(
            message.payload);
        _impl.method8(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod9Name:
        var params = _ConformanceTestInterfaceMethod9Params.deserialize(
            message.payload);
        _impl.method9(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod10Name:
        var params = _ConformanceTestInterfaceMethod10Params.deserialize(
            message.payload);
        _impl.method10(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod11Name:
        var params = _ConformanceTestInterfaceMethod11Params.deserialize(
            message.payload);
        _impl.method11(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod12Name:
        var params = _ConformanceTestInterfaceMethod12Params.deserialize(
            message.payload);
        var response = _impl.method12(params.param0,_conformanceTestInterfaceMethod12ResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _conformanceTestInterfaceMethodMethod12Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _conformanceTestInterfaceMethodMethod12Name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _conformanceTestInterfaceMethodMethod13Name:
        var params = _ConformanceTestInterfaceMethod13Params.deserialize(
            message.payload);
        _impl.method13(params.param0, params.param1, params.param2);
        break;
      case _conformanceTestInterfaceMethodMethod14Name:
        var params = _ConformanceTestInterfaceMethod14Params.deserialize(
            message.payload);
        _impl.method14(params.param0);
        break;
      case _conformanceTestInterfaceMethodMethod15Name:
        var params = _ConformanceTestInterfaceMethod15Params.deserialize(
            message.payload);
        _impl.method15(params.param0);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ConformanceTestInterface get impl => _impl;
  set impl(ConformanceTestInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ConformanceTestInterfaceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ConformanceTestInterfaceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _integrationTestInterfaceMethodMethod0Name = 0;

class _IntegrationTestInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class IntegrationTestInterface {
  static const String serviceName = null;
  dynamic method0(BasicStruct param0,[Function responseFactory = null]);
}


class _IntegrationTestInterfaceProxyImpl extends bindings.Proxy {
  _IntegrationTestInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _IntegrationTestInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _IntegrationTestInterfaceProxyImpl.unbound() : super.unbound();

  static _IntegrationTestInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _IntegrationTestInterfaceProxyImpl"));
    return new _IntegrationTestInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _IntegrationTestInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _integrationTestInterfaceMethodMethod0Name:
        var r = IntegrationTestInterfaceMethod0ResponseParams.deserialize(
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
    return "_IntegrationTestInterfaceProxyImpl($superString)";
  }
}


class _IntegrationTestInterfaceProxyCalls implements IntegrationTestInterface {
  _IntegrationTestInterfaceProxyImpl _proxyImpl;

  _IntegrationTestInterfaceProxyCalls(this._proxyImpl);
    dynamic method0(BasicStruct param0,[Function responseFactory = null]) {
      var params = new _IntegrationTestInterfaceMethod0Params();
      params.param0 = param0;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _integrationTestInterfaceMethodMethod0Name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class IntegrationTestInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  IntegrationTestInterface ptr;

  IntegrationTestInterfaceProxy(_IntegrationTestInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _IntegrationTestInterfaceProxyCalls(proxyImpl);

  IntegrationTestInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _IntegrationTestInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _IntegrationTestInterfaceProxyCalls(impl);
  }

  IntegrationTestInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _IntegrationTestInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _IntegrationTestInterfaceProxyCalls(impl);
  }

  IntegrationTestInterfaceProxy.unbound() :
      impl = new _IntegrationTestInterfaceProxyImpl.unbound() {
    ptr = new _IntegrationTestInterfaceProxyCalls(impl);
  }

  factory IntegrationTestInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    IntegrationTestInterfaceProxy p = new IntegrationTestInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static IntegrationTestInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IntegrationTestInterfaceProxy"));
    return new IntegrationTestInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => IntegrationTestInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "IntegrationTestInterfaceProxy($impl)";
  }
}


class IntegrationTestInterfaceStub extends bindings.Stub {
  IntegrationTestInterface _impl = null;

  IntegrationTestInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  IntegrationTestInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  IntegrationTestInterfaceStub.unbound() : super.unbound();

  static IntegrationTestInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IntegrationTestInterfaceStub"));
    return new IntegrationTestInterfaceStub.fromEndpoint(endpoint);
  }


  IntegrationTestInterfaceMethod0ResponseParams _integrationTestInterfaceMethod0ResponseParamsFactory(List<int> param0) {
    var result = new IntegrationTestInterfaceMethod0ResponseParams();
    result.param0 = param0;
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
      case _integrationTestInterfaceMethodMethod0Name:
        var params = _IntegrationTestInterfaceMethod0Params.deserialize(
            message.payload);
        var response = _impl.method0(params.param0,_integrationTestInterfaceMethod0ResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _integrationTestInterfaceMethodMethod0Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _integrationTestInterfaceMethodMethod0Name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  IntegrationTestInterface get impl => _impl;
  set impl(IntegrationTestInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "IntegrationTestInterfaceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _IntegrationTestInterfaceServiceDescription();
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xdS3DbxhkG+JCoh206sV3aTTz0K5XjhKRetuyZpBQp2eqk7ijxS47bUDQFi3DNR0gqld0e1OlF05Nv9dHHHHX0scccdczRRx919CXTAuK/ErDYBRYgsFwyxGS9WWpJ7H77/9///4vdRUJqX3HIf4Yc/3zFUJa1FIPyF1qa1VKrrDZT2n+tspJqKo0f1JKSqhYrSupJrZHK1Taqa818WSn99a7SbP2h2lIaT4olhfB7+H2zkE9r6YqW7j5cXix8tfjwRqX2tJZqab9m9+v0330TbuevtPSBll7C5zuQ70K+3zjtykC+CvkW5K8h/y/kbyGXQu0sCXkW8lXItyD/EfKfIX8P+UUtfUTpb7GplharGxW93idaOmtT706rsVFqecfP5nv5WlUb3EqxWlJcfU+vuN4ottRa1fq9S1r6mP69/Yrz2t/Pa+kMuV67y/NtHB3r5Rjr5RnrLTDWW2Ssd5Ox3i3Gekvtepe1dM6u3gO1VUZCpl0zWvqMpX5K/0cvqFUJ7nGa/L17VU0CYJgc68EwSRNyW1+RHidkMy8lRw7LuorXx8zl5VPmcvZbc/lV0fx7u4/N5YRiLr9Zx+7/1Fx+/cxc3qyby+8a5vL751j5n2beevmvw7JOFa/+bS7v/IfMd4jHEJ+iK4Px7P/gWpbI13Et6RCbSEi7fqulD7VEoSlLe/RPo1oqaemRltLlWkVJF18Uq2pa/410s1Fq/0994/EztZRWkfY304/V6ppaXW+m9fs00z8Un6lr+3RS0D8oHNZM6T9QOeinfr8JuH9ZNvPvXKSdb0fNuKD6cVmyvWi4zmG4LlG+PwJDhPRB58CTZDxT8wQ8qzD+vPBktU+sOMo+45hjwDFHwLHWYzginpiQg5HHPAOOeQKOdUFxxNuZoOifk1+FFNFuXCTDuPyiYe3nuCwwjMsCob/fCzouyP7+ItnzL47rqM/yvsiA6yIB14bguCKckpjcx2QsTunQP9B9gDHkH6Dgg47nQQ0cTx3HYY544nFoFpMf1K6oxHbRcJQMOBrlmyaPRUr8ugZt7RY+Ccx2xzF9RXK2A/L1jmKfEL5vsLgbydkeBR+8PUkCTsOGz5Fc3mnPTfypWFF8mb9Iwj1pVT6FmIwx3LaM81egu7zGuVM8aPY1fjgl0o6joIzqbUXJ8vMOlcP+6tcxkI/bSqtcW8tY2v1HznyOyy/qtxRi769+ZSj9/Q30Gfr7eUP5fkNrjDVONPCvSLw7zIl3j2ppSPdfi41iJSMR5SIuIO8GLT8JuNeh/DTrtWpTGciPe/k53wN2+53L+NyIj8zMu5MWfG73Ne9ODnjXo97cFpR3cb1BV5JxPmYJk6MyBR/kZ9Ieulj9TNvHMxZ8lzn7maT7IzziBpxDEL9GIPYaApmMQYw0Cn79uJaOgBzp+rYNv7OF4hDwH+dAoDPj4Hceg/E50c73oGGrH8Hn5+D53kUow4DvXIHfS0N5BuKXG/C89Es2XuXlz3498GeF4tWQILz6dY/warf8kW8E0ZuVgT+yz//vBdGbb2DdCG+5kCjzK0iO0eIH1vURfuljyAXuIWZ9nLLgfkcQffwpHIQ+Tgmjj/j8XF3uDb28I7Re5pjXI7nFOeYBZ5kV50kyzuf7nP9ChrIT/4Vd4B5m5r9pC+53BeG/ZCD+yHRP+SMhgXhPl4tTXdJHve1xh+dzXv2KiAv8Isx6NWPB754gevUyEL9iZuBXdKhf94T2K/LM65fd8hhvv0LH+XcC8Niw5K9/EHWBX5SZx2Yt+N0XhMe2AuGx2QGPdchj94XmsUXmfRMknCMC8dh9WEfD0181xiJ+8daQC7yGmHnrqgWvB4LwVjaQuObqIK7xyFe6XJztsj8QkqzrDL34C27inmEX+A4z69014r5OEfRuJxB/4drAX+hQ/1aE9hduMu+fFD3uWeHsLyQxf4DGc7LBnwgiLoq5wDfGzHNzFnwfCsJzy4H4F3MD/8Ijvz2EsRLNv5ANfzfiGdQ864gLvEeY9fC6Be9v+1oPrw/00KMe6nJxrgtyIbvw8yMEPZR91sNRF3iP2uAdh7bAOp8MjvejPou3zfsTJg8WBPaCHoYF0sNHnOPtDMWe4e0aDtj+jbnAd4xd7ybxfvxZ6q/1hJjeTfaS3okUZ+ty8aGwcfYt5vOHOtVHtM9z3AXu4+z6OIXj/hepv9bFY/o41Uv6aICh6/qoy8VxSfx9nmh/fMyl/MxRcDkN/TbIT3ujJ3bfgRyxy9EFqff2Vxxxgc8Rdv6dxvH5ThD+3YsEwr/TovBvEuIM1A50fuV2qDf8o+9grqUb8wMSgX8/gFjddCilxH5+JY23RgR5HqHj/QlHvN3K37gHPEKseEyR8bjRR/JnZyfChvs42YmjLvA/ym4nZnD8C/0dN88M4mZvdqEg2PNp1F50uC3r+bdOfhvr89RjLnA/xq6Pszjuq/2tj7MDffSmj6tCz2MtMZ+PLer5H7TD063nf9ges24Zt3Wpu+d/JAx+nWwzv0/jvy3O58OVBeG/1cF5GkLxny4XpwTgP/Q57TxW1vdGdHr+XHJw/pxQ6yx0+UxLvbG/isXOxhjtbBaTM9r5xbS4Wj8O6oTFvh7WwHFe6LI9jWPzRrRzcpGxTTjoKes52vg+fPQ8gbL93tLumCTmuc+jnPQXnfusUvAZgST6cykkV/VA5CpHlascBbdxAeWKp9+C4vnmPkqFIo7PEc585S5u8/88I5q8zgUir3mqvOYp8hoXUF55+jG6vuqP5LSGF0n4HAeMe82PocndciByt0CVuwWK3J0QVO4k2V+5o8UZJ4ELK0qzWVxXCnW1rjQJOJ2Uur8vkbQe2Shvncjjj+Eg5HGRKo+LFHlMcJZHUffpYfZ7DcfptND2e4H5vYkknCOEOK/T5+K09U9nIAbU7c6+8hdKtWpzo6I0yPJ5Bp63dmOff0hi34dH0/NsIHbnJlXPb1L0/ONfud1B81tP1E1lrdBUXyiFYqNRfI7jdLaLzzvd7gNlsTOvh4KQv1tU+btFkb9znOVvAnjtYJ0F4LEL+piJ2M9HRAWZjzgv8X0PFc0OZx3sg0zR802Kfajb2GGn906FDfdD84m31ep9pdHUOscWj18A29Lt9UadxuOk8ZJtxitu4BrW8Qr5MF5hh/EagzraeBH14CL4YLz9ANlh3pJ2RTzgHOaAM+KbxxS+udSF52thwvqbOQd7lzB8ZvTDEgbcjfxPs4+7w0HYxyWqfVyi4D7B2T7i72vOYPNzr0CQElFv8h+UnaS9r/EyZ/xoeNDe5yN7jKOc8KDp8aeC+A1+nv8SYsCjRMHjSpfid5q997qO0e28ccIDzmEGnNcoOH8m8d3XZcQZzdtFJfI5A0GPg90+86SHcYgwjANt39jnnO14hiLvwxgfBD0udvFy1NBO3B8oy+bc7TqHn7D6p6APbav/QG2V22+MTsI9cb8A1cDH8W9dmJ8l2Xcc1xnQdWp8gjqU0v/RC2pVwubTaeMkET5H7cm6HJ9VrN4u5h+bW9e2ExdsxgfrjqV9m5zH6zLMrTiOg8HPNPrFaJ/aWzRPGTHjebAuSPbm3+H+84oDn80b+OsS2zik5gnj8Bz6yWscvOoDK86yzzjnPOCcI+D8os9wDvmMc94DznkCzn/vM5zDPuO84AHnBQLO/+gRnPF277nEM0vBE/e70HMT3N3C75+B7/HCbQXs9zLmF2RAgTdBwLbBnr2Jmh3SJXAwVmBD8PYoJrdY/2Kc5zMmOa9DpPV7hNH++DVvMSVAv3VRectoD/yan5iGOfBefx5BwjNkwDPMaR5iRuL73lXSPIQx/iXhEjbgEuE0LzArwLyAm/PnnPTTr/e+INyeUHC7KvL8Yc55fiTHiKdf76NAeK5T8Lwm9cd6aCe+8+s9AwjPMgXPOUms9bpOfOfXueRO6yeuS+21pL1y3qaTfvp1jjTC7SkFtxuc/TBX88Eu+I5LnJSjxkk5/P5fcI6T8Pm+uGx2bPdCYsU9X/5K457fC9LvUc5xT1aw8eYVn8xz7vf/AwAA//9HHqQXiKIAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
