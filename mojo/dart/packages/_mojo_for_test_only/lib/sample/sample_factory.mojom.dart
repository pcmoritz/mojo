// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_factory_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:_mojo_for_test_only/imported/sample_import.mojom.dart' as sample_import_mojom;



class Request extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int x = 0;
  core.MojoMessagePipeEndpoint pipe = null;
  List<core.MojoMessagePipeEndpoint> morePipes = null;
  Object obj = null;

  Request() : super(kVersions.last.size);

  static Request deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Request decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Request result = new Request();

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
      
      result.pipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.morePipes = decoder0.decodeMessagePipeHandleArray(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.obj = decoder0.decodeServiceInterface(24, true, sample_import_mojom.ImportedInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Request: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(pipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct Request: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandleArray(morePipes, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "morePipes of struct Request: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(obj, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct Request: $e";
      rethrow;
    }
  }

  String toString() {
    return "Request("
           "x: $x" ", "
           "pipe: $pipe" ", "
           "morePipes: $morePipes" ", "
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class Response extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int x = 0;
  core.MojoMessagePipeEndpoint pipe = null;

  Response() : super(kVersions.last.size);

  static Response deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Response decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Response result = new Response();

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
      
      result.pipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Response: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(pipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct Response: $e";
      rethrow;
    }
  }

  String toString() {
    return "Response("
           "x: $x" ", "
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _NamedObjectSetNameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String name = null;

  _NamedObjectSetNameParams() : super(kVersions.last.size);

  static _NamedObjectSetNameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NamedObjectSetNameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NamedObjectSetNameParams result = new _NamedObjectSetNameParams();

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
      
      result.name = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(name, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct _NamedObjectSetNameParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NamedObjectSetNameParams("
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    return map;
  }
}


class _NamedObjectGetNameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NamedObjectGetNameParams() : super(kVersions.last.size);

  static _NamedObjectGetNameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NamedObjectGetNameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NamedObjectGetNameParams result = new _NamedObjectGetNameParams();

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
    return "_NamedObjectGetNameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class NamedObjectGetNameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String name = null;

  NamedObjectGetNameResponseParams() : super(kVersions.last.size);

  static NamedObjectGetNameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NamedObjectGetNameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NamedObjectGetNameResponseParams result = new NamedObjectGetNameResponseParams();

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
      
      result.name = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(name, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct NamedObjectGetNameResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "NamedObjectGetNameResponseParams("
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    return map;
  }
}


class _FactoryDoStuffParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Request request = null;
  core.MojoMessagePipeEndpoint pipe = null;

  _FactoryDoStuffParams() : super(kVersions.last.size);

  static _FactoryDoStuffParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryDoStuffParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryDoStuffParams result = new _FactoryDoStuffParams();

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
      result.request = Request.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.pipe = decoder0.decodeMessagePipeHandle(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _FactoryDoStuffParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(pipe, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct _FactoryDoStuffParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryDoStuffParams("
           "request: $request" ", "
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FactoryDoStuffResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Response response = null;
  String text = null;

  FactoryDoStuffResponseParams() : super(kVersions.last.size);

  static FactoryDoStuffResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FactoryDoStuffResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FactoryDoStuffResponseParams result = new FactoryDoStuffResponseParams();

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
      result.response = Response.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.text = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct FactoryDoStuffResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(text, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct FactoryDoStuffResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FactoryDoStuffResponseParams("
           "response: $response" ", "
           "text: $text" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _FactoryDoStuff2Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer pipe = null;

  _FactoryDoStuff2Params() : super(kVersions.last.size);

  static _FactoryDoStuff2Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryDoStuff2Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryDoStuff2Params result = new _FactoryDoStuff2Params();

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
      
      result.pipe = decoder0.decodeConsumerHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeConsumerHandle(pipe, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct _FactoryDoStuff2Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryDoStuff2Params("
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FactoryDoStuff2ResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String text = null;

  FactoryDoStuff2ResponseParams() : super(kVersions.last.size);

  static FactoryDoStuff2ResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FactoryDoStuff2ResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FactoryDoStuff2ResponseParams result = new FactoryDoStuff2ResponseParams();

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
      
      result.text = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(text, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct FactoryDoStuff2ResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FactoryDoStuff2ResponseParams("
           "text: $text" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    return map;
  }
}


class _FactoryCreateNamedObjectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object obj = null;

  _FactoryCreateNamedObjectParams() : super(kVersions.last.size);

  static _FactoryCreateNamedObjectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryCreateNamedObjectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryCreateNamedObjectParams result = new _FactoryCreateNamedObjectParams();

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
      
      result.obj = decoder0.decodeInterfaceRequest(8, false, NamedObjectStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct _FactoryCreateNamedObjectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryCreateNamedObjectParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _FactoryRequestImportedInterfaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object obj = null;

  _FactoryRequestImportedInterfaceParams() : super(kVersions.last.size);

  static _FactoryRequestImportedInterfaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryRequestImportedInterfaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryRequestImportedInterfaceParams result = new _FactoryRequestImportedInterfaceParams();

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
      
      result.obj = decoder0.decodeInterfaceRequest(8, false, sample_import_mojom.ImportedInterfaceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct _FactoryRequestImportedInterfaceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryRequestImportedInterfaceParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FactoryRequestImportedInterfaceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object obj = null;

  FactoryRequestImportedInterfaceResponseParams() : super(kVersions.last.size);

  static FactoryRequestImportedInterfaceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FactoryRequestImportedInterfaceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FactoryRequestImportedInterfaceResponseParams result = new FactoryRequestImportedInterfaceResponseParams();

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
      
      result.obj = decoder0.decodeInterfaceRequest(8, false, sample_import_mojom.ImportedInterfaceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct FactoryRequestImportedInterfaceResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FactoryRequestImportedInterfaceResponseParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _FactoryTakeImportedInterfaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object obj = null;

  _FactoryTakeImportedInterfaceParams() : super(kVersions.last.size);

  static _FactoryTakeImportedInterfaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryTakeImportedInterfaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryTakeImportedInterfaceParams result = new _FactoryTakeImportedInterfaceParams();

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
      
      result.obj = decoder0.decodeServiceInterface(8, false, sample_import_mojom.ImportedInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct _FactoryTakeImportedInterfaceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryTakeImportedInterfaceParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FactoryTakeImportedInterfaceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object obj = null;

  FactoryTakeImportedInterfaceResponseParams() : super(kVersions.last.size);

  static FactoryTakeImportedInterfaceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FactoryTakeImportedInterfaceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FactoryTakeImportedInterfaceResponseParams result = new FactoryTakeImportedInterfaceResponseParams();

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
      
      result.obj = decoder0.decodeServiceInterface(8, false, sample_import_mojom.ImportedInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct FactoryTakeImportedInterfaceResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FactoryTakeImportedInterfaceResponseParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _NamedObject_setNameName = 0;
const int _NamedObject_getNameName = 1;

class _NamedObjectServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().servicesByName["sample::NamedObject"].topLevelInterface;
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class NamedObject {
  static const String serviceName = "sample::NamedObject";
  void setName(String name);
  dynamic getName([Function responseFactory = null]);
}


class _NamedObjectProxyImpl extends bindings.Proxy {
  _NamedObjectProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NamedObjectProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NamedObjectProxyImpl.unbound() : super.unbound();

  static _NamedObjectProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NamedObjectProxyImpl"));
    return new _NamedObjectProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _NamedObjectServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _NamedObject_getNameName:
        var r = NamedObjectGetNameResponseParams.deserialize(
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
    return "_NamedObjectProxyImpl($superString)";
  }
}


class _NamedObjectProxyCalls implements NamedObject {
  _NamedObjectProxyImpl _proxyImpl;

  _NamedObjectProxyCalls(this._proxyImpl);
    void setName(String name) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NamedObjectSetNameParams();
      params.name = name;
      _proxyImpl.sendMessage(params, _NamedObject_setNameName);
    }
    dynamic getName([Function responseFactory = null]) {
      var params = new _NamedObjectGetNameParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _NamedObject_getNameName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class NamedObjectProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NamedObject ptr;

  NamedObjectProxy(_NamedObjectProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NamedObjectProxyCalls(proxyImpl);

  NamedObjectProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NamedObjectProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NamedObjectProxyCalls(impl);
  }

  NamedObjectProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NamedObjectProxyImpl.fromHandle(handle) {
    ptr = new _NamedObjectProxyCalls(impl);
  }

  NamedObjectProxy.unbound() :
      impl = new _NamedObjectProxyImpl.unbound() {
    ptr = new _NamedObjectProxyCalls(impl);
  }

  factory NamedObjectProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NamedObjectProxy p = new NamedObjectProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NamedObjectProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NamedObjectProxy"));
    return new NamedObjectProxy.fromEndpoint(endpoint);
  }

  String get serviceName => NamedObject.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "NamedObjectProxy($impl)";
  }
}


class NamedObjectStub extends bindings.Stub {
  NamedObject _impl = null;

  NamedObjectStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  NamedObjectStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  NamedObjectStub.unbound() : super.unbound();

  static NamedObjectStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NamedObjectStub"));
    return new NamedObjectStub.fromEndpoint(endpoint);
  }


  NamedObjectGetNameResponseParams _NamedObjectGetNameResponseParamsFactory(String name) {
    var mojo_factory_result = new NamedObjectGetNameResponseParams();
    mojo_factory_result.name = name;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _NamedObject_setNameName:
        var params = _NamedObjectSetNameParams.deserialize(
            message.payload);
        _impl.setName(params.name);
        break;
      case _NamedObject_getNameName:
        var response = _impl.getName(_NamedObjectGetNameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _NamedObject_getNameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _NamedObject_getNameName,
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

  NamedObject get impl => _impl;
  set impl(NamedObject d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "NamedObjectStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NamedObjectServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _Factory_doStuffName = 0;
const int _Factory_doStuff2Name = 1;
const int _Factory_createNamedObjectName = 2;
const int _Factory_requestImportedInterfaceName = 3;
const int _Factory_takeImportedInterfaceName = 4;

class _FactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Factory {
  static const String serviceName = null;
  dynamic doStuff(Request request,core.MojoMessagePipeEndpoint pipe,[Function responseFactory = null]);
  dynamic doStuff2(core.MojoDataPipeConsumer pipe,[Function responseFactory = null]);
  void createNamedObject(Object obj);
  dynamic requestImportedInterface(Object obj,[Function responseFactory = null]);
  dynamic takeImportedInterface(Object obj,[Function responseFactory = null]);
}


class _FactoryProxyImpl extends bindings.Proxy {
  _FactoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _FactoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _FactoryProxyImpl.unbound() : super.unbound();

  static _FactoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _FactoryProxyImpl"));
    return new _FactoryProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _FactoryServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Factory_doStuffName:
        var r = FactoryDoStuffResponseParams.deserialize(
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
      case _Factory_doStuff2Name:
        var r = FactoryDoStuff2ResponseParams.deserialize(
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
      case _Factory_requestImportedInterfaceName:
        var r = FactoryRequestImportedInterfaceResponseParams.deserialize(
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
      case _Factory_takeImportedInterfaceName:
        var r = FactoryTakeImportedInterfaceResponseParams.deserialize(
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
    return "_FactoryProxyImpl($superString)";
  }
}


class _FactoryProxyCalls implements Factory {
  _FactoryProxyImpl _proxyImpl;

  _FactoryProxyCalls(this._proxyImpl);
    dynamic doStuff(Request request,core.MojoMessagePipeEndpoint pipe,[Function responseFactory = null]) {
      var params = new _FactoryDoStuffParams();
      params.request = request;
      params.pipe = pipe;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Factory_doStuffName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic doStuff2(core.MojoDataPipeConsumer pipe,[Function responseFactory = null]) {
      var params = new _FactoryDoStuff2Params();
      params.pipe = pipe;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Factory_doStuff2Name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void createNamedObject(Object obj) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _FactoryCreateNamedObjectParams();
      params.obj = obj;
      _proxyImpl.sendMessage(params, _Factory_createNamedObjectName);
    }
    dynamic requestImportedInterface(Object obj,[Function responseFactory = null]) {
      var params = new _FactoryRequestImportedInterfaceParams();
      params.obj = obj;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Factory_requestImportedInterfaceName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic takeImportedInterface(Object obj,[Function responseFactory = null]) {
      var params = new _FactoryTakeImportedInterfaceParams();
      params.obj = obj;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Factory_takeImportedInterfaceName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class FactoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Factory ptr;

  FactoryProxy(_FactoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _FactoryProxyCalls(proxyImpl);

  FactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _FactoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _FactoryProxyCalls(impl);
  }

  FactoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new _FactoryProxyImpl.fromHandle(handle) {
    ptr = new _FactoryProxyCalls(impl);
  }

  FactoryProxy.unbound() :
      impl = new _FactoryProxyImpl.unbound() {
    ptr = new _FactoryProxyCalls(impl);
  }

  factory FactoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    FactoryProxy p = new FactoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static FactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FactoryProxy"));
    return new FactoryProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Factory.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "FactoryProxy($impl)";
  }
}


class FactoryStub extends bindings.Stub {
  Factory _impl = null;

  FactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  FactoryStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  FactoryStub.unbound() : super.unbound();

  static FactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FactoryStub"));
    return new FactoryStub.fromEndpoint(endpoint);
  }


  FactoryDoStuffResponseParams _FactoryDoStuffResponseParamsFactory(Response response, String text) {
    var mojo_factory_result = new FactoryDoStuffResponseParams();
    mojo_factory_result.response = response;
    mojo_factory_result.text = text;
    return mojo_factory_result;
  }
  FactoryDoStuff2ResponseParams _FactoryDoStuff2ResponseParamsFactory(String text) {
    var mojo_factory_result = new FactoryDoStuff2ResponseParams();
    mojo_factory_result.text = text;
    return mojo_factory_result;
  }
  FactoryRequestImportedInterfaceResponseParams _FactoryRequestImportedInterfaceResponseParamsFactory(Object obj) {
    var mojo_factory_result = new FactoryRequestImportedInterfaceResponseParams();
    mojo_factory_result.obj = obj;
    return mojo_factory_result;
  }
  FactoryTakeImportedInterfaceResponseParams _FactoryTakeImportedInterfaceResponseParamsFactory(Object obj) {
    var mojo_factory_result = new FactoryTakeImportedInterfaceResponseParams();
    mojo_factory_result.obj = obj;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _Factory_doStuffName:
        var params = _FactoryDoStuffParams.deserialize(
            message.payload);
        var response = _impl.doStuff(params.request,params.pipe,_FactoryDoStuffResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Factory_doStuffName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Factory_doStuffName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Factory_doStuff2Name:
        var params = _FactoryDoStuff2Params.deserialize(
            message.payload);
        var response = _impl.doStuff2(params.pipe,_FactoryDoStuff2ResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Factory_doStuff2Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Factory_doStuff2Name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Factory_createNamedObjectName:
        var params = _FactoryCreateNamedObjectParams.deserialize(
            message.payload);
        _impl.createNamedObject(params.obj);
        break;
      case _Factory_requestImportedInterfaceName:
        var params = _FactoryRequestImportedInterfaceParams.deserialize(
            message.payload);
        var response = _impl.requestImportedInterface(params.obj,_FactoryRequestImportedInterfaceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Factory_requestImportedInterfaceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Factory_requestImportedInterfaceName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Factory_takeImportedInterfaceName:
        var params = _FactoryTakeImportedInterfaceParams.deserialize(
            message.payload);
        var response = _impl.takeImportedInterface(params.obj,_FactoryTakeImportedInterfaceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Factory_takeImportedInterfaceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Factory_takeImportedInterfaceName,
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

  Factory get impl => _impl;
  set impl(Factory d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "FactoryStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _FactoryServiceDescription();
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
  // file.
  var serializedRuntimeTypeInfo = new Uint8List.fromList(const [24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,216,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,27,0,0,0,19,0,0,0,115,97,109,112,108,101,58,58,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,35,0,0,0,27,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,35,0,0,0,27,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,184,0,0,0,0,0,0,0,40,0,0,0,4,0,0,0,32,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,88,0,0,0,0,0,0,0,112,0,0,0,0,0,0,0,35,0,0,0,27,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,70,97,99,116,111,114,121,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,82,101,113,117,101,115,116,0,32,0,0,0,24,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,82,101,115,112,111,110,115,101,72,0,0,0,4,0,0,0,16,0,0,0,3,0,0,0,56,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,56,9,0,0,0,0,0,0,16,0,0,0,1,0,0,0,208,39,0,0,0,0,0,0,16,0,0,0,1,0,0,0,208,45,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,112,1,0,0,0,0,0,0,136,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,152,0,0,0,0,0,0,0,168,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,184,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,7,0,0,0,32,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,83,101,114,118,105,99,101,78,97,109,101,0,0,0,0,0,27,0,0,0,19,0,0,0,115,97,109,112,108,101,58,58,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,19,0,0,0,11,0,0,0,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,26,0,0,0,18,0,0,0,115,97,109,112,108,101,46,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,27,0,0,0,10,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,27,0,0,0,19,0,0,0,115,97,109,112,108,101,58,58,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,2,0,0,0,0,0,0,0,1,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,32,3,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,
232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,83,101,116,78,97,109,101,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,28,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,23,0,0,0,15,0,0,0,83,101,116,78,97,109,101,45,114,101,113,117,101,115,116,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,110,97,109,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,28,0,0,0,17,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,224,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,71,101,116,78,97,109,101,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,29,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,
97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,23,0,0,0,15,0,0,0,71,101,116,78,97,109,101,45,114,101,113,117,101,115,116,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,0,0,0,16,0,0,0,71,101,116,78,97,109,101,45,114,101,115,112,111,110,115,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,110,97,109,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,29,0,0,0,23,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,70,97,99,116,111,114,121,0,22,0,0,0,14,0,0,0,115,97,109,112,108,101,46,70,97,99,116,111,114,121,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32,0,0,0,10,0,0,0,91,0,0,0,83,0,0,0,
47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,28,0,0,0,5,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,48,0,0,0,5,0,0,0,40,0,0,0,0,0,0,0,96,5,0,0,0,0,0,0,224,8,0,0,0,0,0,0,24,15,0,0,0,0,0,0,72,21,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,1,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,68,111,83,116,117,102,102,50,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,35,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,0,0,0,16,0,0,0,68,111,83,116,117,102,102,50,45,114,101,113,117,101,115,116,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,4,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,112,105,112,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,35,0,0,0,38,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,17,0,0,0,68,111,83,116,117,102,102,50,45,114,101,115,112,111,110,115,101,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,116,101,120,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,35,0,0,0,55,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,17,0,0,0,67,114,101,97,116,101,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,36,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33,0,0,0,25,0,0,0,67,114,101,97,116,101,78,97,109,101,100,79,98,106,101,99,116,45,114,101,113,117,101,115,116,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,
47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,111,98,106,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,36,0,0,0,33,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,35,0,0,0,27,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,78,97,109,101,100,79,98,106,101,99,116,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,136,3,0,0,0,0,0,0,3,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,24,0,0,0,82,101,113,117,101,115,116,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,37,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,40,0,0,0,32,0,0,0,82,101,113,117,101,115,116,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,45,114,101,113,117,101,115,116,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,
16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,111,98,106,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,38,0,0,0,34,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,0,43,0,0,0,35,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,41,0,0,0,33,0,0,0,82,101,113,117,101,115,116,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,45,114,101,115,112,111,110,115,101,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,111,98,106,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,38,0,0,0,71,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,0,43,0,0,0,35,0,0,0,
84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,136,3,0,0,0,0,0,0,4,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,29,0,0,0,21,0,0,0,84,97,107,101,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,39,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,37,0,0,0,29,0,0,0,84,97,107,101,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,45,114,101,113,117,101,115,116,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,111,98,106,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,40,0,0,0,33,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,0,43,0,0,0,35,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,38,0,0,0,30,0,0,0,84,97,107,101,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,45,114,101,115,112,111,110,115,101,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,111,98,106,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,40,0,0,0,69,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,0,43,0,0,0,35,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,96,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,68,111,83,116,117,102,102,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,33,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,23,0,0,0,15,0,0,0,68,111,83,116,117,102,102,45,
114,101,113,117,101,115,116,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,96,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,114,101,113,117,101,115,116,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,33,0,0,0,18,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,82,101,113,117,101,115,116,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,82,101,113,117,101,115,116,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,4,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,112,105,112,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,33,0,0,0,49,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,0,0,0,16,0,0,0,68,111,83,116,117,102,102,45,114,101,115,112,111,110,115,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,
97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,96,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,114,101,115,112,111,110,115,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,34,0,0,0,16,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,82,101,115,112,111,110,115,101,32,0,0,0,24,0,0,0,84,89,80,69,95,75,69,89,58,115,97,109,112,108,101,46,82,101,115,112,111,110,115,101,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,116,101,120,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,34,0,0,0,33,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,82,101,113,117,101,115,116,0,22,0,0,0,14,0,0,0,115,97,109,112,108,101,46,82,101,113,117,101,115,116,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,12,0,0,0,7,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,40,0,0,0,4,0,0,0,32,0,0,0,0,0,0,0,32,1,0,0,0,0,0,0,48,2,0,0,0,0,0,0,104,3,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,
5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,1,0,0,0,120,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,13,0,0,0,8,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,4,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,112,105,112,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,14,0,0,0,24,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,2,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,109,111,114,101,95,112,105,112,101,115,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,15,0,0,0,31,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,1,0,0,0,255,255,255,255,16,0,0,0,4,0,0,0,8,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,111,98,106,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,
18,0,0,0,30,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,0,43,0,0,0,35,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,82,101,115,112,111,110,115,101,23,0,0,0,15,0,0,0,115,97,109,112,108,101,46,82,101,115,112,111,110,115,101,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,21,0,0,0,7,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,16,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,1,0,0,0,120,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,22,0,0,0,8,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,4,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,112,105,112,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,23,0,0,0,24,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,
98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,102,97,99,116,111,114,121,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0]);

  // Deserialize RuntimeTypeInfo
  var bdata = new ByteData.view(serializedRuntimeTypeInfo.buffer);
  var message = new bindings.Message(bdata, null, serializedRuntimeTypeInfo.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
