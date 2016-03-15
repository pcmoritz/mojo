// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library math_calculator_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _CalculatorClearParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CalculatorClearParams() : super(kVersions.last.size);

  static _CalculatorClearParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CalculatorClearParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CalculatorClearParams result = new _CalculatorClearParams();

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
    return "_CalculatorClearParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CalculatorClearResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  CalculatorClearResponseParams() : super(kVersions.last.size);

  static CalculatorClearResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CalculatorClearResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CalculatorClearResponseParams result = new CalculatorClearResponseParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct CalculatorClearResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CalculatorClearResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _CalculatorAddParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  _CalculatorAddParams() : super(kVersions.last.size);

  static _CalculatorAddParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CalculatorAddParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CalculatorAddParams result = new _CalculatorAddParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _CalculatorAddParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CalculatorAddParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class CalculatorAddResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  CalculatorAddResponseParams() : super(kVersions.last.size);

  static CalculatorAddResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CalculatorAddResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CalculatorAddResponseParams result = new CalculatorAddResponseParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct CalculatorAddResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CalculatorAddResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _CalculatorMultiplyParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  _CalculatorMultiplyParams() : super(kVersions.last.size);

  static _CalculatorMultiplyParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CalculatorMultiplyParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CalculatorMultiplyParams result = new _CalculatorMultiplyParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _CalculatorMultiplyParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CalculatorMultiplyParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class CalculatorMultiplyResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  CalculatorMultiplyResponseParams() : super(kVersions.last.size);

  static CalculatorMultiplyResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CalculatorMultiplyResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CalculatorMultiplyResponseParams result = new CalculatorMultiplyResponseParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct CalculatorMultiplyResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CalculatorMultiplyResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}

const int _Calculator_clearName = 0;
const int _Calculator_addName = 1;
const int _Calculator_multiplyName = 2;

class _CalculatorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Calculator {
  static const String serviceName = null;
  dynamic clear([Function responseFactory = null]);
  dynamic add(double value,[Function responseFactory = null]);
  dynamic multiply(double value,[Function responseFactory = null]);
}


class _CalculatorProxyImpl extends bindings.Proxy {
  _CalculatorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CalculatorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CalculatorProxyImpl.unbound() : super.unbound();

  static _CalculatorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CalculatorProxyImpl"));
    return new _CalculatorProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CalculatorServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Calculator_clearName:
        var r = CalculatorClearResponseParams.deserialize(
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
      case _Calculator_addName:
        var r = CalculatorAddResponseParams.deserialize(
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
      case _Calculator_multiplyName:
        var r = CalculatorMultiplyResponseParams.deserialize(
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
    return "_CalculatorProxyImpl($superString)";
  }
}


class _CalculatorProxyCalls implements Calculator {
  _CalculatorProxyImpl _proxyImpl;

  _CalculatorProxyCalls(this._proxyImpl);
    dynamic clear([Function responseFactory = null]) {
      var params = new _CalculatorClearParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Calculator_clearName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic add(double value,[Function responseFactory = null]) {
      var params = new _CalculatorAddParams();
      params.value = value;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Calculator_addName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic multiply(double value,[Function responseFactory = null]) {
      var params = new _CalculatorMultiplyParams();
      params.value = value;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Calculator_multiplyName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CalculatorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Calculator ptr;

  CalculatorProxy(_CalculatorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CalculatorProxyCalls(proxyImpl);

  CalculatorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CalculatorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CalculatorProxyCalls(impl);
  }

  CalculatorProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CalculatorProxyImpl.fromHandle(handle) {
    ptr = new _CalculatorProxyCalls(impl);
  }

  CalculatorProxy.unbound() :
      impl = new _CalculatorProxyImpl.unbound() {
    ptr = new _CalculatorProxyCalls(impl);
  }

  factory CalculatorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CalculatorProxy p = new CalculatorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CalculatorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CalculatorProxy"));
    return new CalculatorProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Calculator.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CalculatorProxy($impl)";
  }
}


class CalculatorStub extends bindings.Stub {
  Calculator _impl = null;

  CalculatorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CalculatorStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CalculatorStub.unbound() : super.unbound();

  static CalculatorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CalculatorStub"));
    return new CalculatorStub.fromEndpoint(endpoint);
  }


  CalculatorClearResponseParams _CalculatorClearResponseParamsFactory(double value) {
    var mojo_factory_result = new CalculatorClearResponseParams();
    mojo_factory_result.value = value;
    return mojo_factory_result;
  }
  CalculatorAddResponseParams _CalculatorAddResponseParamsFactory(double value) {
    var mojo_factory_result = new CalculatorAddResponseParams();
    mojo_factory_result.value = value;
    return mojo_factory_result;
  }
  CalculatorMultiplyResponseParams _CalculatorMultiplyResponseParamsFactory(double value) {
    var mojo_factory_result = new CalculatorMultiplyResponseParams();
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
      case _Calculator_clearName:
        var response = _impl.clear(_CalculatorClearResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Calculator_clearName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Calculator_clearName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Calculator_addName:
        var params = _CalculatorAddParams.deserialize(
            message.payload);
        var response = _impl.add(params.value,_CalculatorAddResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Calculator_addName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Calculator_addName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Calculator_multiplyName:
        var params = _CalculatorMultiplyParams.deserialize(
            message.payload);
        var response = _impl.multiply(params.value,_CalculatorMultiplyResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Calculator_multiplyName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Calculator_multiplyName,
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

  Calculator get impl => _impl;
  set impl(Calculator d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CalculatorStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CalculatorServiceDescription();
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+yVy0/6QBDHS/n9IuALn+CNxAsXWY7EE8aQmBgTD15ITEhpV6npA/sw8b/1yNEjN93aWViWXYEa0JBOMhkou+1+vsx8W1biKEKtQ+Wv05rjKr+uwXzPMOsqsPaufdvqXLfa57YW9GqXmqWHlha4XhnWR/uy3D72OTSGUK+U6fggQTmazDXZ+ij2SRZIjk8UXy+R3CXJHXeKewP230eMJFHPtTHyQsO1TQd7yHafXOR7evyhH3YtU0emE2DvQdOxj7qmY5jOo48C7Ac+ih7X0UePq0W7bJHeVJ9D0E0BHVXm9yyzr/IPdMnHtcrdZwD1LTOpj0y3ukB79r58bJP8H+lsYc0T8OTg7MvWke+rgTKbl+0rnrcu4T0C5i/eMw8/h+RcAm4ay+aWzdWy+I9J7jD8ft91fPx7/LwvNQW+RWdonph3LmjMmosXzQqxZC5KK9BH5gdDdVIXEXcmgR9sgj9dGIbwfZJfMz84AGbCy7hBOg+LzkMe3svr0hfR+3tr1BfUJdO+SNIXp3/AJ9VvuNUEPlmE/+ImtAKzb73y3IU188kysFFeapbpPCw2DwXwllX3xfsP+6Ih4T0huTfZF2OzTP0yUX9UV6DPZwAAAP//kOzgLGgQAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
