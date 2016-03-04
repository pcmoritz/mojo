// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library pingpong_service_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _PingPongServiceSetClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object client = null;

  _PingPongServiceSetClientParams() : super(kVersions.last.size);

  static _PingPongServiceSetClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceSetClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceSetClientParams result = new _PingPongServiceSetClientParams();

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
      
      result.client = decoder0.decodeServiceInterface(8, false, PingPongClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(client, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct _PingPongServiceSetClientParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServiceSetClientParams("
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _PingPongServicePingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int pingValue = 0;

  _PingPongServicePingParams() : super(kVersions.last.size);

  static _PingPongServicePingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingParams result = new _PingPongServicePingParams();

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
      
      result.pingValue = decoder0.decodeUint16(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint16(pingValue, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pingValue of struct _PingPongServicePingParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingParams("
           "pingValue: $pingValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pingValue"] = pingValue;
    return map;
  }
}


class _PingPongServicePingTargetUrlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String url = null;
  int count = 0;

  _PingPongServicePingTargetUrlParams() : super(kVersions.last.size);

  static _PingPongServicePingTargetUrlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingTargetUrlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingTargetUrlParams result = new _PingPongServicePingTargetUrlParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.count = decoder0.decodeUint16(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _PingPongServicePingTargetUrlParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(count, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "count of struct _PingPongServicePingTargetUrlParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingTargetUrlParams("
           "url: $url" ", "
           "count: $count" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    map["count"] = count;
    return map;
  }
}


class PingPongServicePingTargetUrlResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool ok = false;

  PingPongServicePingTargetUrlResponseParams() : super(kVersions.last.size);

  static PingPongServicePingTargetUrlResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PingPongServicePingTargetUrlResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PingPongServicePingTargetUrlResponseParams result = new PingPongServicePingTargetUrlResponseParams();

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
      
      result.ok = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(ok, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ok of struct PingPongServicePingTargetUrlResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PingPongServicePingTargetUrlResponseParams("
           "ok: $ok" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["ok"] = ok;
    return map;
  }
}


class _PingPongServicePingTargetServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object service = null;
  int count = 0;

  _PingPongServicePingTargetServiceParams() : super(kVersions.last.size);

  static _PingPongServicePingTargetServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingTargetServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingTargetServiceParams result = new _PingPongServicePingTargetServiceParams();

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
      
      result.service = decoder0.decodeServiceInterface(8, false, PingPongServiceProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.count = decoder0.decodeUint16(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(service, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "service of struct _PingPongServicePingTargetServiceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(count, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "count of struct _PingPongServicePingTargetServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingTargetServiceParams("
           "service: $service" ", "
           "count: $count" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class PingPongServicePingTargetServiceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool ok = false;

  PingPongServicePingTargetServiceResponseParams() : super(kVersions.last.size);

  static PingPongServicePingTargetServiceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PingPongServicePingTargetServiceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PingPongServicePingTargetServiceResponseParams result = new PingPongServicePingTargetServiceResponseParams();

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
      
      result.ok = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(ok, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ok of struct PingPongServicePingTargetServiceResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PingPongServicePingTargetServiceResponseParams("
           "ok: $ok" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["ok"] = ok;
    return map;
  }
}


class _PingPongServiceGetPingPongServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object service = null;

  _PingPongServiceGetPingPongServiceParams() : super(kVersions.last.size);

  static _PingPongServiceGetPingPongServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceGetPingPongServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceGetPingPongServiceParams result = new _PingPongServiceGetPingPongServiceParams();

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
      
      result.service = decoder0.decodeInterfaceRequest(8, false, PingPongServiceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(service, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "service of struct _PingPongServiceGetPingPongServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServiceGetPingPongServiceParams("
           "service: $service" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _PingPongServiceQuitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _PingPongServiceQuitParams() : super(kVersions.last.size);

  static _PingPongServiceQuitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceQuitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceQuitParams result = new _PingPongServiceQuitParams();

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
    return "_PingPongServiceQuitParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _PingPongClientPongParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int pongValue = 0;

  _PingPongClientPongParams() : super(kVersions.last.size);

  static _PingPongClientPongParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongClientPongParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongClientPongParams result = new _PingPongClientPongParams();

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
      
      result.pongValue = decoder0.decodeUint16(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint16(pongValue, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pongValue of struct _PingPongClientPongParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongClientPongParams("
           "pongValue: $pongValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pongValue"] = pongValue;
    return map;
  }
}

const int _PingPongService_setClientName = 0;
const int _PingPongService_pingName = 1;
const int _PingPongService_pingTargetUrlName = 2;
const int _PingPongService_pingTargetServiceName = 3;
const int _PingPongService_getPingPongServiceName = 4;
const int _PingPongService_quitName = 5;

class _PingPongServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().servicesByName["test::PingPongService"].topLevelInterface;
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class PingPongService {
  static const String serviceName = "test::PingPongService";
  void setClient(Object client);
  void ping(int pingValue);
  dynamic pingTargetUrl(String url,int count,[Function responseFactory = null]);
  dynamic pingTargetService(Object service,int count,[Function responseFactory = null]);
  void getPingPongService(Object service);
  void quit();
}


class _PingPongServiceProxyImpl extends bindings.Proxy {
  _PingPongServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _PingPongServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _PingPongServiceProxyImpl.unbound() : super.unbound();

  static _PingPongServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _PingPongServiceProxyImpl"));
    return new _PingPongServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _PingPongServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _PingPongService_pingTargetUrlName:
        var r = PingPongServicePingTargetUrlResponseParams.deserialize(
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
      case _PingPongService_pingTargetServiceName:
        var r = PingPongServicePingTargetServiceResponseParams.deserialize(
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
    return "_PingPongServiceProxyImpl($superString)";
  }
}


class _PingPongServiceProxyCalls implements PingPongService {
  _PingPongServiceProxyImpl _proxyImpl;

  _PingPongServiceProxyCalls(this._proxyImpl);
    void setClient(Object client) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongServiceSetClientParams();
      params.client = client;
      _proxyImpl.sendMessage(params, _PingPongService_setClientName);
    }
    void ping(int pingValue) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongServicePingParams();
      params.pingValue = pingValue;
      _proxyImpl.sendMessage(params, _PingPongService_pingName);
    }
    dynamic pingTargetUrl(String url,int count,[Function responseFactory = null]) {
      var params = new _PingPongServicePingTargetUrlParams();
      params.url = url;
      params.count = count;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _PingPongService_pingTargetUrlName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic pingTargetService(Object service,int count,[Function responseFactory = null]) {
      var params = new _PingPongServicePingTargetServiceParams();
      params.service = service;
      params.count = count;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _PingPongService_pingTargetServiceName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getPingPongService(Object service) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongServiceGetPingPongServiceParams();
      params.service = service;
      _proxyImpl.sendMessage(params, _PingPongService_getPingPongServiceName);
    }
    void quit() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongServiceQuitParams();
      _proxyImpl.sendMessage(params, _PingPongService_quitName);
    }
}


class PingPongServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  PingPongService ptr;

  PingPongServiceProxy(_PingPongServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _PingPongServiceProxyCalls(proxyImpl);

  PingPongServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _PingPongServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _PingPongServiceProxyCalls(impl);
  }

  PingPongServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _PingPongServiceProxyImpl.fromHandle(handle) {
    ptr = new _PingPongServiceProxyCalls(impl);
  }

  PingPongServiceProxy.unbound() :
      impl = new _PingPongServiceProxyImpl.unbound() {
    ptr = new _PingPongServiceProxyCalls(impl);
  }

  factory PingPongServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    PingPongServiceProxy p = new PingPongServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static PingPongServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongServiceProxy"));
    return new PingPongServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => PingPongService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "PingPongServiceProxy($impl)";
  }
}


class PingPongServiceStub extends bindings.Stub {
  PingPongService _impl = null;

  PingPongServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  PingPongServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  PingPongServiceStub.unbound() : super.unbound();

  static PingPongServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongServiceStub"));
    return new PingPongServiceStub.fromEndpoint(endpoint);
  }


  PingPongServicePingTargetUrlResponseParams _PingPongServicePingTargetUrlResponseParamsFactory(bool ok) {
    var mojo_factory_result = new PingPongServicePingTargetUrlResponseParams();
    mojo_factory_result.ok = ok;
    return mojo_factory_result;
  }
  PingPongServicePingTargetServiceResponseParams _PingPongServicePingTargetServiceResponseParamsFactory(bool ok) {
    var mojo_factory_result = new PingPongServicePingTargetServiceResponseParams();
    mojo_factory_result.ok = ok;
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
      case _PingPongService_setClientName:
        var params = _PingPongServiceSetClientParams.deserialize(
            message.payload);
        _impl.setClient(params.client);
        break;
      case _PingPongService_pingName:
        var params = _PingPongServicePingParams.deserialize(
            message.payload);
        _impl.ping(params.pingValue);
        break;
      case _PingPongService_pingTargetUrlName:
        var params = _PingPongServicePingTargetUrlParams.deserialize(
            message.payload);
        var response = _impl.pingTargetUrl(params.url,params.count,_PingPongServicePingTargetUrlResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _PingPongService_pingTargetUrlName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _PingPongService_pingTargetUrlName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _PingPongService_pingTargetServiceName:
        var params = _PingPongServicePingTargetServiceParams.deserialize(
            message.payload);
        var response = _impl.pingTargetService(params.service,params.count,_PingPongServicePingTargetServiceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _PingPongService_pingTargetServiceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _PingPongService_pingTargetServiceName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _PingPongService_getPingPongServiceName:
        var params = _PingPongServiceGetPingPongServiceParams.deserialize(
            message.payload);
        _impl.getPingPongService(params.service);
        break;
      case _PingPongService_quitName:
        _impl.quit();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  PingPongService get impl => _impl;
  set impl(PingPongService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "PingPongServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _PingPongServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _PingPongClient_pongName = 0;

class _PingPongClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class PingPongClient {
  static const String serviceName = null;
  void pong(int pongValue);
}


class _PingPongClientProxyImpl extends bindings.Proxy {
  _PingPongClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _PingPongClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _PingPongClientProxyImpl.unbound() : super.unbound();

  static _PingPongClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _PingPongClientProxyImpl"));
    return new _PingPongClientProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _PingPongClientServiceDescription();

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
    return "_PingPongClientProxyImpl($superString)";
  }
}


class _PingPongClientProxyCalls implements PingPongClient {
  _PingPongClientProxyImpl _proxyImpl;

  _PingPongClientProxyCalls(this._proxyImpl);
    void pong(int pongValue) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongClientPongParams();
      params.pongValue = pongValue;
      _proxyImpl.sendMessage(params, _PingPongClient_pongName);
    }
}


class PingPongClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  PingPongClient ptr;

  PingPongClientProxy(_PingPongClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _PingPongClientProxyCalls(proxyImpl);

  PingPongClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _PingPongClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _PingPongClientProxyCalls(impl);
  }

  PingPongClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _PingPongClientProxyImpl.fromHandle(handle) {
    ptr = new _PingPongClientProxyCalls(impl);
  }

  PingPongClientProxy.unbound() :
      impl = new _PingPongClientProxyImpl.unbound() {
    ptr = new _PingPongClientProxyCalls(impl);
  }

  factory PingPongClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    PingPongClientProxy p = new PingPongClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static PingPongClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongClientProxy"));
    return new PingPongClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => PingPongClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "PingPongClientProxy($impl)";
  }
}


class PingPongClientStub extends bindings.Stub {
  PingPongClient _impl = null;

  PingPongClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  PingPongClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  PingPongClientStub.unbound() : super.unbound();

  static PingPongClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongClientStub"));
    return new PingPongClientStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _PingPongClient_pongName:
        var params = _PingPongClientPongParams.deserialize(
            message.payload);
        _impl.pong(params.pongValue);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  PingPongClient get impl => _impl;
  set impl(PingPongClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "PingPongClientStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _PingPongClientServiceDescription();
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
  var serializedRuntimeTypeInfo = new Uint8List.fromList(const [24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,1,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,29,0,0,0,21,0,0,0,116,101,115,116,58,58,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,37,0,0,0,29,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,36,0,0,0,28,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,80,105,110,103,80,111,110,103,67,108,105,101,110,116,0,0,0,0,37,0,0,0,29,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,112,0,0,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,37,0,0,0,29,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,36,0,0,0,28,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,80,105,110,103,80,111,110,103,67,108,105,101,110,116,0,0,0,0,40,0,0,0,2,0,0,0,16,0,0,0,3,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,40,27,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,112,1,0,0,0,0,0,0,136,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,152,0,0,0,0,0,0,0,168,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,184,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,7,0,0,0,32,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,83,101,114,118,105,99,101,78,97,109,101,0,0,0,0,0,29,0,0,0,21,0,0,0,116,101,115,116,58,58,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,23,0,0,0,15,0,0,0,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,28,0,0,0,20,0,0,0,116,101,115,116,46,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,10,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,29,0,0,0,21,0,0,0,116,101,115,116,58,58,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,6,0,0,0,3,0,0,0,4,0,0,0,5,0,0,0,0,0,0,0,1,0,0,0,2,0,0,0,56,0,0,0,6,0,0,0,48,0,0,0,0,0,0,0,224,6,0,0,0,0,0,0,96,10,0,0,0,0,0,0,80,12,0,0,0,0,0,0,192,15,0,0,0,0,0,0,200,18,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,
128,4,0,0,0,0,0,0,3,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,17,0,0,0,80,105,110,103,84,97,114,103,101,116,83,101,114,118,105,99,101,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,21,0,0,0,2,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33,0,0,0,25,0,0,0,80,105,110,103,84,97,114,103,101,116,83,101,114,118,105,99,101,45,114,101,113,117,101,115,116,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,112,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,115,101,114,118,105,99,101,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,21,0,0,0,36,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,23,0,0,0,15,0,0,0,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,37,0,0,0,29,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,99,111,117,110,116,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,21,0,0,0,52,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,80,105,110,103,84,97,114,103,101,116,83,101,114,118,105,99,101,45,114,101,115,112,111,110,115,101,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,2,0,0,0,111,107,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,21,0,0,0,68,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,26,0,0,0,18,0,0,0,71,101,116,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,2,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,71,101,116,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,45,114,101,113,117,101,115,116,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,115,101,114,118,105,99,101,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,38,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,23,0,0,0,15,0,0,0,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,37,0,0,0,29,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,80,105,110,103,80,111,110,103,83,101,114,118,105,99,101,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,81,117,105,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,27,0,0,0,2,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,0,0,0,12,0,0,0,81,117,105,116,45,114,101,113,117,101,115,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,8,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,0,0,0,9,0,0,0,83,101,116,67,108,105,101,110,116,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,2,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,17,0,0,0,83,101,116,67,108,105,101,110,116,45,114,101,113,117,101,115,116,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0,0,0,6,0,0,0,99,108,105,101,110,116,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,27,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,22,0,0,0,14,0,0,0,80,105,110,103,80,111,110,103,67,108,105,101,110,116,0,0,36,0,0,0,28,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,80,105,110,103,80,111,110,103,67,108,105,101,110,116,0,0,0,0,40,0,0,0,0,0,0,0,
32,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,80,105,110,103,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,13,0,0,0,2,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,0,0,0,12,0,0,0,80,105,110,103,45,114,101,113,117,101,115,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,112,105,110,103,95,118,97,108,117,101,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,13,0,0,0,14,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,32,4,0,0,0,0,0,0,2,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,0,0,0,13,0,0,0,80,105,110,103,84,97,114,103,101,116,85,82,76,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,17,0,0,0,2,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,
116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,29,0,0,0,21,0,0,0,80,105,110,103,84,97,114,103,101,116,85,82,76,45,114,101,113,117,101,115,116,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,32,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,117,114,108,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,17,0,0,0,23,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,99,111,117,110,116,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,17,0,0,0,35,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,30,0,0,0,22,0,0,0,80,105,110,103,84,97,114,103,101,116,85,82,76,45,114,101,115,112,111,110,115,101,0,0,24,0,0,0,0,0,0,0,
16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,2,0,0,0,111,107,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,17,0,0,0,51,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,0,0,0,14,0,0,0,80,105,110,103,80,111,110,103,67,108,105,101,110,116,0,0,27,0,0,0,19,0,0,0,116,101,115,116,46,80,105,110,103,80,111,110,103,67,108,105,101,110,116,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,30,0,0,0,10,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,12,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,80,111,110,103,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,31,0,0,0,2,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,0,0,0,12,0,0,0,80,111,110,103,45,114,101,113,117,101,115,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,112,111,110,103,95,118,97,108,117,101,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,31,0,0,0,14,0,0,0,95,0,0,0,87,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,112,105,110,103,112,111,110,103,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0]);

  // Deserialize RuntimeTypeInfo
  var bdata = new ByteData.view(serializedRuntimeTypeInfo.buffer);
  var message = new bindings.Message(bdata, null, serializedRuntimeTypeInfo.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
