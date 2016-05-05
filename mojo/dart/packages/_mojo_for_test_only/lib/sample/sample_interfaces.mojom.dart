// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_interfaces_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
const int kLong = 4405;

class Enum extends bindings.MojoEnum {
  static const Enum value = const Enum._(0);

  const Enum._(int v) : super(v);

  static const Map<String, Enum> valuesMap = const {
    "value": value,
  };
  static const List<Enum> values = const [
    value,
  ];

  static Enum valueOf(String name) => valuesMap[name];

  factory Enum(int v) {
    switch (v) {
      case 0:
        return Enum.value;
      default:
        return null;
    }
  }

  static Enum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Enum result = new Enum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Enum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case value:
        return 'Enum.value';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class _ProviderEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String a = null;

  _ProviderEchoStringParams() : super(kVersions.last.size);

  static _ProviderEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoStringParams result = new _ProviderEchoStringParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoStringParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class ProviderEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String a = null;

  ProviderEchoStringResponseParams() : super(kVersions.last.size);

  static ProviderEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoStringResponseParams result = new ProviderEchoStringResponseParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoStringResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class _ProviderEchoStringsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String a = null;
  String b = null;

  _ProviderEchoStringsParams() : super(kVersions.last.size);

  static _ProviderEchoStringsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoStringsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoStringsParams result = new _ProviderEchoStringsParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.b = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoStringsParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(b, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct _ProviderEchoStringsParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoStringsParams("
           "a: $a" ", "
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    map["b"] = b;
    return map;
  }
}


class ProviderEchoStringsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String a = null;
  String b = null;

  ProviderEchoStringsResponseParams() : super(kVersions.last.size);

  static ProviderEchoStringsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoStringsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoStringsResponseParams result = new ProviderEchoStringsResponseParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.b = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoStringsResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(b, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct ProviderEchoStringsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoStringsResponseParams("
           "a: $a" ", "
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    map["b"] = b;
    return map;
  }
}


class _ProviderEchoMessagePipeHandleParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint a = null;

  _ProviderEchoMessagePipeHandleParams() : super(kVersions.last.size);

  static _ProviderEchoMessagePipeHandleParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoMessagePipeHandleParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoMessagePipeHandleParams result = new _ProviderEchoMessagePipeHandleParams();

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
      
      result.a = decoder0.decodeMessagePipeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoMessagePipeHandleParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoMessagePipeHandleParams("
           "a: $a" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ProviderEchoMessagePipeHandleResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint a = null;

  ProviderEchoMessagePipeHandleResponseParams() : super(kVersions.last.size);

  static ProviderEchoMessagePipeHandleResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoMessagePipeHandleResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoMessagePipeHandleResponseParams result = new ProviderEchoMessagePipeHandleResponseParams();

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
      
      result.a = decoder0.decodeMessagePipeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoMessagePipeHandleResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoMessagePipeHandleResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ProviderEchoEnumParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Enum a = null;

  _ProviderEchoEnumParams() : super(kVersions.last.size);

  static _ProviderEchoEnumParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoEnumParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoEnumParams result = new _ProviderEchoEnumParams();

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
      
        result.a = Enum.decode(decoder0, 8);
        if (result.a == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoEnumParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoEnumParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class ProviderEchoEnumResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Enum a = null;

  ProviderEchoEnumResponseParams() : super(kVersions.last.size);

  static ProviderEchoEnumResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoEnumResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoEnumResponseParams result = new ProviderEchoEnumResponseParams();

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
      
        result.a = Enum.decode(decoder0, 8);
        if (result.a == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoEnumResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoEnumResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class _ProviderEchoIntParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int a = 0;

  _ProviderEchoIntParams() : super(kVersions.last.size);

  static _ProviderEchoIntParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoIntParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoIntParams result = new _ProviderEchoIntParams();

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
          "a of struct _ProviderEchoIntParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoIntParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class ProviderEchoIntResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int a = 0;

  ProviderEchoIntResponseParams() : super(kVersions.last.size);

  static ProviderEchoIntResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoIntResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoIntResponseParams result = new ProviderEchoIntResponseParams();

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
          "a of struct ProviderEchoIntResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoIntResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class _IntegerAccessorGetIntegerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _IntegerAccessorGetIntegerParams() : super(kVersions.last.size);

  static _IntegerAccessorGetIntegerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IntegerAccessorGetIntegerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IntegerAccessorGetIntegerParams result = new _IntegerAccessorGetIntegerParams();

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
    return "_IntegerAccessorGetIntegerParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class IntegerAccessorGetIntegerResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 2)
  ];
  int data = 0;
  Enum type = null;

  IntegerAccessorGetIntegerResponseParams() : super(kVersions.last.size);

  static IntegerAccessorGetIntegerResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IntegerAccessorGetIntegerResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IntegerAccessorGetIntegerResponseParams result = new IntegerAccessorGetIntegerResponseParams();

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
      
      result.data = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 2) {
      
        result.type = Enum.decode(decoder0, 16);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(data, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct IntegerAccessorGetIntegerResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct IntegerAccessorGetIntegerResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "IntegerAccessorGetIntegerResponseParams("
           "data: $data" ", "
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    map["type"] = type;
    return map;
  }
}


class _IntegerAccessorSetIntegerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 3)
  ];
  int data = 0;
  Enum type = null;

  _IntegerAccessorSetIntegerParams() : super(kVersions.last.size);

  static _IntegerAccessorSetIntegerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IntegerAccessorSetIntegerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IntegerAccessorSetIntegerParams result = new _IntegerAccessorSetIntegerParams();

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
      
      result.data = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 3) {
      
        result.type = Enum.decode(decoder0, 16);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(data, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct _IntegerAccessorSetIntegerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _IntegerAccessorSetIntegerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_IntegerAccessorSetIntegerParams("
           "data: $data" ", "
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    map["type"] = type;
    return map;
  }
}


class _SampleInterfaceSampleMethod1Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int in1 = 0;
  String in2 = null;

  _SampleInterfaceSampleMethod1Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod1Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod1Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod1Params result = new _SampleInterfaceSampleMethod1Params();

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
      
      result.in1 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.in2 = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(in1, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "in1 of struct _SampleInterfaceSampleMethod1Params: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(in2, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "in2 of struct _SampleInterfaceSampleMethod1Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SampleInterfaceSampleMethod1Params("
           "in1: $in1" ", "
           "in2: $in2" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["in1"] = in1;
    map["in2"] = in2;
    return map;
  }
}


class SampleInterfaceSampleMethod1ResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String out1 = null;
  Enum out2 = null;

  SampleInterfaceSampleMethod1ResponseParams() : super(kVersions.last.size);

  static SampleInterfaceSampleMethod1ResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SampleInterfaceSampleMethod1ResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SampleInterfaceSampleMethod1ResponseParams result = new SampleInterfaceSampleMethod1ResponseParams();

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
      
      result.out1 = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
        result.out2 = Enum.decode(decoder0, 16);
        if (result.out2 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(out1, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "out1 of struct SampleInterfaceSampleMethod1ResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(out2, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "out2 of struct SampleInterfaceSampleMethod1ResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SampleInterfaceSampleMethod1ResponseParams("
           "out1: $out1" ", "
           "out2: $out2" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["out1"] = out1;
    map["out2"] = out2;
    return map;
  }
}


class _SampleInterfaceSampleMethod0Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SampleInterfaceSampleMethod0Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod0Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod0Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod0Params result = new _SampleInterfaceSampleMethod0Params();

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
    return "_SampleInterfaceSampleMethod0Params("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _SampleInterfaceSampleMethod2Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SampleInterfaceSampleMethod2Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod2Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod2Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod2Params result = new _SampleInterfaceSampleMethod2Params();

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
    return "_SampleInterfaceSampleMethod2Params("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _providerMethodEchoStringName = 0;
const int _providerMethodEchoStringsName = 1;
const int _providerMethodEchoMessagePipeHandleName = 2;
const int _providerMethodEchoEnumName = 3;
const int _providerMethodEchoIntName = 4;

class _ProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Provider {
  static const String serviceName = null;
  dynamic echoString(String a,[Function responseFactory = null]);
  dynamic echoStrings(String a,String b,[Function responseFactory = null]);
  dynamic echoMessagePipeHandle(core.MojoMessagePipeEndpoint a,[Function responseFactory = null]);
  dynamic echoEnum(Enum a,[Function responseFactory = null]);
  dynamic echoInt(int a,[Function responseFactory = null]);
}


class _ProviderProxyImpl extends bindings.Proxy {
  _ProviderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ProviderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ProviderProxyImpl.unbound() : super.unbound();

  static _ProviderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ProviderProxyImpl"));
    return new _ProviderProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ProviderServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _providerMethodEchoStringName:
        var r = ProviderEchoStringResponseParams.deserialize(
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
      case _providerMethodEchoStringsName:
        var r = ProviderEchoStringsResponseParams.deserialize(
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
      case _providerMethodEchoMessagePipeHandleName:
        var r = ProviderEchoMessagePipeHandleResponseParams.deserialize(
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
      case _providerMethodEchoEnumName:
        var r = ProviderEchoEnumResponseParams.deserialize(
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
      case _providerMethodEchoIntName:
        var r = ProviderEchoIntResponseParams.deserialize(
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
    return "_ProviderProxyImpl($superString)";
  }
}


class _ProviderProxyCalls implements Provider {
  _ProviderProxyImpl _proxyImpl;

  _ProviderProxyCalls(this._proxyImpl);
    dynamic echoString(String a,[Function responseFactory = null]) {
      var params = new _ProviderEchoStringParams();
      params.a = a;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _providerMethodEchoStringName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic echoStrings(String a,String b,[Function responseFactory = null]) {
      var params = new _ProviderEchoStringsParams();
      params.a = a;
      params.b = b;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _providerMethodEchoStringsName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic echoMessagePipeHandle(core.MojoMessagePipeEndpoint a,[Function responseFactory = null]) {
      var params = new _ProviderEchoMessagePipeHandleParams();
      params.a = a;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _providerMethodEchoMessagePipeHandleName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic echoEnum(Enum a,[Function responseFactory = null]) {
      var params = new _ProviderEchoEnumParams();
      params.a = a;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _providerMethodEchoEnumName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic echoInt(int a,[Function responseFactory = null]) {
      var params = new _ProviderEchoIntParams();
      params.a = a;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _providerMethodEchoIntName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ProviderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Provider ptr;

  ProviderProxy(_ProviderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ProviderProxyCalls(proxyImpl);

  ProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ProviderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ProviderProxyCalls(impl);
  }

  ProviderProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ProviderProxyImpl.fromHandle(handle) {
    ptr = new _ProviderProxyCalls(impl);
  }

  ProviderProxy.unbound() :
      impl = new _ProviderProxyImpl.unbound() {
    ptr = new _ProviderProxyCalls(impl);
  }

  factory ProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ProviderProxy p = new ProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProviderProxy"));
    return new ProviderProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Provider.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ProviderProxy($impl)";
  }
}


class ProviderStub extends bindings.Stub {
  Provider _impl;

  ProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Provider impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ProviderStub.fromHandle(
      core.MojoHandle handle, [Provider impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ProviderStub.unbound() : super.unbound();

  static ProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProviderStub"));
    return new ProviderStub.fromEndpoint(endpoint);
  }


  ProviderEchoStringResponseParams _providerEchoStringResponseParamsFactory(String a) {
    var result = new ProviderEchoStringResponseParams();
    result.a = a;
    return result;
  }
  ProviderEchoStringsResponseParams _providerEchoStringsResponseParamsFactory(String a, String b) {
    var result = new ProviderEchoStringsResponseParams();
    result.a = a;
    result.b = b;
    return result;
  }
  ProviderEchoMessagePipeHandleResponseParams _providerEchoMessagePipeHandleResponseParamsFactory(core.MojoMessagePipeEndpoint a) {
    var result = new ProviderEchoMessagePipeHandleResponseParams();
    result.a = a;
    return result;
  }
  ProviderEchoEnumResponseParams _providerEchoEnumResponseParamsFactory(Enum a) {
    var result = new ProviderEchoEnumResponseParams();
    result.a = a;
    return result;
  }
  ProviderEchoIntResponseParams _providerEchoIntResponseParamsFactory(int a) {
    var result = new ProviderEchoIntResponseParams();
    result.a = a;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _providerMethodEchoStringName:
        var params = _ProviderEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.a,_providerEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _providerMethodEchoStringsName:
        var params = _ProviderEchoStringsParams.deserialize(
            message.payload);
        var response = _impl.echoStrings(params.a,params.b,_providerEchoStringsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoStringsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoStringsName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _providerMethodEchoMessagePipeHandleName:
        var params = _ProviderEchoMessagePipeHandleParams.deserialize(
            message.payload);
        var response = _impl.echoMessagePipeHandle(params.a,_providerEchoMessagePipeHandleResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoMessagePipeHandleName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoMessagePipeHandleName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _providerMethodEchoEnumName:
        var params = _ProviderEchoEnumParams.deserialize(
            message.payload);
        var response = _impl.echoEnum(params.a,_providerEchoEnumResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoEnumName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoEnumName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _providerMethodEchoIntName:
        var params = _ProviderEchoIntParams.deserialize(
            message.payload);
        var response = _impl.echoInt(params.a,_providerEchoIntResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoIntName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoIntName,
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

  Provider get impl => _impl;
  set impl(Provider d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  String toString() {
    var superString = super.toString();
    return "ProviderStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ProviderServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _integerAccessorMethodGetIntegerName = 0;
const int _integerAccessorMethodSetIntegerName = 1;

class _IntegerAccessorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class IntegerAccessor {
  static const String serviceName = null;
  dynamic getInteger([Function responseFactory = null]);
  void setInteger(int data, Enum type);
}


class _IntegerAccessorProxyImpl extends bindings.Proxy {
  _IntegerAccessorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _IntegerAccessorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _IntegerAccessorProxyImpl.unbound() : super.unbound();

  static _IntegerAccessorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _IntegerAccessorProxyImpl"));
    return new _IntegerAccessorProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _IntegerAccessorServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _integerAccessorMethodGetIntegerName:
        var r = IntegerAccessorGetIntegerResponseParams.deserialize(
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
    return "_IntegerAccessorProxyImpl($superString)";
  }
}


class _IntegerAccessorProxyCalls implements IntegerAccessor {
  _IntegerAccessorProxyImpl _proxyImpl;

  _IntegerAccessorProxyCalls(this._proxyImpl);
    dynamic getInteger([Function responseFactory = null]) {
      var params = new _IntegerAccessorGetIntegerParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _integerAccessorMethodGetIntegerName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void setInteger(int data, Enum type) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _IntegerAccessorSetIntegerParams();
      params.data = data;
      params.type = type;
      _proxyImpl.sendMessage(params, _integerAccessorMethodSetIntegerName);
    }
}


class IntegerAccessorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  IntegerAccessor ptr;

  IntegerAccessorProxy(_IntegerAccessorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _IntegerAccessorProxyCalls(proxyImpl);

  IntegerAccessorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _IntegerAccessorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _IntegerAccessorProxyCalls(impl);
  }

  IntegerAccessorProxy.fromHandle(core.MojoHandle handle) :
      impl = new _IntegerAccessorProxyImpl.fromHandle(handle) {
    ptr = new _IntegerAccessorProxyCalls(impl);
  }

  IntegerAccessorProxy.unbound() :
      impl = new _IntegerAccessorProxyImpl.unbound() {
    ptr = new _IntegerAccessorProxyCalls(impl);
  }

  factory IntegerAccessorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    IntegerAccessorProxy p = new IntegerAccessorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static IntegerAccessorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IntegerAccessorProxy"));
    return new IntegerAccessorProxy.fromEndpoint(endpoint);
  }

  String get serviceName => IntegerAccessor.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "IntegerAccessorProxy($impl)";
  }
}


class IntegerAccessorStub extends bindings.Stub {
  IntegerAccessor _impl;

  IntegerAccessorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [IntegerAccessor impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  IntegerAccessorStub.fromHandle(
      core.MojoHandle handle, [IntegerAccessor impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  IntegerAccessorStub.unbound() : super.unbound();

  static IntegerAccessorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IntegerAccessorStub"));
    return new IntegerAccessorStub.fromEndpoint(endpoint);
  }


  IntegerAccessorGetIntegerResponseParams _integerAccessorGetIntegerResponseParamsFactory(int data, Enum type) {
    var result = new IntegerAccessorGetIntegerResponseParams();
    result.data = data;
    result.type = type;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          3,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _integerAccessorMethodGetIntegerName:
        var response = _impl.getInteger(_integerAccessorGetIntegerResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _integerAccessorMethodGetIntegerName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _integerAccessorMethodGetIntegerName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _integerAccessorMethodSetIntegerName:
        var params = _IntegerAccessorSetIntegerParams.deserialize(
            message.payload);
        _impl.setInteger(params.data, params.type);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  IntegerAccessor get impl => _impl;
  set impl(IntegerAccessor d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  String toString() {
    var superString = super.toString();
    return "IntegerAccessorStub($superString)";
  }

  int get version => 3;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _IntegerAccessorServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _sampleInterfaceMethodSampleMethod1Name = 1;
const int _sampleInterfaceMethodSampleMethod0Name = 0;
const int _sampleInterfaceMethodSampleMethod2Name = 2;

class _SampleInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SampleInterface {
  static const String serviceName = null;
  dynamic sampleMethod1(int in1,String in2,[Function responseFactory = null]);
  void sampleMethod0();
  void sampleMethod2();
}


class _SampleInterfaceProxyImpl extends bindings.Proxy {
  _SampleInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SampleInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SampleInterfaceProxyImpl.unbound() : super.unbound();

  static _SampleInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SampleInterfaceProxyImpl"));
    return new _SampleInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SampleInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _sampleInterfaceMethodSampleMethod1Name:
        var r = SampleInterfaceSampleMethod1ResponseParams.deserialize(
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
    return "_SampleInterfaceProxyImpl($superString)";
  }
}


class _SampleInterfaceProxyCalls implements SampleInterface {
  _SampleInterfaceProxyImpl _proxyImpl;

  _SampleInterfaceProxyCalls(this._proxyImpl);
    dynamic sampleMethod1(int in1,String in2,[Function responseFactory = null]) {
      var params = new _SampleInterfaceSampleMethod1Params();
      params.in1 = in1;
      params.in2 = in2;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _sampleInterfaceMethodSampleMethod1Name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void sampleMethod0() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SampleInterfaceSampleMethod0Params();
      _proxyImpl.sendMessage(params, _sampleInterfaceMethodSampleMethod0Name);
    }
    void sampleMethod2() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SampleInterfaceSampleMethod2Params();
      _proxyImpl.sendMessage(params, _sampleInterfaceMethodSampleMethod2Name);
    }
}


class SampleInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SampleInterface ptr;

  SampleInterfaceProxy(_SampleInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SampleInterfaceProxyCalls(proxyImpl);

  SampleInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SampleInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SampleInterfaceProxyCalls(impl);
  }

  SampleInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SampleInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _SampleInterfaceProxyCalls(impl);
  }

  SampleInterfaceProxy.unbound() :
      impl = new _SampleInterfaceProxyImpl.unbound() {
    ptr = new _SampleInterfaceProxyCalls(impl);
  }

  factory SampleInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SampleInterfaceProxy p = new SampleInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SampleInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SampleInterfaceProxy"));
    return new SampleInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SampleInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SampleInterfaceProxy($impl)";
  }
}


class SampleInterfaceStub extends bindings.Stub {
  SampleInterface _impl;

  SampleInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SampleInterface impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  SampleInterfaceStub.fromHandle(
      core.MojoHandle handle, [SampleInterface impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  SampleInterfaceStub.unbound() : super.unbound();

  static SampleInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SampleInterfaceStub"));
    return new SampleInterfaceStub.fromEndpoint(endpoint);
  }


  SampleInterfaceSampleMethod1ResponseParams _sampleInterfaceSampleMethod1ResponseParamsFactory(String out1, Enum out2) {
    var result = new SampleInterfaceSampleMethod1ResponseParams();
    result.out1 = out1;
    result.out2 = out2;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _sampleInterfaceMethodSampleMethod1Name:
        var params = _SampleInterfaceSampleMethod1Params.deserialize(
            message.payload);
        var response = _impl.sampleMethod1(params.in1,params.in2,_sampleInterfaceSampleMethod1ResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _sampleInterfaceMethodSampleMethod1Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _sampleInterfaceMethodSampleMethod1Name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _sampleInterfaceMethodSampleMethod0Name:
        _impl.sampleMethod0();
        break;
      case _sampleInterfaceMethodSampleMethod2Name:
        _impl.sampleMethod2();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SampleInterface get impl => _impl;
  set impl(SampleInterface d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  String toString() {
    var superString = super.toString();
    return "SampleInterfaceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SampleInterfaceServiceDescription();
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+yb3W7jRBTH7Thdyi4L3W0K6X5mFy3kpnVSJKi4Si8iUkGlSIVV92pxkyExSuxgO6jwBPsIPAaPwCPso3DZO7Cbc5rxZMYfidOM2440mvornvn5f86Zr5aVSdqAsgYlex7LdaZk7/sHyqqfi36uwPE+lCdQjqB84ueSn398026+/b755lvXGI4GZLdpjYfB9S/9/Jxz/dDySI84B50OcV3buXhPmXNf27F/N7vEEf3O8UUR/Jrzi9EhSgvqvcHUOzjW/PyuED5+/0n4uFrnczmHsqGEU415z3+Q2PswfQT1Qz6bfr7nZwbbzPuD59b8bPrZ8LM+dh19YHeMgd6z7d6A6H17SPQ/HUMf2r/auut0Jn+MxqcDs6ObSMjVT02ra1o9V/eI67n65M1vpzfsBs8NqferlF5qlD4u6qkqkSkpr5bg+fvQ7tcHP/zU9MttPz8I89rFazxuwfOFFXCLswvkV2HauwE8tRh+DYZfW8DvMz8HEmft7Zl/7tMpR/byDMfg+O4KOPLqgcdgyhf6LMMx3nd2J6zTCmPH1UIynSoUZ955TA+Bz3fEA5b8+m+vSI8Vht95Qr+mMDrbF7T/ETCYtn/HIb+N/ZrxOWC6ag7rAr9WZuq1HsPtvZYNt8cQA0Lc3JFtuUQqbqx9VdRw+/eZet5RkqWkdleNiaddwzNE9ra9Al48LkEcawniJeqtIHj+jMNFpfphbGL1XeH4T416H/qvI9N6TRzXtK0wX++PERHx/WqF/kwRxAe2nxUXj2f0zfELKuc9BchlhR9vGsz3ViEn/b5nC35fNeb74vnjmLj1WLK4lZX/xbh1LHncyqv/xfiWF/+rXbH/1Rb0vwHfnRvsf7UY/xt6eI5xaSPi+wbfFucncJzFTFtw52FkGEdVqXHqGoWoAEyLFJc16v5zuLn6MfxeaVK2H0WPt0605Yy3mp2+few5Pgd+Ox9IFrdw3JlV3Jq2X864xfpBnl9WOfa5rHj1IbzKUMR6Ka2IU1T8EPnBZesM43dIZxKOT/Oos5c50pnIr78rhsNrEm5qhF/H+fCp3lwuv4eS+fUTbVn25oYcu6zjkZqaD7sLdLMlgd2l5bQ+Byc1AafTCE7PJfdPdL9/2XaJ45ewXU4D4a1dLm6XO7d2mcguv8mRXc6Mx4FjX+PPd0dxK1DfhU1Pwa8H9nlEXNfokbY5Ii3D6g4Ih+OmJP0H5FFL2V8XzUu8AhZcDlRPIk/99qJEfmpTAj+lLjA+zFpvX/j5WYTeMELe6m1+vR3mSG+sv/8Xx4lasn0tNDctghvOvwa6C+aQWW4lSfw7tv/nlPYmGh+XoY3YbnTpebKvNYnsqwR/5339ZNH5wn5G84W4P4/SJzVbmK84IJtOn9wgnYriyD4EkGIK7sUI7sGa3Qeg10PLm+G+JVkc2cgojuB6JbT7cmSQJ/tUqLXLVdvn1oriyLx+P2s90f2SiZ4mbv9WT/Pr6anEeorbvx7HqcHoKm7/Ovt/Hsz+dfbyDM+KJPsuKlQ815h9F3hdo55rw4W/70avw6XVJ75XZM+B/u5fcj8iXt/u1jjtealcz/3sOJ8Yar+E82dp97OL9HOWch1XjdCVSD91DrcXkumnpS1PP3UJ9ZN2X+lVxcd74AdNq871oy/gnAz7Sq9yfWjKZU/I5dUK5wvVjNZt/8rIDrGfwNqhbPPSsq7b4vjeHnt1kd6+lkBvaedvsrZLitOeiNPBNZ+/iVr3ZfupSdd98f9r0vQz9jj8P79B/dS9a9BP/T8AAP//qXbi1dhAAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
