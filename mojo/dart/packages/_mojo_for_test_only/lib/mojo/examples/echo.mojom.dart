// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _EchoEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  _EchoEchoStringParams() : super(kVersions.last.size);

  static _EchoEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoEchoStringParams result = new _EchoEchoStringParams();

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
          "value of struct _EchoEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_EchoEchoStringParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class EchoEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoEchoStringResponseParams() : super(kVersions.last.size);

  static EchoEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoEchoStringResponseParams result = new EchoEchoStringResponseParams();

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
          "value of struct EchoEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}

const int _Echo_echoStringName = 0;

class _EchoServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().servicesByName["mojo::examples::Echo"].topLevelInterface;
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class Echo {
  static const String serviceName = "mojo::examples::Echo";
  dynamic echoString(String value,[Function responseFactory = null]);
}


class _EchoProxyImpl extends bindings.Proxy {
  _EchoProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _EchoProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _EchoProxyImpl.unbound() : super.unbound();

  static _EchoProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _EchoProxyImpl"));
    return new _EchoProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _EchoServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Echo_echoStringName:
        var r = EchoEchoStringResponseParams.deserialize(
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
    return "_EchoProxyImpl($superString)";
  }
}


class _EchoProxyCalls implements Echo {
  _EchoProxyImpl _proxyImpl;

  _EchoProxyCalls(this._proxyImpl);
    dynamic echoString(String value,[Function responseFactory = null]) {
      var params = new _EchoEchoStringParams();
      params.value = value;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Echo_echoStringName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class EchoProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Echo ptr;

  EchoProxy(_EchoProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _EchoProxyCalls(proxyImpl);

  EchoProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _EchoProxyImpl.fromEndpoint(endpoint) {
    ptr = new _EchoProxyCalls(impl);
  }

  EchoProxy.fromHandle(core.MojoHandle handle) :
      impl = new _EchoProxyImpl.fromHandle(handle) {
    ptr = new _EchoProxyCalls(impl);
  }

  EchoProxy.unbound() :
      impl = new _EchoProxyImpl.unbound() {
    ptr = new _EchoProxyCalls(impl);
  }

  factory EchoProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    EchoProxy p = new EchoProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static EchoProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoProxy"));
    return new EchoProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Echo.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "EchoProxy($impl)";
  }
}


class EchoStub extends bindings.Stub {
  Echo _impl = null;

  EchoStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  EchoStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  EchoStub.unbound() : super.unbound();

  static EchoStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoStub"));
    return new EchoStub.fromEndpoint(endpoint);
  }


  EchoEchoStringResponseParams _EchoEchoStringResponseParamsFactory(String value) {
    var mojo_factory_result = new EchoEchoStringResponseParams();
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
      case _Echo_echoStringName:
        var params = _EchoEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.value,_EchoEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Echo_echoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Echo_echoStringName,
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

  Echo get impl => _impl;
  set impl(Echo d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "EchoStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _EchoServiceDescription();
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
  var serializedRuntimeTypeInfo = new Uint8List.fromList(const [24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,216,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,28,0,0,0,20,0,0,0,109,111,106,111,58,58,101,120,97,109,112,108,101,115,58,58,69,99,104,111,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,35,0,0,0,27,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,101,120,97,109,112,108,101,115,46,69,99,104,111,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,35,0,0,0,27,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,101,120,97,109,112,108,101,115,46,69,99,104,111,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,35,0,0,0,27,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,101,120,97,109,112,108,101,115,46,69,99,104,111,0,0,0,0,0,24,0,0,0,1,0,0,0,16,0,0,0,3,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,72,1,0,0,0,0,0,0,96,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,152,0,0,0,0,0,0,0,160,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,176,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,7,0,0,0,32,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,83,101,114,118,105,99,101,78,97,109,101,0,0,0,0,0,28,0,0,0,20,0,0,0,109,111,106,111,58,58,101,120,97,109,112,108,101,115,58,58,69,99,104,111,0,0,0,0,12,0,0,0,4,0,0,0,69,99,104,111,0,0,0,0,26,0,0,0,18,0,0,0,109,111,106,111,46,101,120,97,109,112,108,101,115,46,69,99,104,111,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,10,0,0,0,57,0,0,0,49,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,101,120,97,109,112,108,101,115,47,101,99,104,111,47,101,99,104,111,46,109,111,106,111,109,0,0,0,0,0,0,0,28,0,0,0,20,0,0,0,109,111,106,111,58,58,101,120,97,109,112,108,101,115,58,58,69,99,104,111,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,12,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,208,0,0,0,0,0,0,0,176,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,69,99,104,111,83,116,114,105,110,103,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,9,0,0,0,2,0,0,0,57,0,0,0,49,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,101,120,97,109,112,108,101,115,47,101,99,104,111,47,101,99,104,111,46,109,111,106,111,109,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,
24,0,0,0,0,0,0,0,208,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,26,0,0,0,18,0,0,0,69,99,104,111,83,116,114,105,110,103,45,114,101,113,117,101,115,116,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,57,0,0,0,49,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,101,120,97,109,112,108,101,115,47,101,99,104,111,47,101,99,104,111,46,109,111,106,111,109,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,208,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,118,97,108,117,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,9,0,0,0,21,0,0,0,57,0,0,0,49,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,101,120,97,109,112,108,101,115,47,101,99,104,111,47,101,99,104,111,46,109,111,106,111,109,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,208,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,27,0,0,0,19,0,0,0,69,99,104,111,83,116,114,105,110,103,45,114,101,115,112,111,110,115,101,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,57,0,0,0,49,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,101,120,97,109,112,108,101,115,47,101,99,104,111,47,101,99,104,111,46,109,111,106,111,109,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,208,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,118,97,108,117,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,9,0,0,0,40,0,0,0,57,0,0,0,49,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,101,120,97,109,112,108,101,115,47,101,99,104,111,47,101,99,104,111,46,109,111,106,111,109,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]);

  // Deserialize RuntimeTypeInfo
  var bdata = new ByteData.view(serializedRuntimeTypeInfo.buffer);
  var message = new bindings.Message(bdata, null, serializedRuntimeTypeInfo.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
