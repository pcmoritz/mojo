// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_containers_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;
import 'package:mojo_services/mojo/ui/layouts.mojom.dart' as layouts_mojom;
import 'package:mojo_services/mojo/ui/view_token.mojom.dart' as view_token_mojom;



class ViewInfo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;

  ViewInfo() : super(kVersions.last.size);

  static ViewInfo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewInfo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewInfo result = new ViewInfo();

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
      result.sceneToken = scene_token_mojom.SceneToken.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(sceneToken, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneToken of struct ViewInfo: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewInfo("
           "sceneToken: $sceneToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    return map;
  }
}


class _ViewContainerSetListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object listener = null;

  _ViewContainerSetListenerParams() : super(kVersions.last.size);

  static _ViewContainerSetListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerSetListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerSetListenerParams result = new _ViewContainerSetListenerParams();

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
      
      result.listener = decoder0.decodeServiceInterface(8, true, ViewContainerListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(listener, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "listener of struct _ViewContainerSetListenerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerSetListenerParams("
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewContainerAddChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  Object childViewOwner = null;

  _ViewContainerAddChildParams() : super(kVersions.last.size);

  static _ViewContainerAddChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerAddChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerAddChildParams result = new _ViewContainerAddChildParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.childViewOwner = decoder0.decodeServiceInterface(12, false, view_token_mojom.ViewOwnerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerAddChildParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(childViewOwner, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childViewOwner of struct _ViewContainerAddChildParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerAddChildParams("
           "childKey: $childKey" ", "
           "childViewOwner: $childViewOwner" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewContainerRemoveChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int childKey = 0;
  Object transferredViewOwner = null;

  _ViewContainerRemoveChildParams() : super(kVersions.last.size);

  static _ViewContainerRemoveChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerRemoveChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerRemoveChildParams result = new _ViewContainerRemoveChildParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.transferredViewOwner = decoder0.decodeInterfaceRequest(12, true, view_token_mojom.ViewOwnerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerRemoveChildParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(transferredViewOwner, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "transferredViewOwner of struct _ViewContainerRemoveChildParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerRemoveChildParams("
           "childKey: $childKey" ", "
           "transferredViewOwner: $transferredViewOwner" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewContainerLayoutChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  layouts_mojom.ViewLayoutParams childLayoutParams = null;

  _ViewContainerLayoutChildParams() : super(kVersions.last.size);

  static _ViewContainerLayoutChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerLayoutChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerLayoutChildParams result = new _ViewContainerLayoutChildParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.childLayoutParams = layouts_mojom.ViewLayoutParams.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerLayoutChildParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(childLayoutParams, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childLayoutParams of struct _ViewContainerLayoutChildParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerLayoutChildParams("
           "childKey: $childKey" ", "
           "childLayoutParams: $childLayoutParams" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    map["childLayoutParams"] = childLayoutParams;
    return map;
  }
}


class ViewContainerLayoutChildResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutInfo info = null;

  ViewContainerLayoutChildResponseParams() : super(kVersions.last.size);

  static ViewContainerLayoutChildResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewContainerLayoutChildResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewContainerLayoutChildResponseParams result = new ViewContainerLayoutChildResponseParams();

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
      result.info = layouts_mojom.ViewLayoutInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(info, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "info of struct ViewContainerLayoutChildResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewContainerLayoutChildResponseParams("
           "info: $info" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["info"] = info;
    return map;
  }
}


class _ViewContainerListenerOnChildAttachedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  ViewInfo childViewInfo = null;

  _ViewContainerListenerOnChildAttachedParams() : super(kVersions.last.size);

  static _ViewContainerListenerOnChildAttachedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerListenerOnChildAttachedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerListenerOnChildAttachedParams result = new _ViewContainerListenerOnChildAttachedParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.childViewInfo = ViewInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerListenerOnChildAttachedParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(childViewInfo, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childViewInfo of struct _ViewContainerListenerOnChildAttachedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerListenerOnChildAttachedParams("
           "childKey: $childKey" ", "
           "childViewInfo: $childViewInfo" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    map["childViewInfo"] = childViewInfo;
    return map;
  }
}


class ViewContainerListenerOnChildAttachedResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewContainerListenerOnChildAttachedResponseParams() : super(kVersions.last.size);

  static ViewContainerListenerOnChildAttachedResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewContainerListenerOnChildAttachedResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewContainerListenerOnChildAttachedResponseParams result = new ViewContainerListenerOnChildAttachedResponseParams();

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
    return "ViewContainerListenerOnChildAttachedResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewContainerListenerOnChildUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int childKey = 0;

  _ViewContainerListenerOnChildUnavailableParams() : super(kVersions.last.size);

  static _ViewContainerListenerOnChildUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerListenerOnChildUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerListenerOnChildUnavailableParams result = new _ViewContainerListenerOnChildUnavailableParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerListenerOnChildUnavailableParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerListenerOnChildUnavailableParams("
           "childKey: $childKey" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    return map;
  }
}


class ViewContainerListenerOnChildUnavailableResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewContainerListenerOnChildUnavailableResponseParams() : super(kVersions.last.size);

  static ViewContainerListenerOnChildUnavailableResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewContainerListenerOnChildUnavailableResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewContainerListenerOnChildUnavailableResponseParams result = new ViewContainerListenerOnChildUnavailableResponseParams();

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
    return "ViewContainerListenerOnChildUnavailableResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _ViewContainer_setListenerName = 0;
const int _ViewContainer_addChildName = 1;
const int _ViewContainer_removeChildName = 2;
const int _ViewContainer_layoutChildName = 3;

class _ViewContainerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewContainer {
  static const String serviceName = null;
  void setListener(Object listener);
  void addChild(int childKey, Object childViewOwner);
  void removeChild(int childKey, Object transferredViewOwner);
  dynamic layoutChild(int childKey,layouts_mojom.ViewLayoutParams childLayoutParams,[Function responseFactory = null]);
}


class _ViewContainerProxyImpl extends bindings.Proxy {
  _ViewContainerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewContainerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewContainerProxyImpl.unbound() : super.unbound();

  static _ViewContainerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewContainerProxyImpl"));
    return new _ViewContainerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewContainerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ViewContainer_layoutChildName:
        var r = ViewContainerLayoutChildResponseParams.deserialize(
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
    return "_ViewContainerProxyImpl($superString)";
  }
}


class _ViewContainerProxyCalls implements ViewContainer {
  _ViewContainerProxyImpl _proxyImpl;

  _ViewContainerProxyCalls(this._proxyImpl);
    void setListener(Object listener) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewContainerSetListenerParams();
      params.listener = listener;
      _proxyImpl.sendMessage(params, _ViewContainer_setListenerName);
    }
    void addChild(int childKey, Object childViewOwner) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewContainerAddChildParams();
      params.childKey = childKey;
      params.childViewOwner = childViewOwner;
      _proxyImpl.sendMessage(params, _ViewContainer_addChildName);
    }
    void removeChild(int childKey, Object transferredViewOwner) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewContainerRemoveChildParams();
      params.childKey = childKey;
      params.transferredViewOwner = transferredViewOwner;
      _proxyImpl.sendMessage(params, _ViewContainer_removeChildName);
    }
    dynamic layoutChild(int childKey,layouts_mojom.ViewLayoutParams childLayoutParams,[Function responseFactory = null]) {
      var params = new _ViewContainerLayoutChildParams();
      params.childKey = childKey;
      params.childLayoutParams = childLayoutParams;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewContainer_layoutChildName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewContainerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewContainer ptr;

  ViewContainerProxy(_ViewContainerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewContainerProxyCalls(proxyImpl);

  ViewContainerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewContainerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewContainerProxyCalls(impl);
  }

  ViewContainerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewContainerProxyImpl.fromHandle(handle) {
    ptr = new _ViewContainerProxyCalls(impl);
  }

  ViewContainerProxy.unbound() :
      impl = new _ViewContainerProxyImpl.unbound() {
    ptr = new _ViewContainerProxyCalls(impl);
  }

  factory ViewContainerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewContainerProxy p = new ViewContainerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewContainerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewContainerProxy"));
    return new ViewContainerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewContainer.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewContainerProxy($impl)";
  }
}


class ViewContainerStub extends bindings.Stub {
  ViewContainer _impl = null;

  ViewContainerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewContainerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewContainerStub.unbound() : super.unbound();

  static ViewContainerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewContainerStub"));
    return new ViewContainerStub.fromEndpoint(endpoint);
  }


  ViewContainerLayoutChildResponseParams _ViewContainerLayoutChildResponseParamsFactory(layouts_mojom.ViewLayoutInfo info) {
    var mojo_factory_result = new ViewContainerLayoutChildResponseParams();
    mojo_factory_result.info = info;
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
      case _ViewContainer_setListenerName:
        var params = _ViewContainerSetListenerParams.deserialize(
            message.payload);
        _impl.setListener(params.listener);
        break;
      case _ViewContainer_addChildName:
        var params = _ViewContainerAddChildParams.deserialize(
            message.payload);
        _impl.addChild(params.childKey, params.childViewOwner);
        break;
      case _ViewContainer_removeChildName:
        var params = _ViewContainerRemoveChildParams.deserialize(
            message.payload);
        _impl.removeChild(params.childKey, params.transferredViewOwner);
        break;
      case _ViewContainer_layoutChildName:
        var params = _ViewContainerLayoutChildParams.deserialize(
            message.payload);
        var response = _impl.layoutChild(params.childKey,params.childLayoutParams,_ViewContainerLayoutChildResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewContainer_layoutChildName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewContainer_layoutChildName,
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

  ViewContainer get impl => _impl;
  set impl(ViewContainer d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewContainerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewContainerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _ViewContainerListener_onChildAttachedName = 0;
const int _ViewContainerListener_onChildUnavailableName = 1;

class _ViewContainerListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewContainerListener {
  static const String serviceName = null;
  dynamic onChildAttached(int childKey,ViewInfo childViewInfo,[Function responseFactory = null]);
  dynamic onChildUnavailable(int childKey,[Function responseFactory = null]);
}


class _ViewContainerListenerProxyImpl extends bindings.Proxy {
  _ViewContainerListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewContainerListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewContainerListenerProxyImpl.unbound() : super.unbound();

  static _ViewContainerListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewContainerListenerProxyImpl"));
    return new _ViewContainerListenerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewContainerListenerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ViewContainerListener_onChildAttachedName:
        var r = ViewContainerListenerOnChildAttachedResponseParams.deserialize(
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
      case _ViewContainerListener_onChildUnavailableName:
        var r = ViewContainerListenerOnChildUnavailableResponseParams.deserialize(
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
    return "_ViewContainerListenerProxyImpl($superString)";
  }
}


class _ViewContainerListenerProxyCalls implements ViewContainerListener {
  _ViewContainerListenerProxyImpl _proxyImpl;

  _ViewContainerListenerProxyCalls(this._proxyImpl);
    dynamic onChildAttached(int childKey,ViewInfo childViewInfo,[Function responseFactory = null]) {
      var params = new _ViewContainerListenerOnChildAttachedParams();
      params.childKey = childKey;
      params.childViewInfo = childViewInfo;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewContainerListener_onChildAttachedName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic onChildUnavailable(int childKey,[Function responseFactory = null]) {
      var params = new _ViewContainerListenerOnChildUnavailableParams();
      params.childKey = childKey;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewContainerListener_onChildUnavailableName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewContainerListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewContainerListener ptr;

  ViewContainerListenerProxy(_ViewContainerListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewContainerListenerProxyCalls(proxyImpl);

  ViewContainerListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewContainerListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewContainerListenerProxyCalls(impl);
  }

  ViewContainerListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewContainerListenerProxyImpl.fromHandle(handle) {
    ptr = new _ViewContainerListenerProxyCalls(impl);
  }

  ViewContainerListenerProxy.unbound() :
      impl = new _ViewContainerListenerProxyImpl.unbound() {
    ptr = new _ViewContainerListenerProxyCalls(impl);
  }

  factory ViewContainerListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewContainerListenerProxy p = new ViewContainerListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewContainerListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewContainerListenerProxy"));
    return new ViewContainerListenerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewContainerListener.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewContainerListenerProxy($impl)";
  }
}


class ViewContainerListenerStub extends bindings.Stub {
  ViewContainerListener _impl = null;

  ViewContainerListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewContainerListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewContainerListenerStub.unbound() : super.unbound();

  static ViewContainerListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewContainerListenerStub"));
    return new ViewContainerListenerStub.fromEndpoint(endpoint);
  }


  ViewContainerListenerOnChildAttachedResponseParams _ViewContainerListenerOnChildAttachedResponseParamsFactory() {
    var mojo_factory_result = new ViewContainerListenerOnChildAttachedResponseParams();
    return mojo_factory_result;
  }
  ViewContainerListenerOnChildUnavailableResponseParams _ViewContainerListenerOnChildUnavailableResponseParamsFactory() {
    var mojo_factory_result = new ViewContainerListenerOnChildUnavailableResponseParams();
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
      case _ViewContainerListener_onChildAttachedName:
        var params = _ViewContainerListenerOnChildAttachedParams.deserialize(
            message.payload);
        var response = _impl.onChildAttached(params.childKey,params.childViewInfo,_ViewContainerListenerOnChildAttachedResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewContainerListener_onChildAttachedName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewContainerListener_onChildAttachedName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _ViewContainerListener_onChildUnavailableName:
        var params = _ViewContainerListenerOnChildUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onChildUnavailable(params.childKey,_ViewContainerListenerOnChildUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewContainerListener_onChildUnavailableName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewContainerListener_onChildUnavailableName,
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

  ViewContainerListener get impl => _impl;
  set impl(ViewContainerListener d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewContainerListenerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewContainerListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



