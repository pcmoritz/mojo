// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
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

const int _echoMethodEchoStringName = 0;

class _EchoServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().services["mojo::examples::Echo"];
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
      case _echoMethodEchoStringName:
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
          _echoMethodEchoStringName,
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


  EchoEchoStringResponseParams _echoEchoStringResponseParamsFactory(String value) {
    var result = new EchoEchoStringResponseParams();
    result.value = value;
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
      case _echoMethodEchoStringName:
        var params = _EchoEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.value,_echoEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _echoMethodEchoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _echoMethodEchoStringName,
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
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/5JggAABKN0BpdHFLZD4jEDMAeXLALEIEOfmZ+VbWaVWJOYW5KQWW1m5JmfkY1OvDMTSQBwSGeAa7+0aaQXSqAfTpwfThmG/Aw77STGPEaqfGUm/BpRWgNIejBA6AUozoNkPC4cZUHoBlP4PBRsYsAN0dytgCWd2JHFhIOYG4uDUorLM5FS/xNxUosKbB4hZgBjGlwJiIah6LMGCEc6cQMwFxJZAbAjE+hn5uan6RaUp+bmZealF+iBz9IuLkvVhZumnAs0CE3oguVwi0wW6vTA+DzSccIUbenydgNFM2OMLBgzQ+KC4wiYOA0LQcAC5N7ikKDMvHXt4gdQwUSG80NMD3F+MxPsHBCxw+AeWDhD+0S1KLSxNLS7B7i8YoNRf6PHngKM8ucBAHCA2XjVw6OcFYlYgLkvMKU3FEZ+iVPI3A1JaRg8HCSQ3MSKpp3U6kIaWLSjpoLggP684dTQdoKUDjQFMB4AAAAD//1YHjLGYBwAA";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
