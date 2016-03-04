// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_service_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _EchoServiceEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  _EchoServiceEchoStringParams() : super(kVersions.last.size);

  static _EchoServiceEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceEchoStringParams result = new _EchoServiceEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _EchoServiceEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_EchoServiceEchoStringParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class EchoServiceEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceEchoStringResponseParams() : super(kVersions.last.size);

  static EchoServiceEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceEchoStringResponseParams result = new EchoServiceEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct EchoServiceEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoServiceEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _EchoServiceDelayedEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String value = null;
  int millis = 0;

  _EchoServiceDelayedEchoStringParams() : super(kVersions.last.size);

  static _EchoServiceDelayedEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceDelayedEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceDelayedEchoStringParams result = new _EchoServiceDelayedEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.millis = decoder0.decodeInt32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _EchoServiceDelayedEchoStringParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(millis, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "millis of struct _EchoServiceDelayedEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_EchoServiceDelayedEchoStringParams("
           "value: $value" ", "
           "millis: $millis" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    map["millis"] = millis;
    return map;
  }
}


class EchoServiceDelayedEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceDelayedEchoStringResponseParams() : super(kVersions.last.size);

  static EchoServiceDelayedEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceDelayedEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceDelayedEchoStringResponseParams result = new EchoServiceDelayedEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct EchoServiceDelayedEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoServiceDelayedEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _EchoServiceQuitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _EchoServiceQuitParams() : super(kVersions.last.size);

  static _EchoServiceQuitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceQuitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceQuitParams result = new _EchoServiceQuitParams();

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
    return "_EchoServiceQuitParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _EchoService_echoStringName = 0;
const int _EchoService_delayedEchoStringName = 1;
const int _EchoService_quitName = 2;

class _EchoServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().servicesByName["test::EchoService"].topLevelInterface;
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class EchoService {
  static const String serviceName = "test::EchoService";
  dynamic echoString(String value,[Function responseFactory = null]);
  dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]);
  void quit();
}


class _EchoServiceProxyImpl extends bindings.Proxy {
  _EchoServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _EchoServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _EchoServiceProxyImpl.unbound() : super.unbound();

  static _EchoServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _EchoServiceProxyImpl"));
    return new _EchoServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _EchoServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _EchoService_echoStringName:
        var r = EchoServiceEchoStringResponseParams.deserialize(
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
      case _EchoService_delayedEchoStringName:
        var r = EchoServiceDelayedEchoStringResponseParams.deserialize(
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
    return "_EchoServiceProxyImpl($superString)";
  }
}


class _EchoServiceProxyCalls implements EchoService {
  _EchoServiceProxyImpl _proxyImpl;

  _EchoServiceProxyCalls(this._proxyImpl);
    dynamic echoString(String value,[Function responseFactory = null]) {
      var params = new _EchoServiceEchoStringParams();
      params.value = value;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _EchoService_echoStringName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]) {
      var params = new _EchoServiceDelayedEchoStringParams();
      params.value = value;
      params.millis = millis;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _EchoService_delayedEchoStringName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void quit() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _EchoServiceQuitParams();
      _proxyImpl.sendMessage(params, _EchoService_quitName);
    }
}


class EchoServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  EchoService ptr;

  EchoServiceProxy(_EchoServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _EchoServiceProxyCalls(proxyImpl);

  EchoServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _EchoServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  EchoServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _EchoServiceProxyImpl.fromHandle(handle) {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  EchoServiceProxy.unbound() :
      impl = new _EchoServiceProxyImpl.unbound() {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  factory EchoServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    EchoServiceProxy p = new EchoServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static EchoServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceProxy"));
    return new EchoServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => EchoService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "EchoServiceProxy($impl)";
  }
}


class EchoServiceStub extends bindings.Stub {
  EchoService _impl = null;

  EchoServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  EchoServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  EchoServiceStub.unbound() : super.unbound();

  static EchoServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceStub"));
    return new EchoServiceStub.fromEndpoint(endpoint);
  }


  EchoServiceEchoStringResponseParams _EchoServiceEchoStringResponseParamsFactory(String value) {
    var mojo_factory_result = new EchoServiceEchoStringResponseParams();
    mojo_factory_result.value = value;
    return mojo_factory_result;
  }
  EchoServiceDelayedEchoStringResponseParams _EchoServiceDelayedEchoStringResponseParamsFactory(String value) {
    var mojo_factory_result = new EchoServiceDelayedEchoStringResponseParams();
    mojo_factory_result.value = value;
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
      case _EchoService_echoStringName:
        var params = _EchoServiceEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.value,_EchoServiceEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _EchoService_echoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _EchoService_echoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _EchoService_delayedEchoStringName:
        var params = _EchoServiceDelayedEchoStringParams.deserialize(
            message.payload);
        var response = _impl.delayedEchoString(params.value,params.millis,_EchoServiceDelayedEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _EchoService_delayedEchoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _EchoService_delayedEchoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _EchoService_quitName:
        _impl.quit();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  EchoService get impl => _impl;
  set impl(EchoService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "EchoServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _EchoServiceServiceDescription();
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
  var serializedRuntimeTypeInfo = new Uint8List.fromList(const [24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,216,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,25,0,0,0,17,0,0,0,116,101,115,116,58,58,69,99,104,111,83,101,114,118,105,99,101,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,33,0,0,0,25,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,69,99,104,111,83,101,114,118,105,99,101,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,33,0,0,0,25,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,69,99,104,111,83,101,114,118,105,99,101,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,33,0,0,0,25,0,0,0,84,89,80,69,95,75,69,89,58,116,101,115,116,46,69,99,104,111,83,101,114,118,105,99,101,0,0,0,0,0,0,0,24,0,0,0,1,0,0,0,16,0,0,0,3,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,104,1,0,0,0,0,0,0,128,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,152,0,0,0,0,0,0,0,168,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,176,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,7,0,0,0,32,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,83,101,114,118,105,99,101,78,97,109,101,0,0,0,0,0,25,0,0,0,17,0,0,0,116,101,115,116,58,58,69,99,104,111,83,101,114,118,105,99,101,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,69,99,104,111,83,101,114,118,105,99,101,0,0,0,0,0,24,0,0,0,16,0,0,0,116,101,115,116,46,69,99,104,111,83,101,114,118,105,99,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,10,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,25,0,0,0,17,0,0,0,116,101,115,116,58,58,69,99,104,111,83,101,114,118,105,99,101,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,20,0,0,0,3,0,0,0,0,0,0,0,1,0,0,0,2,0,0,0,0,0,0,0,32,0,0,0,3,0,0,0,24,0,0,0,0,0,0,0,96,5,0,0,0,0,0,0,208,11,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,16,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,69,99,104,111,83,116,114,105,110,103,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,9,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,
100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,26,0,0,0,18,0,0,0,69,99,104,111,83,116,114,105,110,103,45,114,101,113,117,101,115,116,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,118,97,108,117,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,9,0,0,0,21,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,27,0,0,0,19,0,0,0,69,99,104,111,83,116,114,105,110,103,45,114,101,115,112,111,110,115,101,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,118,97,108,117,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,9,0,0,0,40,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,48,4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,17,0,0,0,68,101,108,97,121,101,100,69,99,104,111,83,116,114,105,110,103,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33,0,0,0,25,0,0,0,68,101,108,97,121,101,100,69,99,104,111,83,116,114,105,110,103,45,114,101,113,117,101,115,116,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,32,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,118,97,108,117,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,28,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,
16,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0,0,0,6,0,0,0,109,105,108,108,105,115,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,41,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,68,101,108,97,121,101,100,69,99,104,111,83,116,114,105,110,103,45,114,101,115,112,111,110,115,101,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,118,97,108,117,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,61,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,81,117,105,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,11,0,0,0,2,0,0,0,91,0,0,0,83,0,0,0,
47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,0,0,0,12,0,0,0,81,117,105,116,45,114,101,113,117,101,115,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,91,0,0,0,83,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,100,97,114,116,47,97,112,112,116,101,115,116,115,47,116,101,115,116,95,97,112,112,115,47,105,110,116,101,114,102,97,99,101,115,47,101,99,104,111,95,115,101,114,118,105,99,101,46,109,111,106,111,109,0,0,0,0,0,8,0,0,0,0,0,0,0]);

  // Deserialize RuntimeTypeInfo
  var bdata = new ByteData.view(serializedRuntimeTypeInfo.buffer);
  var message = new bindings.Message(bdata, null, serializedRuntimeTypeInfo.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
