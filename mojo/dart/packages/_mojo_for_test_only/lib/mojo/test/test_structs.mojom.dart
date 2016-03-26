// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library test_structs_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:_mojo_for_test_only/mojo/test/rect.mojom.dart' as rect_mojom;



class StructOfStructs extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  NamedRegion nr = null;
  List<NamedRegion> aNr = null;
  List<RectPair> aRp = null;
  Map<int, NoDefaultFieldValues> mNdfv = null;
  Map<int, HandleStruct> mHs = null;

  StructOfStructs() : super(kVersions.last.size);

  static StructOfStructs deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructOfStructs decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructOfStructs result = new StructOfStructs();

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
      result.nr = NamedRegion.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.aNr = new List<NamedRegion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.aNr[i1] = NamedRegion.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.aRp = new List<RectPair>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.aRp[i1] = RectPair.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<NoDefaultFieldValues> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<NoDefaultFieldValues>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              values0[i2] = NoDefaultFieldValues.decode(decoder3);
            }
          }
        }
        result.mNdfv = new Map<int, NoDefaultFieldValues>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<HandleStruct> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<HandleStruct>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              values0[i2] = HandleStruct.decode(decoder3);
            }
          }
        }
        result.mHs = new Map<int, HandleStruct>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(nr, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nr of struct StructOfStructs: $e";
      rethrow;
    }
    try {
      if (aNr == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(aNr.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < aNr.length; ++i0) {
          encoder1.encodeStruct(aNr[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "aNr of struct StructOfStructs: $e";
      rethrow;
    }
    try {
      if (aRp == null) {
        encoder0.encodeNullPointer(24, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(aRp.length, 24, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < aRp.length; ++i0) {
          encoder1.encodeStruct(aRp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "aRp of struct StructOfStructs: $e";
      rethrow;
    }
    try {
      if (mNdfv == null) {
        encoder0.encodeNullPointer(32, false);
      } else {
        var encoder1 = encoder0.encoderForMap(32);
        var keys0 = mNdfv.keys.toList();
        var values0 = mNdfv.values.toList();
        encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mNdfv of struct StructOfStructs: $e";
      rethrow;
    }
    try {
      if (mHs == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encoderForMap(40);
        var keys0 = mHs.keys.toList();
        var values0 = mHs.values.toList();
        encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mHs of struct StructOfStructs: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructOfStructs("
           "nr: $nr" ", "
           "aNr: $aNr" ", "
           "aRp: $aRp" ", "
           "mNdfv: $mNdfv" ", "
           "mHs: $mHs" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NamedRegion extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String name = null;
  List<rect_mojom.Rect> rects = null;

  NamedRegion() : super(kVersions.last.size);

  static NamedRegion deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NamedRegion decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NamedRegion result = new NamedRegion();

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
      
      result.name = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.rects = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.rects = new List<rect_mojom.Rect>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.rects[i1] = rect_mojom.Rect.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(name, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct NamedRegion: $e";
      rethrow;
    }
    try {
      if (rects == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(rects.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < rects.length; ++i0) {
          encoder1.encodeStruct(rects[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rects of struct NamedRegion: $e";
      rethrow;
    }
  }

  String toString() {
    return "NamedRegion("
           "name: $name" ", "
           "rects: $rects" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    map["rects"] = rects;
    return map;
  }
}


class RectPair extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  rect_mojom.Rect first = null;
  rect_mojom.Rect second = null;

  RectPair() : super(kVersions.last.size);

  static RectPair deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RectPair decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RectPair result = new RectPair();

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
      result.first = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.second = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(first, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "first of struct RectPair: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(second, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "second of struct RectPair: $e";
      rethrow;
    }
  }

  String toString() {
    return "RectPair("
           "first: $first" ", "
           "second: $second" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["first"] = first;
    map["second"] = second;
    return map;
  }
}


class EmptyStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  EmptyStruct() : super(kVersions.last.size);

  static EmptyStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EmptyStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EmptyStruct result = new EmptyStruct();

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
    return "EmptyStruct("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class HandleStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoMessagePipeEndpoint h = null;
  List<core.MojoMessagePipeEndpoint> arrayH = null;

  HandleStruct() : super(kVersions.last.size);

  static HandleStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HandleStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HandleStruct result = new HandleStruct();

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
      
      result.h = decoder0.decodeMessagePipeHandle(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.arrayH = decoder0.decodeMessagePipeHandleArray(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(h, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "h of struct HandleStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandleArray(arrayH, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "arrayH of struct HandleStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "HandleStruct("
           "h: $h" ", "
           "arrayH: $arrayH" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NullableHandleStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint h = null;
  int data = 1234;

  NullableHandleStruct() : super(kVersions.last.size);

  static NullableHandleStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NullableHandleStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NullableHandleStruct result = new NullableHandleStruct();

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
      
      result.h = decoder0.decodeMessagePipeHandle(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.data = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(h, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "h of struct NullableHandleStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(data, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct NullableHandleStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "NullableHandleStruct("
           "h: $h" ", "
           "data: $data" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NoDefaultFieldValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(160, 0)
  ];
  bool f0 = false;
  int f1 = 0;
  int f2 = 0;
  int f3 = 0;
  int f4 = 0;
  int f5 = 0;
  int f6 = 0;
  int f7 = 0;
  int f8 = 0;
  double f9 = 0.0;
  core.MojoMessagePipeEndpoint f13 = null;
  double f10 = 0.0;
  String f11 = null;
  String f12 = null;
  core.MojoDataPipeConsumer f14 = null;
  core.MojoDataPipeProducer f15 = null;
  core.MojoMessagePipeEndpoint f16 = null;
  core.MojoDataPipeConsumer f17 = null;
  core.MojoDataPipeProducer f18 = null;
  core.MojoHandle f19 = null;
  core.MojoHandle f20 = null;
  core.MojoSharedBuffer f21 = null;
  core.MojoSharedBuffer f22 = null;
  List<String> f23 = null;
  List<String> f24 = null;
  List<String> f25 = null;
  List<String> f26 = null;
  EmptyStruct f27 = null;
  EmptyStruct f28 = null;

  NoDefaultFieldValues() : super(kVersions.last.size);

  static NoDefaultFieldValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NoDefaultFieldValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NoDefaultFieldValues result = new NoDefaultFieldValues();

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
      
      result.f0 = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeMessagePipeHandle(44, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeString(56, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeString(64, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeConsumerHandle(72, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f15 = decoder0.decodeProducerHandle(76, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f16 = decoder0.decodeMessagePipeHandle(80, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f17 = decoder0.decodeConsumerHandle(84, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f18 = decoder0.decodeProducerHandle(88, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f19 = decoder0.decodeHandle(92, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f20 = decoder0.decodeHandle(96, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f21 = decoder0.decodeSharedBufferHandle(100, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f22 = decoder0.decodeSharedBufferHandle(104, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(112, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f23 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f23[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(120, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f24 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f24[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(128, true);
      if (decoder1 == null) {
        result.f25 = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f25 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f25[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(136, true);
      if (decoder1 == null) {
        result.f26 = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f26 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f26[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(144, false);
      result.f27 = EmptyStruct.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(152, true);
      result.f28 = EmptyStruct.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(f0, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(f2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f3, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f4, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f5, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f6, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f7, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f8, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f9, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(f13, 44, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f13 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f10, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(f11, 56, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(f12, 64, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f12 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(f14, 72, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f14 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeProducerHandle(f15, 76, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f15 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(f16, 80, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f16 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(f17, 84, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f17 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeProducerHandle(f18, 88, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f18 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeHandle(f19, 92, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f19 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeHandle(f20, 96, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f20 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeSharedBufferHandle(f21, 100, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f21 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeSharedBufferHandle(f22, 104, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f22 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      if (f23 == null) {
        encoder0.encodeNullPointer(112, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f23.length, 112, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f23.length; ++i0) {
          encoder1.encodeString(f23[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f23 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      if (f24 == null) {
        encoder0.encodeNullPointer(120, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f24.length, 120, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f24.length; ++i0) {
          encoder1.encodeString(f24[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, true);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f24 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      if (f25 == null) {
        encoder0.encodeNullPointer(128, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(f25.length, 128, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f25.length; ++i0) {
          encoder1.encodeString(f25[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f25 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      if (f26 == null) {
        encoder0.encodeNullPointer(136, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(f26.length, 136, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f26.length; ++i0) {
          encoder1.encodeString(f26[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, true);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f26 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(f27, 144, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f27 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(f28, 152, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f28 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "NoDefaultFieldValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f13: $f13" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ", "
           "f17: $f17" ", "
           "f18: $f18" ", "
           "f19: $f19" ", "
           "f20: $f20" ", "
           "f21: $f21" ", "
           "f22: $f22" ", "
           "f23: $f23" ", "
           "f24: $f24" ", "
           "f25: $f25" ", "
           "f26: $f26" ", "
           "f27: $f27" ", "
           "f28: $f28" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DefaultFieldValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(96, 0)
  ];
  static const String kFoo = "foo";
  bool f0 = true;
  int f1 = 100;
  int f2 = 100;
  int f3 = 100;
  int f4 = 100;
  int f5 = 100;
  int f6 = 100;
  int f7 = 100;
  int f8 = 100;
  double f9 = 100;
  double f10 = 100.0;
  double f11 = 100;
  double f12 = 100.0;
  String f13 = "foo";
  String f14 = "foo";
  rect_mojom.Rect f15 = new rect_mojom.Rect();
  rect_mojom.Rect f16 = new rect_mojom.Rect();

  DefaultFieldValues() : super(kVersions.last.size);

  static DefaultFieldValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DefaultFieldValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DefaultFieldValues result = new DefaultFieldValues();

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
      
      result.f0 = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeString(64, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeString(72, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      result.f15 = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, true);
      result.f16 = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(f0, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(f2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f3, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f4, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f5, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f6, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f7, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f8, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f9, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f10, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f11, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f12, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f12 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(f13, 64, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f13 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(f14, 72, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f14 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(f15, 80, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f15 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(f16, 88, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f16 of struct DefaultFieldValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "DefaultFieldValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f13: $f13" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    map["f12"] = f12;
    map["f13"] = f13;
    map["f14"] = f14;
    map["f15"] = f15;
    map["f16"] = f16;
    return map;
  }
}


class ScopedConstantsEType extends bindings.MojoEnum {
  static const ScopedConstantsEType e0 = const ScopedConstantsEType._(0);
  static const ScopedConstantsEType e1 = const ScopedConstantsEType._(1);
  static const ScopedConstantsEType e2 = const ScopedConstantsEType._(10);
  static const ScopedConstantsEType e3 = const ScopedConstantsEType._(10);
  static const ScopedConstantsEType e4 = const ScopedConstantsEType._(11);

  const ScopedConstantsEType._(int v) : super(v);

  static const Map<String, ScopedConstantsEType> valuesMap = const {
    "e0": e0,
    "e1": e1,
    "e2": e2,
    "e3": e3,
    "e4": e4,
  };
  static const List<ScopedConstantsEType> values = const [
    e0,
    e1,
    e2,
    e3,
    e4,
  ];

  static ScopedConstantsEType valueOf(String name) => valuesMap[name];

  factory ScopedConstantsEType(int v) {
    switch (v) {
      case 0:
        return ScopedConstantsEType.e0;
      case 1:
        return ScopedConstantsEType.e1;
      case 10:
        return ScopedConstantsEType.e2;
      case 10:
        return ScopedConstantsEType.e3;
      case 11:
        return ScopedConstantsEType.e4;
      default:
        return null;
    }
  }

  static ScopedConstantsEType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ScopedConstantsEType result = new ScopedConstantsEType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ScopedConstantsEType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case e0:
        return 'ScopedConstantsEType.e0';
      case e1:
        return 'ScopedConstantsEType.e1';
      case e2:
        return 'ScopedConstantsEType.e2';
      case e3:
        return 'ScopedConstantsEType.e3';
      case e4:
        return 'ScopedConstantsEType.e4';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class ScopedConstants extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  static const int ten = 10;
  static const int alsoTen = 10;
  ScopedConstantsEType f0 = new ScopedConstantsEType(0);
  ScopedConstantsEType f1 = new ScopedConstantsEType(1);
  ScopedConstantsEType f2 = new ScopedConstantsEType(10);
  ScopedConstantsEType f3 = new ScopedConstantsEType(10);
  ScopedConstantsEType f4 = new ScopedConstantsEType(11);
  int f5 = 10;
  int f6 = 10;

  ScopedConstants() : super(kVersions.last.size);

  static ScopedConstants deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ScopedConstants decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ScopedConstants result = new ScopedConstants();

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
      
        result.f0 = ScopedConstantsEType.decode(decoder0, 8);
        if (result.f0 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f1 = ScopedConstantsEType.decode(decoder0, 12);
        if (result.f1 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f2 = ScopedConstantsEType.decode(decoder0, 16);
        if (result.f2 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f3 = ScopedConstantsEType.decode(decoder0, 20);
        if (result.f3 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f4 = ScopedConstantsEType.decode(decoder0, 24);
        if (result.f4 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeInt32(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(f0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(f1, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(f2, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(f3, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(f4, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f5, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f6, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct ScopedConstants: $e";
      rethrow;
    }
  }

  String toString() {
    return "ScopedConstants("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    return map;
  }
}


class MapKeyTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(104, 0)
  ];
  Map<bool, bool> f0 = null;
  Map<int, int> f1 = null;
  Map<int, int> f2 = null;
  Map<int, int> f3 = null;
  Map<int, int> f4 = null;
  Map<int, int> f5 = null;
  Map<int, int> f6 = null;
  Map<int, int> f7 = null;
  Map<int, int> f8 = null;
  Map<double, double> f9 = null;
  Map<double, double> f10 = null;
  Map<String, String> f11 = null;

  MapKeyTypes() : super(kVersions.last.size);

  static MapKeyTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MapKeyTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MapKeyTypes result = new MapKeyTypes();

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
        List<bool> keys0;
        List<bool> values0;
        {
          
          keys0 = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f0 = new Map<bool, bool>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt8Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f1 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f2 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt16Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt16Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f3 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint16Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint16Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f4 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt32Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f5 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f6 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(64, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f7 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(72, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint64Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f8 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<double> keys0;
        List<double> values0;
        {
          
          keys0 = decoder1.decodeFloatArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeFloatArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f9 = new Map<double, double>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<double> keys0;
        List<double> values0;
        {
          
          keys0 = decoder1.decodeDoubleArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeDoubleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f10 = new Map<double, double>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(96, false);
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
        result.f11 = new Map<String, String>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (f0 == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encoderForMap(8);
        var keys0 = f0.keys.toList();
        var values0 = f0.values.toList();
        encoder1.encodeBoolArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeBoolArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f1 == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encoderForMap(16);
        var keys0 = f1.keys.toList();
        var values0 = f1.values.toList();
        encoder1.encodeInt8Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeInt8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f2 == null) {
        encoder0.encodeNullPointer(24, false);
      } else {
        var encoder1 = encoder0.encoderForMap(24);
        var keys0 = f2.keys.toList();
        var values0 = f2.values.toList();
        encoder1.encodeUint8Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeUint8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f3 == null) {
        encoder0.encodeNullPointer(32, false);
      } else {
        var encoder1 = encoder0.encoderForMap(32);
        var keys0 = f3.keys.toList();
        var values0 = f3.values.toList();
        encoder1.encodeInt16Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeInt16Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f4 == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encoderForMap(40);
        var keys0 = f4.keys.toList();
        var values0 = f4.values.toList();
        encoder1.encodeUint16Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeUint16Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f5 == null) {
        encoder0.encodeNullPointer(48, false);
      } else {
        var encoder1 = encoder0.encoderForMap(48);
        var keys0 = f5.keys.toList();
        var values0 = f5.values.toList();
        encoder1.encodeInt32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeInt32Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f6 == null) {
        encoder0.encodeNullPointer(56, false);
      } else {
        var encoder1 = encoder0.encoderForMap(56);
        var keys0 = f6.keys.toList();
        var values0 = f6.values.toList();
        encoder1.encodeUint32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeUint32Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f7 == null) {
        encoder0.encodeNullPointer(64, false);
      } else {
        var encoder1 = encoder0.encoderForMap(64);
        var keys0 = f7.keys.toList();
        var values0 = f7.values.toList();
        encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeInt64Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f8 == null) {
        encoder0.encodeNullPointer(72, false);
      } else {
        var encoder1 = encoder0.encoderForMap(72);
        var keys0 = f8.keys.toList();
        var values0 = f8.values.toList();
        encoder1.encodeUint64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeUint64Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f9 == null) {
        encoder0.encodeNullPointer(80, false);
      } else {
        var encoder1 = encoder0.encoderForMap(80);
        var keys0 = f9.keys.toList();
        var values0 = f9.values.toList();
        encoder1.encodeFloatArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeFloatArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f10 == null) {
        encoder0.encodeNullPointer(88, false);
      } else {
        var encoder1 = encoder0.encoderForMap(88);
        var keys0 = f10.keys.toList();
        var values0 = f10.values.toList();
        encoder1.encodeDoubleArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeDoubleArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f11 == null) {
        encoder0.encodeNullPointer(96, false);
      } else {
        var encoder1 = encoder0.encoderForMap(96);
        var keys0 = f11.keys.toList();
        var values0 = f11.values.toList();
        
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
          "f11 of struct MapKeyTypes: $e";
      rethrow;
    }
  }

  String toString() {
    return "MapKeyTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    return map;
  }
}


class MapValueTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(104, 0)
  ];
  Map<String, List<String>> f0 = null;
  Map<String, List<String>> f1 = null;
  Map<String, List<String>> f2 = null;
  Map<String, List<String>> f3 = null;
  Map<String, List<List<String>>> f4 = null;
  Map<String, List<List<String>>> f5 = null;
  Map<String, rect_mojom.Rect> f6 = null;
  Map<String, Map<String, String>> f7 = null;
  Map<String, List<Map<String, String>>> f8 = null;
  Map<String, core.MojoHandle> f9 = null;
  Map<String, List<core.MojoHandle>> f10 = null;
  Map<String, Map<String, core.MojoHandle>> f11 = null;

  MapValueTypes() : super(kVersions.last.size);

  static MapValueTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MapValueTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MapValueTypes result = new MapValueTypes();

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
        List<List<String>> values0;
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
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f0 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
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
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              if (decoder3 == null) {
                values0[i2] = null;
              } else {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f1 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
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
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, true);
                }
              }
            }
          }
        }
        result.f2 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
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
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(2);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f3 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<List<String>>> values0;
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
            values0 = new List<List<List<String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<List<String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, true);
                  if (decoder4 == null) {
                    values0[i2][i3] = null;
                  } else {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(2);
                    values0[i2][i3] = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values0[i2][i3][i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
              }
            }
          }
        }
        result.f4 = new Map<String, List<List<String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<List<String>>> values0;
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
            values0 = new List<List<List<String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(1);
                values0[i2] = new List<List<String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(2);
                    values0[i2][i3] = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values0[i2][i3][i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
              }
            }
          }
        }
        result.f5 = new Map<String, List<List<String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<rect_mojom.Rect> values0;
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
            values0 = new List<rect_mojom.Rect>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              values0[i2] = rect_mojom.Rect.decode(decoder3);
            }
          }
        }
        result.f6 = new Map<String, rect_mojom.Rect>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(64, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<Map<String, String>> values0;
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
            values0 = new List<Map<String, String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                decoder3.decodeDataHeaderForMap();
                List<String> keys2;
                List<String> values2;
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                    keys2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      keys2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(keys2.length);
                    values2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                values0[i2] = new Map<String, String>.fromIterables(
                    keys2, values2);
              }
            }
          }
        }
        result.f7 = new Map<String, Map<String, String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(72, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<Map<String, String>>> values0;
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
            values0 = new List<List<Map<String, String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<Map<String, String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  {
                    decoder4.decodeDataHeaderForMap();
                    List<String> keys3;
                    List<String> values3;
                    {
                      
                      var decoder5 = decoder4.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                      {
                        var si5 = decoder5.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                        keys3 = new List<String>(si5.numElements);
                        for (int i5 = 0; i5 < si5.numElements; ++i5) {
                          
                          keys3[i5] = decoder5.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i5, false);
                        }
                      }
                    }
                    {
                      
                      var decoder5 = decoder4.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
                      {
                        var si5 = decoder5.decodeDataHeaderForPointerArray(keys3.length);
                        values3 = new List<String>(si5.numElements);
                        for (int i5 = 0; i5 < si5.numElements; ++i5) {
                          
                          values3[i5] = decoder5.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i5, false);
                        }
                      }
                    }
                    values0[i2][i3] = new Map<String, String>.fromIterables(
                        keys3, values3);
                  }
                }
              }
            }
          }
        }
        result.f8 = new Map<String, List<Map<String, String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<core.MojoHandle> values0;
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
          
          values0 = decoder1.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f9 = new Map<String, core.MojoHandle>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<core.MojoHandle>> values0;
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
            values0 = new List<List<core.MojoHandle>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              values0[i2] = decoder2.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
            }
          }
        }
        result.f10 = new Map<String, List<core.MojoHandle>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(96, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<Map<String, core.MojoHandle>> values0;
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
            values0 = new List<Map<String, core.MojoHandle>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                decoder3.decodeDataHeaderForMap();
                List<String> keys2;
                List<core.MojoHandle> values2;
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                    keys2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      keys2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                {
                  
                  values2 = decoder3.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys2.length);
                }
                values0[i2] = new Map<String, core.MojoHandle>.fromIterables(
                    keys2, values2);
              }
            }
          }
        }
        result.f11 = new Map<String, Map<String, core.MojoHandle>>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (f0 == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encoderForMap(8);
        var keys0 = f0.keys.toList();
        var values0 = f0.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f1 == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encoderForMap(16);
        var keys0 = f1.keys.toList();
        var values0 = f1.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f2 == null) {
        encoder0.encodeNullPointer(24, false);
      } else {
        var encoder1 = encoder0.encoderForMap(24);
        var keys0 = f2.keys.toList();
        var values0 = f2.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f3 == null) {
        encoder0.encodeNullPointer(32, false);
      } else {
        var encoder1 = encoder0.encoderForMap(32);
        var keys0 = f3.keys.toList();
        var values0 = f3.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, 2);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f4 == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encoderForMap(40);
        var keys0 = f4.keys.toList();
        var values0 = f4.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                if (values0[i1][i2] == null) {
                  encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
                } else {
                  var encoder4 = encoder3.encodePointerArray(values0[i1][i2].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, 2);
                  for (int i3 = 0; i3 < values0[i1][i2].length; ++i3) {
                    encoder4.encodeString(values0[i1][i2][i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  }
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f5 == null) {
        encoder0.encodeNullPointer(48, false);
      } else {
        var encoder1 = encoder0.encoderForMap(48);
        var keys0 = f5.keys.toList();
        var values0 = f5.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, 1);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                if (values0[i1][i2] == null) {
                  encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                } else {
                  var encoder4 = encoder3.encodePointerArray(values0[i1][i2].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, 2);
                  for (int i3 = 0; i3 < values0[i1][i2].length; ++i3) {
                    encoder4.encodeString(values0[i1][i2][i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  }
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f6 == null) {
        encoder0.encodeNullPointer(56, false);
      } else {
        var encoder1 = encoder0.encoderForMap(56);
        var keys0 = f6.keys.toList();
        var values0 = f6.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f7 == null) {
        encoder0.encodeNullPointer(64, false);
      } else {
        var encoder1 = encoder0.encoderForMap(64);
        var keys0 = f7.keys.toList();
        var values0 = f7.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1);
              var keys2 = values0[i1].keys.toList();
              var values2 = values0[i1].values.toList();
              
              {
                var encoder4 = encoder3.encodePointerArray(keys2.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
                for (int i3 = 0; i3 < keys2.length; ++i3) {
                  encoder4.encodeString(keys2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
              
              {
                var encoder4 = encoder3.encodePointerArray(values2.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
                for (int i3 = 0; i3 < values2.length; ++i3) {
                  encoder4.encodeString(values2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f8 == null) {
        encoder0.encodeNullPointer(72, false);
      } else {
        var encoder1 = encoder0.encoderForMap(72);
        var keys0 = f8.keys.toList();
        var values0 = f8.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                if (values0[i1][i2] == null) {
                  encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                } else {
                  var encoder4 = encoder3.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2);
                  var keys3 = values0[i1][i2].keys.toList();
                  var values3 = values0[i1][i2].values.toList();
                  
                  {
                    var encoder5 = encoder4.encodePointerArray(keys3.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
                    for (int i4 = 0; i4 < keys3.length; ++i4) {
                      encoder5.encodeString(keys3[i4], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                  
                  {
                    var encoder5 = encoder4.encodePointerArray(values3.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
                    for (int i4 = 0; i4 < values3.length; ++i4) {
                      encoder5.encodeString(values3[i4], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f9 == null) {
        encoder0.encodeNullPointer(80, false);
      } else {
        var encoder1 = encoder0.encoderForMap(80);
        var keys0 = f9.keys.toList();
        var values0 = f9.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        encoder1.encodeHandleArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f10 == null) {
        encoder0.encodeNullPointer(88, false);
      } else {
        var encoder1 = encoder0.encoderForMap(88);
        var keys0 = f10.keys.toList();
        var values0 = f10.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeHandleArray(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f11 == null) {
        encoder0.encodeNullPointer(96, false);
      } else {
        var encoder1 = encoder0.encoderForMap(96);
        var keys0 = f11.keys.toList();
        var values0 = f11.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1);
              var keys2 = values0[i1].keys.toList();
              var values2 = values0[i1].values.toList();
              
              {
                var encoder4 = encoder3.encodePointerArray(keys2.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
                for (int i3 = 0; i3 < keys2.length; ++i3) {
                  encoder4.encodeString(keys2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
              encoder3.encodeHandleArray(values2, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct MapValueTypes: $e";
      rethrow;
    }
  }

  String toString() {
    return "MapValueTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ArrayValueTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  List<int> f0 = null;
  List<int> f1 = null;
  List<int> f2 = null;
  List<int> f3 = null;
  List<double> f4 = null;
  List<double> f5 = null;

  ArrayValueTypes() : super(kVersions.last.size);

  static ArrayValueTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ArrayValueTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ArrayValueTypes result = new ArrayValueTypes();

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
      
      result.f0 = decoder0.decodeInt8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt16Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeInt32Array(24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt64Array(32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeFloatArray(40, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeDoubleArray(48, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt8Array(f0, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16Array(f1, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32Array(f2, 24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64Array(f3, 32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloatArray(f4, 40, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeDoubleArray(f5, 48, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct ArrayValueTypes: $e";
      rethrow;
    }
  }

  String toString() {
    return "ArrayValueTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    return map;
  }
}


class FloatNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(72, 0)
  ];
  static const double v0 = double.INFINITY;
  static const double v1 = double.NEGATIVE_INFINITY;
  static const double v2 = double.NAN;
  static const double v3 = double.INFINITY;
  static const double v4 = double.NEGATIVE_INFINITY;
  static const double v5 = double.NAN;
  static const double v6 = 0.0;
  static const double v7 = 1234567890.123;
  static const double v8 = 1.2e+20;
  static const double v9 = -1.2e+20;
  double f0 = double.INFINITY;
  double f1 = double.NEGATIVE_INFINITY;
  double f2 = double.NAN;
  double f3 = double.INFINITY;
  double f4 = double.NEGATIVE_INFINITY;
  double f5 = double.NAN;
  double f6 = 0.0;
  double f7 = 1234567890.123;
  double f8 = 1.2e+20;
  double f9 = -1.2e+20;

  FloatNumberValues() : super(kVersions.last.size);

  static FloatNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FloatNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FloatNumberValues result = new FloatNumberValues();

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
      
      result.f0 = decoder0.decodeDouble(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeDouble(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeDouble(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeFloat(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeFloat(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeDouble(64);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(f0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f1, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f2, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f3, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f4, 36);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f5, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f6, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f7, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f8, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f9, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct FloatNumberValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "FloatNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    return map;
  }
}


class IntegerNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(88, 0)
  ];
  static const int v0 = -128;
  static const int v1 = -1;
  static const int v2 = 0;
  static const int v3 = 42;
  static const int v4 = 127;
  static const int v5 = -32768;
  static const int v6 = -1;
  static const int v7 = 0;
  static const int v8 = 12345;
  static const int v9 = 32767;
  static const int v10 = -2147483648;
  static const int v11 = -1;
  static const int v12 = 0;
  static const int v13 = 1234567890;
  static const int v14 = 2147483647;
  static const int v15 = -9007199254740991;
  static const int v16 = -1;
  static const int v17 = 0;
  static const int v18 = 1234567890123456;
  static const int v19 = 9007199254740991;
  int f0 = -128;
  int f1 = -1;
  int f2 = 0;
  int f3 = 42;
  int f4 = 127;
  int f5 = -32768;
  int f6 = -1;
  int f7 = 0;
  int f8 = 12345;
  int f9 = 32767;
  int f10 = -2147483648;
  int f11 = -1;
  int f12 = 0;
  int f13 = 1234567890;
  int f14 = 2147483647;
  int f15 = -9007199254740991;
  int f16 = -1;
  int f17 = 0;
  int f18 = 1234567890123456;
  int f19 = 9007199254740991;

  IntegerNumberValues() : super(kVersions.last.size);

  static IntegerNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IntegerNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IntegerNumberValues result = new IntegerNumberValues();

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
      
      result.f0 = decoder0.decodeInt8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeInt8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt8(11);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeInt8(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeInt16(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt16(18);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeInt16(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeInt16(22);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeInt32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeInt32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeInt32(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeInt32(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeInt32(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f15 = decoder0.decodeInt64(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f16 = decoder0.decodeInt64(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f17 = decoder0.decodeInt64(64);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f18 = decoder0.decodeInt64(72);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f19 = decoder0.decodeInt64(80);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt8(f0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f3, 11);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f4, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f5, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f6, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f7, 18);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f8, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f9, 22);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f10, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f11, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f12, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f12 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f13, 36);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f13 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f14, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f14 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f15, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f15 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f16, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f16 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f17, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f17 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f18, 72);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f18 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f19, 80);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f19 of struct IntegerNumberValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "IntegerNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f13: $f13" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ", "
           "f17: $f17" ", "
           "f18: $f18" ", "
           "f19: $f19" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    map["f12"] = f12;
    map["f13"] = f13;
    map["f14"] = f14;
    map["f15"] = f15;
    map["f16"] = f16;
    map["f17"] = f17;
    map["f18"] = f18;
    map["f19"] = f19;
    return map;
  }
}


class UnsignedNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  static const int v0 = 0;
  static const int v1 = 42;
  static const int v2 = 255;
  static const int v3 = 0;
  static const int v4 = 12345;
  static const int v5 = 65535;
  static const int v6 = 0;
  static const int v7 = 1234567890;
  static const int v8 = 4294967295;
  static const int v9 = 0;
  static const int v10 = 1234567890123456;
  static const int v11 = 9007199254740991;
  int f0 = 0;
  int f1 = 42;
  int f2 = 255;
  int f3 = 0;
  int f4 = 12345;
  int f5 = 65535;
  int f6 = 0;
  int f7 = 1234567890;
  int f8 = 4294967295;
  int f9 = 0;
  int f10 = 1234567890123456;
  int f11 = 9007199254740991;

  UnsignedNumberValues() : super(kVersions.last.size);

  static UnsignedNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UnsignedNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UnsignedNumberValues result = new UnsignedNumberValues();

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
      
      result.f0 = decoder0.decodeUint8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeUint8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeUint16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeUint16(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeUint64(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeUint64(48);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8(f0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(f1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(f2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f3, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f4, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f5, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f6, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f7, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f8, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f9, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f10, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f11, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct UnsignedNumberValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "UnsignedNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    return map;
  }
}


class BitArrayValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(64, 0)
  ];
  List<bool> f0 = null;
  List<bool> f1 = null;
  List<bool> f2 = null;
  List<bool> f3 = null;
  List<List<bool>> f4 = null;
  List<List<bool>> f5 = null;
  List<List<bool>> f6 = null;

  BitArrayValues() : super(kVersions.last.size);

  static BitArrayValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static BitArrayValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    BitArrayValues result = new BitArrayValues();

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
      
      result.f0 = decoder0.decodeBoolArray(8, bindings.kNothingNullable, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeBoolArray(16, bindings.kNothingNullable, 7);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeBoolArray(24, bindings.kNothingNullable, 9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeBoolArray(32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f4 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f4[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f5 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f5[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f6 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f6[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kArrayNullable, 2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBoolArray(f0, 8, bindings.kNothingNullable, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeBoolArray(f1, 16, bindings.kNothingNullable, 7);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeBoolArray(f2, 24, bindings.kNothingNullable, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeBoolArray(f3, 32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      if (f4 == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f4.length, 40, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f4.length; ++i0) {
          encoder1.encodeBoolArray(f4[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      if (f5 == null) {
        encoder0.encodeNullPointer(48, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f5.length, 48, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f5.length; ++i0) {
          encoder1.encodeBoolArray(f5[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      if (f6 == null) {
        encoder0.encodeNullPointer(56, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f6.length, 56, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f6.length; ++i0) {
          encoder1.encodeBoolArray(f6[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kArrayNullable, 2);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct BitArrayValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "BitArrayValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    return map;
  }
}


class MultiVersionStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5),
    const bindings.StructDataHeader(48, 7),
    const bindings.StructDataHeader(48, 9)
  ];
  int fInt32 = 0;
  core.MojoMessagePipeEndpoint fMessagePipe = null;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;
  bool fBool = false;
  int fInt16 = 0;

  MultiVersionStruct() : super(kVersions.last.size);

  static MultiVersionStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStruct result = new MultiVersionStruct();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fMessagePipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fBool = decoder0.decodeBool(40, 0);
    }
    if (mainDataHeader.version >= 9) {
      
      result.fInt16 = decoder0.decodeInt16(42);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(fMessagePipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fMessagePipe of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(fString, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fString of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fArray of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(fBool, 40, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fBool of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(fInt16, 42);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt16 of struct MultiVersionStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStruct("
           "fInt32: $fInt32" ", "
           "fMessagePipe: $fMessagePipe" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ", "
           "fBool: $fBool" ", "
           "fInt16: $fInt16" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class MultiVersionStructV0 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int fInt32 = 0;

  MultiVersionStructV0() : super(kVersions.last.size);

  static MultiVersionStructV0 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV0 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV0 result = new MultiVersionStructV0();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV0: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV0("
           "fInt32: $fInt32" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    return map;
  }
}


class MultiVersionStructV1 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;

  MultiVersionStructV1() : super(kVersions.last.size);

  static MultiVersionStructV1 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV1 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV1 result = new MultiVersionStructV1();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV1: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStructV1: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV1("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    return map;
  }
}


class MultiVersionStructV3 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;
  String fString = null;

  MultiVersionStructV3() : super(kVersions.last.size);

  static MultiVersionStructV3 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV3 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV3 result = new MultiVersionStructV3();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV3: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStructV3: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(fString, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fString of struct MultiVersionStructV3: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV3("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    map["fString"] = fString;
    return map;
  }
}


class MultiVersionStructV5 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;

  MultiVersionStructV5() : super(kVersions.last.size);

  static MultiVersionStructV5 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV5 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV5 result = new MultiVersionStructV5();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV5: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStructV5: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(fString, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fString of struct MultiVersionStructV5: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fArray of struct MultiVersionStructV5: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV5("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    map["fString"] = fString;
    map["fArray"] = fArray;
    return map;
  }
}


class MultiVersionStructV7 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5),
    const bindings.StructDataHeader(48, 7)
  ];
  int fInt32 = 0;
  core.MojoMessagePipeEndpoint fMessagePipe = null;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;
  bool fBool = false;

  MultiVersionStructV7() : super(kVersions.last.size);

  static MultiVersionStructV7 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV7 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV7 result = new MultiVersionStructV7();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fMessagePipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fBool = decoder0.decodeBool(40, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(fMessagePipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fMessagePipe of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(fString, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fString of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fArray of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(fBool, 40, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fBool of struct MultiVersionStructV7: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV7("
           "fInt32: $fInt32" ", "
           "fMessagePipe: $fMessagePipe" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ", "
           "fBool: $fBool" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ContainsInterface extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object someInterface = null;

  ContainsInterface() : super(kVersions.last.size);

  static ContainsInterface deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsInterface decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsInterface result = new ContainsInterface();

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
      
      result.someInterface = decoder0.decodeServiceInterface(8, false, SomeInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(someInterface, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "someInterface of struct ContainsInterface: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContainsInterface("
           "someInterface: $someInterface" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ContainsOther extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int other = 0;

  ContainsOther() : super(kVersions.last.size);

  static ContainsOther deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsOther decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsOther result = new ContainsOther();

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
      
      result.other = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(other, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "other of struct ContainsOther: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContainsOther("
           "other: $other" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["other"] = other;
    return map;
  }
}


class ContainsInterfaceRequest extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object req = null;
  Object nullableReq = null;

  ContainsInterfaceRequest() : super(kVersions.last.size);

  static ContainsInterfaceRequest deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsInterfaceRequest decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsInterfaceRequest result = new ContainsInterfaceRequest();

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
      
      result.req = decoder0.decodeInterfaceRequest(8, false, SomeInterfaceStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.nullableReq = decoder0.decodeInterfaceRequest(12, true, SomeInterfaceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(req, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "req of struct ContainsInterfaceRequest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(nullableReq, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nullableReq of struct ContainsInterfaceRequest: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContainsInterfaceRequest("
           "req: $req" ", "
           "nullableReq: $nullableReq" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DartKeywordStructKeywords extends bindings.MojoEnum {
  static const DartKeywordStructKeywords await_ = const DartKeywordStructKeywords._(0);
  static const DartKeywordStructKeywords is_ = const DartKeywordStructKeywords._(1);
  static const DartKeywordStructKeywords rethrow_ = const DartKeywordStructKeywords._(2);

  const DartKeywordStructKeywords._(int v) : super(v);

  static const Map<String, DartKeywordStructKeywords> valuesMap = const {
    "await_": await_,
    "is_": is_,
    "rethrow_": rethrow_,
  };
  static const List<DartKeywordStructKeywords> values = const [
    await_,
    is_,
    rethrow_,
  ];

  static DartKeywordStructKeywords valueOf(String name) => valuesMap[name];

  factory DartKeywordStructKeywords(int v) {
    switch (v) {
      case 0:
        return DartKeywordStructKeywords.await_;
      case 1:
        return DartKeywordStructKeywords.is_;
      case 2:
        return DartKeywordStructKeywords.rethrow_;
      default:
        return null;
    }
  }

  static DartKeywordStructKeywords decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    DartKeywordStructKeywords result = new DartKeywordStructKeywords(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum DartKeywordStructKeywords.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case await_:
        return 'DartKeywordStructKeywords.await_';
      case is_:
        return 'DartKeywordStructKeywords.is_';
      case rethrow_:
        return 'DartKeywordStructKeywords.rethrow_';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class DartKeywordStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  DartKeywordStructKeywords await_ = null;
  DartKeywordStructKeywords is_ = null;
  DartKeywordStructKeywords rethrow_ = null;

  DartKeywordStruct() : super(kVersions.last.size);

  static DartKeywordStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DartKeywordStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DartKeywordStruct result = new DartKeywordStruct();

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
      
        result.await_ = DartKeywordStructKeywords.decode(decoder0, 8);
        if (result.await_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.is_ = DartKeywordStructKeywords.decode(decoder0, 12);
        if (result.is_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.rethrow_ = DartKeywordStructKeywords.decode(decoder0, 16);
        if (result.rethrow_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(await_, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "await_ of struct DartKeywordStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(is_, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "is_ of struct DartKeywordStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(rethrow_, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rethrow_ of struct DartKeywordStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "DartKeywordStruct("
           "await_: $await_" ", "
           "is_: $is_" ", "
           "rethrow_: $rethrow_" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["await_"] = await_;
    map["is_"] = is_;
    map["rethrow_"] = rethrow_;
    return map;
  }
}


class _SomeInterfaceSomeMethodParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  RectPair pair = null;

  _SomeInterfaceSomeMethodParams() : super(kVersions.last.size);

  static _SomeInterfaceSomeMethodParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SomeInterfaceSomeMethodParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SomeInterfaceSomeMethodParams result = new _SomeInterfaceSomeMethodParams();

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
      result.pair = RectPair.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(pair, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pair of struct _SomeInterfaceSomeMethodParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SomeInterfaceSomeMethodParams("
           "pair: $pair" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pair"] = pair;
    return map;
  }
}


class SomeInterfaceSomeMethodResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  RectPair otherPair = null;

  SomeInterfaceSomeMethodResponseParams() : super(kVersions.last.size);

  static SomeInterfaceSomeMethodResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SomeInterfaceSomeMethodResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SomeInterfaceSomeMethodResponseParams result = new SomeInterfaceSomeMethodResponseParams();

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
      result.otherPair = RectPair.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(otherPair, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "otherPair of struct SomeInterfaceSomeMethodResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SomeInterfaceSomeMethodResponseParams("
           "otherPair: $otherPair" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["otherPair"] = otherPair;
    return map;
  }
}



enum UnionOfStructsTag {
  nr,
  aNr,
  aRp,
  mNdfv,
  mHs,
  unknown
}

class UnionOfStructs extends bindings.Union {
  static final _tagToInt = const {
    UnionOfStructsTag.nr: 0,
    UnionOfStructsTag.aNr: 1,
    UnionOfStructsTag.aRp: 2,
    UnionOfStructsTag.mNdfv: 3,
    UnionOfStructsTag.mHs: 4,
  };

  static final _intToTag = const {
    0: UnionOfStructsTag.nr,
    1: UnionOfStructsTag.aNr,
    2: UnionOfStructsTag.aRp,
    3: UnionOfStructsTag.mNdfv,
    4: UnionOfStructsTag.mHs,
  };

  var _data;
  UnionOfStructsTag _tag = UnionOfStructsTag.unknown;

  UnionOfStructsTag get tag => _tag;
  NamedRegion get nr {
    if (_tag != UnionOfStructsTag.nr) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.nr);
    }
    return _data;
  }

  set nr(NamedRegion value) {
    _tag = UnionOfStructsTag.nr;
    _data = value;
  }
  List<NamedRegion> get aNr {
    if (_tag != UnionOfStructsTag.aNr) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.aNr);
    }
    return _data;
  }

  set aNr(List<NamedRegion> value) {
    _tag = UnionOfStructsTag.aNr;
    _data = value;
  }
  List<RectPair> get aRp {
    if (_tag != UnionOfStructsTag.aRp) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.aRp);
    }
    return _data;
  }

  set aRp(List<RectPair> value) {
    _tag = UnionOfStructsTag.aRp;
    _data = value;
  }
  Map<int, NoDefaultFieldValues> get mNdfv {
    if (_tag != UnionOfStructsTag.mNdfv) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.mNdfv);
    }
    return _data;
  }

  set mNdfv(Map<int, NoDefaultFieldValues> value) {
    _tag = UnionOfStructsTag.mNdfv;
    _data = value;
  }
  Map<int, HandleStruct> get mHs {
    if (_tag != UnionOfStructsTag.mHs) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.mHs);
    }
    return _data;
  }

  set mHs(Map<int, HandleStruct> value) {
    _tag = UnionOfStructsTag.mHs;
    _data = value;
  }

  static UnionOfStructs decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    UnionOfStructs result = new UnionOfStructs();

    
    UnionOfStructsTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case UnionOfStructsTag.nr:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.nr = NamedRegion.decode(decoder1);
        break;
      case UnionOfStructsTag.aNr:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
          result.aNr = new List<NamedRegion>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            result.aNr[i1] = NamedRegion.decode(decoder2);
          }
        }
        break;
      case UnionOfStructsTag.aRp:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
          result.aRp = new List<RectPair>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            result.aRp[i1] = RectPair.decode(decoder2);
          }
        }
        break;
      case UnionOfStructsTag.mNdfv:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<int> keys0;
          List<NoDefaultFieldValues> values0;
          {
            
            keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
              values0 = new List<NoDefaultFieldValues>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                values0[i2] = NoDefaultFieldValues.decode(decoder3);
              }
            }
          }
          result.mNdfv = new Map<int, NoDefaultFieldValues>.fromIterables(
              keys0, values0);
        }
        break;
      case UnionOfStructsTag.mHs:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<int> keys0;
          List<HandleStruct> values0;
          {
            
            keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
              values0 = new List<HandleStruct>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                values0[i2] = HandleStruct.decode(decoder3);
              }
            }
          }
          result.mHs = new Map<int, HandleStruct>.fromIterables(
              keys0, values0);
        }
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
      case UnionOfStructsTag.nr:
        encoder0.encodeStruct(nr, offset + 8, false);
        break;
      case UnionOfStructsTag.aNr:
        if (aNr == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodePointerArray(aNr.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < aNr.length; ++i0) {
            encoder1.encodeStruct(aNr[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
          }
        }
        break;
      case UnionOfStructsTag.aRp:
        if (aRp == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodePointerArray(aRp.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < aRp.length; ++i0) {
            encoder1.encodeStruct(aRp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
          }
        }
        break;
      case UnionOfStructsTag.mNdfv:
        if (mNdfv == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = mNdfv.keys.toList();
          var values0 = mNdfv.values.toList();
          encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          
          {
            var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < values0.length; ++i1) {
              encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
        }
        break;
      case UnionOfStructsTag.mHs:
        if (mHs == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = mHs.keys.toList();
          var values0 = mHs.values.toList();
          encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          
          {
            var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < values0.length; ++i1) {
              encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
        }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "UnionOfStructs(";
    switch (_tag) {
      case UnionOfStructsTag.nr:
        result += "nr";
        break;
      case UnionOfStructsTag.aNr:
        result += "aNr";
        break;
      case UnionOfStructsTag.aRp:
        result += "aRp";
        break;
      case UnionOfStructsTag.mNdfv:
        result += "mNdfv";
        break;
      case UnionOfStructsTag.mHs:
        result += "mHs";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}
const int _someInterfaceMethodSomeMethodName = 0;

class _SomeInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SomeInterface {
  static const String serviceName = null;
  dynamic someMethod(RectPair pair,[Function responseFactory = null]);
}


class _SomeInterfaceProxyImpl extends bindings.Proxy {
  _SomeInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SomeInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SomeInterfaceProxyImpl.unbound() : super.unbound();

  static _SomeInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SomeInterfaceProxyImpl"));
    return new _SomeInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SomeInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _someInterfaceMethodSomeMethodName:
        var r = SomeInterfaceSomeMethodResponseParams.deserialize(
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
    return "_SomeInterfaceProxyImpl($superString)";
  }
}


class _SomeInterfaceProxyCalls implements SomeInterface {
  _SomeInterfaceProxyImpl _proxyImpl;

  _SomeInterfaceProxyCalls(this._proxyImpl);
    dynamic someMethod(RectPair pair,[Function responseFactory = null]) {
      var params = new _SomeInterfaceSomeMethodParams();
      params.pair = pair;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _someInterfaceMethodSomeMethodName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class SomeInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SomeInterface ptr;

  SomeInterfaceProxy(_SomeInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SomeInterfaceProxyCalls(proxyImpl);

  SomeInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SomeInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SomeInterfaceProxyCalls(impl);
  }

  SomeInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SomeInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _SomeInterfaceProxyCalls(impl);
  }

  SomeInterfaceProxy.unbound() :
      impl = new _SomeInterfaceProxyImpl.unbound() {
    ptr = new _SomeInterfaceProxyCalls(impl);
  }

  factory SomeInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SomeInterfaceProxy p = new SomeInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SomeInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SomeInterfaceProxy"));
    return new SomeInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SomeInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SomeInterfaceProxy($impl)";
  }
}


class SomeInterfaceStub extends bindings.Stub {
  SomeInterface _impl = null;

  SomeInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SomeInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SomeInterfaceStub.unbound() : super.unbound();

  static SomeInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SomeInterfaceStub"));
    return new SomeInterfaceStub.fromEndpoint(endpoint);
  }


  SomeInterfaceSomeMethodResponseParams _someInterfaceSomeMethodResponseParamsFactory(RectPair otherPair) {
    var result = new SomeInterfaceSomeMethodResponseParams();
    result.otherPair = otherPair;
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
      case _someInterfaceMethodSomeMethodName:
        var params = _SomeInterfaceSomeMethodParams.deserialize(
            message.payload);
        var response = _impl.someMethod(params.pair,_someInterfaceSomeMethodResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _someInterfaceMethodSomeMethodName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _someInterfaceMethodSomeMethodName,
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

  SomeInterface get impl => _impl;
  set impl(SomeInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SomeInterfaceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SomeInterfaceServiceDescription();
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xdW3Bbx3k+BxcSpG6UowtlSTZiKTJtxxTBK5i2CWSLKlVbEi3JMtW0ISHiUIBNAjAA1lRaN0yTzHCmbare+dKWTW/qS8u0zYxm8qKZPlS9pFX70NGjHvXI3tVO2vQc4l/xnMXuwV6A3XMsYgZaHXAXOOf7/t399////bfXqL96oByAEv8clQmsxOuVO+rlE/v9gv3eRPXMepmBMg/lGpR3oXwEZU+kXqahnIZyBcp1KO9D+RjKRBSeA8ppKFegvAPlAyifQNkbg/uDMg/lKpQbUD6E8gmUyXi9nITyVfv9kv2+en1qYuatieufWyy9X+qvWdVa/5lKJXvrWnZhybp6q2xV6/Vfsd+fJtd/o1DbbgLVjc/a75Pk+m+WirVsoVg9X6xZlfnsnOXUH7LfrzHWv2x9aP9Qbet3+pxn8293qZa3Kj73czZbqb1l3fqoVMldqVWW5ra+eMR+v85Yvx+uqtDmM5R21nx2aaF2rmAt5J5idQrkj1B/YrFcu4XuyOf+zy2UsrWLS4s3rMo2BS/b7xfJ9SezxdyCBV/cD/dAqOfgfdOqeL/Z534vZMs2ECAzPrzY9balywevCzZYhWtWpVooFZ8Scxqejan+tQHO+inO+kOc9Uc464/54X0xu2jlLls37eq+uFwsESTPr/7SwkL2xoLlkZMTdt2j5PqXrbnaVLZQaTauXJkrla2c3SurtWyxVt0ex/uY6vdPOALjI1dXSovW0zHC7z62nujSfL1sPr69W7QRxqr74fdusVq4WbRyno7z2Kzz6Mw/ztTx0Nyej5z/5ru916sHvNdTh73Xa0e914+PY/PgSe/fN17xXs+ewb7vDezvV7zXifew+/kY+/s3sfbf8l6v/In3uu/b3uv173iv73wX+72/9F5vfs97/fAfvde9/+G9vvcEu/6+F6+Hu8yn185Uu3bA9NRPHtu+dqbw2c94/775ev06iesbwPMsKCKTRuPrB/YL6TMZ12dbeoFBfjnisM9+45O1I8NH7HeT6bxBH/pT+91pv6/b73cc+c7bvel0ZSlXWiwUrcpp5/tOVytz9f+Ul24sFOZOF1Bvq56+USjmCsWb1dPOb9b/nanWe0y/02QRfidtvztc+tu06dWXnuo9SH+Je3FJu+47Avoby6sZ7virj/J5N/zu/AAZxw37vVcBjknsOdDvRw0xvBKCeJmseKXIeH0b5FgXXjFBvHoE8Yqw4jVIxuvPNOMVF8SrVxCvKCteQ2S8/lwzXh2CeCUF8Yqx4jVMxusvNOMVEcSrTxCvOCteI2S8vgP/14WXaWB6GKG/dbhwxPWTBHzBZpeYfjJFwe0QzIO4cSAJv00zH+D4Dppq9JIM6D8Ip1nAZRUEciPqtaskoWPnO8OlnwzZz7VfsbyahPkyLPrJsAa8OluAly79ZEQDXl0twEuXfjJq6l0vGCHTT8ZsvA5qwiviGodajacu/SVt1ufqoOBptgjPAUE8O1jxHCXjOW7W7S9BwjNCGB/99MVOF964voj8Y2sRNlwnMX1xloKrg5kzbxCdQ/YL2Z+buJEa+Cgq0h9xPEnyGncrJC3WBwea6OFV+7FnCttQ4TiVTPXrGPfvo8+dsX2P/fYY8/39fJ6qfnJtEn4P/T1pev2rvHKd95kne0lyDU5M5KdgdHc28LasSL57sXFk2fSXc9Xrnl2gi1WsD4k43VKsl0baJN+840pMct1E48FxT+12xldwFs4A8DjuX7a/6DmFuEc1jCsRn3EF2VeSkdbaV9DzeIIcwOd/mDie1Gvg/NQCND+69VlV48Ye+M0S4Ifjs2TW71k1PqzzFhqHkZ9MVB97QNHHiMExRH2MXBPH82OF85XBoPeKxvkkYaxBv7OKeIgEa15E8p39KFuoEXD5mlmfO3Xpfe77cThBEIvywot7rM12xUKVLI9ff8ZxT7TJPrkP1q8Vq5avlD5qwP0bnzDc/eYN9/hEsvuw4J5uEo9yj/I8KF6R8TEa7u9nFc0TvHGh+Li/guKBI159Gclnnyk3zqcZ7SdonD/z3pnzVx2/mVGPxWPBvx81IvDwFbM+RrabB1H5x/FOUvA2jdbIOz6+n4c4ORQPyIS33QjHeSVkONPkOtJiuUbj+eWJq5OXL71nDEOfZcIZNSLI9VcDjjdNz1853Fo9/3mjvj4nBqfD2HjMizexJo7vFw21ej6uV+DzIhoPmeLy+z84VyrV292GddAqfM8G8PAw4lUg+2D9NQUOhGWIC1iHG7gP8RWbEOfbuxvWCXsgjmAv/N4++L79ML8+B+PaAf91M65nPNYcZ/CThjq7As67e7yn4RWl4GVqijP4kka8HCxyTfDqpOAV0RRnMGOos8uI4BWj4BXTFGcwG3C8EhS8OjTFGWQhriSoeMUpeCU0xRHcCLh8dVHw2q0pTmAu4PLVQcFLNK6skxWvMTJeuYDLVzcFL9G4sgQrXmkyXlbA5StCwUs0rqyLFa9xMl7zAZcvGl4nBfHqZvSnz6cGiHjd1IjXto5+PUPDy6TgJRpnt4sZrxQRr3zA+yMNL9E4ut3MeA0S8SpoxKuZfJkuvwZq/wSrx4vXHma8hoh4va8YL5o/tQ8bx2nPsxt0dGRpEbXP8PKTEeRnLzM/w0R+PoAxVxU/ZoD5iWP8mD7+KFZ+9jHzM0LkZ0GR/aWZXxDh7iRVMFzxPJS8C03jTWk4Twni3MOM8ygR50VFekOSMq/J4uznb93vsrPT4sASZmvjwD4FmHuSxdiv4xAjRkkn08DLKUXyz4Kjux6OYx4MYWs97Yl3IibTIcY7kWviuH5Xsx9kGuYdJD/LUK5DeR/KZvmvbmP5r3zynzQA0++fh4dQP8VZf5Cz/hBn/WHO+iOc9Uc5649x1k9z1h9vkJs8lqdjDfohyjd2HwyIj8BwhPKdPIKF+ewusfWHLv/VXynUp90+FF58dO2Lva8YH1MQH137YP9aMT4RQfuRrn2vf6PQfhQx/PPi+OFzTJP/6W8V4xNTbK+V9Tf9nWJ84orts7L+pe8ZevYtsNoX0P1fGxXRJ0cNVXZfWb/V3yucB6R4GBPhYUyZPVnWH/YPYeEhLcJDmpuHtCY/24Ow8DAuwsO4r12j24UzzT60HG2tfQjt0/QkczXquUgPeewZ3hq9BHufjn3GfT77jGOG+v1UXcBv3iDL9yvwmUo7v2kEJ58SitfOOim9ZvIN+LwKsqcjP0bMaIwzQ8/UbH9vL6XfpkFR6z3VWnvkUbDtEpNwG/Wc2cc9/ZdcE8f/nzXbI+/AmLSOPzcI1gDKl4vZHe+hPHXYfuopLN/+BpRoP04PjKcZKMtQrmP59dECaADKFPRltrzojoVTrF1KsN2gYLshwXbDgu1GBNuNCrYbE2yXFmwHaoKff5TM+4Bgu5Rgu0HBdkOC7YYF240IthsVbDcm2C4t2G6cPA72YXkm02BwuAfzyyQMoA9AAZ8Ge/ojCLRB+0c2wRG+vN/lIDRc+eQPgf0e9hElj8D9PA/jHxi87h73t3dEA2av3zT05LHgXlcMyM0vvHzo2s/yL2HhIyU3b/PyoWu/zL+GhY9BOX2Il4+oJv/Hv4WFjyE5PZOXj5gmf8u/h4WPYTn9ncYHbb9ahyb/zn+GxX8xIrcu4uUjocmf9F8h8yeJrjd5+ejW5Fd6EhY+xuTW8bx87NbkX/rvsPCRlrOP8PKxV5Of6X/Cwse4nN2Jxke8xfFQsvvFvh9wPtD9I8OcqD2Pl48DgnzI7kf739DwkZKyk/LyIRoPJ7vf7f9Cw8eglP2Zlw/R+DvZ/XQ/CA0fQ1J2fV4+koJ8yO6fM8yw8DEs5S+h8dHR4rg22f1ykdDwMSLlh+LlQzS+TXZfXTQ0fIxK+fd4+RCNc9vPzMcYkY9YaPgYk/Kb8vKREeTjOWY+0kQ+4qHhIy3lj+blQ3S/9aeY+Rgn8tERGj7Gpfz8fnFlztpvmhJXhuJBVxn3uWawuLJm+4UvZMtvWbe2TwRv3C/srYHz9/OK/CV5WFuhOLk1wOUBOEQTYHjKgMK6DIK+AQbWxwB8stsbN3EbFmz399D7TdQI3vmdv2CoOU+Fpp/Qrnnx07Vv8Rc14xelXPPip2tf4zdh3NKFXyflmhc/Xfsef0kzfjHKNS9+SU1+eicf8yGN+CUo17z46Trv85c1y1+ccs2Ln67zPX9Fs/x1Ua558Utr8lv/qmb566Bc8+KX0eRn/jXN8tdNuebFb1KTX/jXNctfhHLNi9+UJj/ub2iWP5NyzYvftCa/629qxM/E7sc0/M/JI7Un2TF2G9v7IWl2jL4DrbVjoPMvL2TLWyYXZKdoPP/SWwN/3t/SZMd4iPLwwYLiPrJjwIT0ECbaMgx4CRC8dbBbTINDbQM7LyQsdozfBptTEPpBxKcfJDEc8H4QVjvI7xhq9uG2Cn+zTfjrsqOshwz/ZvJvhswO87vwbGHCP0KYh2XlX5cd51vQNozyHzEa85OabeJHl53o98DfFSZ+TFf9hKL+o8sO9fugAweBnzjj/O3+u2ge5rDYuf7AqOcMDgI/UR9+Wr1ODIsd7Q9DOL6h+Sfqen7d/Omy4/1RgOwosTbiq8vOdyfE6/NYC+d3XXbCP/4EzR8xBXZGlLd+ahcbT7Q8XPgLnY98YWmhVrhmVaqFUtF1zALhfGRyTfz5P6/ofPsM6DJI3leRPRYW0KuwkHsCC4ZZUHw2EvT+4l5fsNoTMxgPy5T6ZR87jWnQz4XoMby5HJ6DMfBCoQhc1D9H+enmZ2wwhwYbePmCWdc/VfCC4+pgmjH97YQmJ65mi3A1m+C6F9Y08zMVi5Q/MqMIVxXrDdOHJzyui5WnSIt4ijbhqQe+Y95BzwYU5+mMWT8LRfU5VSScIz4492LjECvO0RbhHGceZ7YyYTb0hzdMtXkw3fZzNw4k3J3+MUnBPYatj1lxR+2WJXHvbIL7IRiL5mcWrWo1e9OaKRfKVuN49KZZz+sbhDytfq+kIN7xFsl5J/O4f6NUWmjE+aypZp1GwzVGef6XsHUoK64dLcK1i0dPSY024DqhaD5NwzPj/nm0Lp3F8Fgh6O0mYR42sXVdr2tcihJwiwOXfdjnndj99bp47XR9TlsvLEdau15w1gIHiOuFegq/U+D381svODVxvidNPfmpnjX9/7yifuW3znX3F5rc9sWUyW2KWW5TjXL7tqknb/ys+WzK74Wd9Wtb1q8XQ7p+xftFUnB+po1Da3Fl49AQ8zg01MjfO6a6833d9lJ0bmIi+myOR5d3xqO2jEdXduxpobCnXdVkT8PHoT4M91atz2jzQm+nsnlhhHleGGnsR+8pmhf6oJ8gvMqAEzqfpBx7NueH6Z35oS3zw/Wd+SEU88OP7/hblPhbvhgQfws+D9Dsqu22n9Lm7c0uZfP2GPO8PdY4vn1J0byN279X0PljQOgKzNubIKDTnc/mPD6zM4+3ZR6f3ZnHQzGPZ3fmcSXz+I2duAmtcRNzO3ETSuImcqa6+PY4wT6E8ELxz3nNfn28HcorcLfF52Wj/IgXs4tW7rJ1ExHWmB/RWwPn75gRvPOynT+pzgOA9IaijZZBwOk49I+gzJuq9+nvgT7gaH+kPJsvwJyoY76LG+R9lK3QD0XP20br1J4T7VmnXiydteaz9hL0XMFayG0fuN24TiXXxPkbUzQObEJfQnl90TnZTyJeRSIBE1xPh9dOnwQi+mD9PwAbiNKwnyKD8o5AvtQy5B9Zhfwj6/DAdyEPyQNI2PwYJQo+CL8H588OwPmzkwDYLJxDuwbn0D44CveLzqF9oV7eedF/fW0oHt+a5TlJG+r2eZDwiFLuW9e5sOOa8eik3Leuc1k/Z6jJg03DgxYfK3oOp2xejh/SjEeCct+i52DK5sn4YaMey6oLj3iL9SHZvBQ/olk+unz0XBE8ZPNAfF6zfHQY/vY8Xjxk8y58QbN8dBv+djdePGTzHGQ0y0ekiX2GFw/ZvAFnNMuHyahfqtrn/4ZG+fCzR4jm1ZHdd/+mIjxY8hL44SOa10b2nMKzAbLXxHzwOSmIj+y5gROGuv0j7jUZLz4ZQXxkz/E7Z6jJK9KDrdF48TkriI/suXo/qgGfqAA+onl/ZM+5m4TPguB/8sPnbUF8ZM+dO2+o8Y/2YP4eXnxE8xrJngP3YxrwEelfVwXxkT2X7a0A6T9++IjmZTrAis8gWV9+OyT6z08I4nOQGR+y/nxB8fiMbGy8+MwK4nOIGR+y/nzRUB8nFBPwd+YF8TnMjA9Zf74E/1fl7zQM8bzifviVBfHrZcaPrF9PgQ4RFPxE/e3LgvgdYcaPrH+/oxg/s03ytyKI3/PM+JH188uGmvMVWfHzk7+4D36rgvgdZcaPrL9fgTW2yv7r/v2kS4907nVisVy75Up4iOIgCHEdnqq8eN8WxPsYM97k9cBVQ318TTvw9ouncewJ69jvNeTBYYyj446nWVpYyN5YsCazxdyCtf1ghHgaYk2cr9eN4MXV+emZhqBcG03kugv4xuMy0f32B8hO4vb74uePi8YZNItDQfFouWwtS8LntKHu/HEDm5ec+/qnmNfOT4uDo+btQOdgM/bbNNZvJ338ts69OEF6U9lCBeW/9YbvOX8hy92nNfXPvCk2z7erf6K4zvlCpVoj4PSSIvmjzTut3Nfjh2+74mZR/HzVmisVc434nggpvqJxsY/hBh7vZcM5g40HyJ52n7Ced/SjK3OlspV7s1Ss1rLFWnWrnx/xjAt4DfL4sKRwfMD9BqTxdgBkjMAH9kD9E84Jgvi4k3bNt6fYvufqxEXDcKwfr7HVP/P2lUszW42MxnzeSQiwSGD7UNH5gfcgYCKzi218dOcbbOf42Cxu9iuK+69B6b9oHN8iX0BecHnD9183w2cC8OGQl63f7YeGvHy3Sx9rFhe8ssN3ne+UKN8pIb5F52fZuOev7vBd53tQlO9BIb5F41Rl47p/bofvOt9DonwPCfEtGocrG7f+tR2+63wPi/I9TOXbz55yQJBv2bj8ryu0p4jwgezASI/m1dd5eRCN95bdD/CNgPOA7EtoUSO6DvJbJ3cajfvJET4Dppi9DI9XuksZX16GNX6T7t1wX8uK1sWvgu2pOd7b62N3fgCU/+ghKIAZtK+0Y7u+Rx5MOXtbmmKnaLZeQs/JuExq4OMWzIEq8i/wzEes+JrtwjfFiS9lvfflkOHrPscK4dEWfAc58aWsr346oPii/Cjdhv94geeLahveQ5x4U9Y3PxNQvFWvR1nHp13t4nOYk0/K+uXjgPKZpOiXhilm96flwTkIus0V+7HPo8dy+S9ct+mpgeP4vqkmXrbXx/9iYvqnn966ieJ/omL6O8KVZg9H+aAc1C5YtXwpR77/D8y6PKtaP/dizz8bEXvuNOW5kR95+7lfr1gfLlnVGvn50SsI5x3p8B8jv2EZPO0k+TgUAPsKHi9wAmLgKP7Np4EDoucfIfnMt1g+j0IMlkc+q2V78LVCIZ+G2R75bDaOlWp5qzJTpsaDOHL6yjMopz1Ij+2S88cbNH/8FgaX5usl0R+P1SDzc0CR3QG3I9xG50TAPLuGzj/oCNY4jPTKIkW+DxrBitfF8xb6xI96qpLw1pEPD8172Zkicd47BJjr2N/Akg9PFx89bfLjbvNRKZP4OGyojffn5UN2/CfxEPXhobdN/lUU77Y4U8zN/xR5vXNC0ThOwrkDG6eb8YKes1nexdNgUyf1F1ITXr6SbfKPon6zOJOvkvrNEZC/sPCVdOkLzrPh8fzI70HgyVPVT5+KG43n+Pa0yb6B8l2/W7SHW5eSlITf3r59bw38vnYBlqr1p2UU7wkD+BQI5KM42a6BeH6kSU/a/QnRk0i4Rly4mor1oT3PiD7UDPeIYr1n7ydc7yHhHXXhHVWs3+zb0W+2mjTjJaZYj+l5RvUY3N6TBiCnD7PhT9tH+QBrg+Tn3WK1cLNo5S4uLd6wKn55yck1G+ZjU+0+DNxukAf80XOj/b/3MDsv8h9Omd74kw0oHyE7G4pHgbIM5SD4Agl8koDqvzYg2C4l2G5QsN2QYLthwXYjgu1GBduNCbZLC7Ybb+r3pvA+INguRewHaB9XGSbMJzCurMBAl4AOdBvsyr3gSF+HwO4+2P+1AYno0vvp9lQUK0eKX2y3PZW27+cFM9jxi+j+hceJATE+dOXrfzEsfKTkxm1ePnSdF5AMCx+DcvMhjY8EhQ9d5xW8ZKrLlyfFx5CcnsHLh67zEk6EhY9hOf2Nlw9d5zWcDAsfI3J6MY2PLgofus6LOBUWPkbl1hu8fOg6r+LlsPAxJreO4+VDdB+b7HkZfWHhIy23Pqbx0U3hQ9SvLXtex6th4WNczu7Ay4eo31r2vJDXAs4Hun9xu8yAEB+i57fInlfy2dDwkZKyk/nFDex28fT/AQAA//9r4pW2KE4BAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  rect_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
          _runtimeTypeInfo.typeMap[s] = udt;
      });

  return _runtimeTypeInfo;
}
