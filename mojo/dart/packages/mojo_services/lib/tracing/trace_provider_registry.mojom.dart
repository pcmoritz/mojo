// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library trace_provider_registry_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/tracing/tracing.mojom.dart' as tracing_mojom;



class _TraceProviderRegistryRegisterTraceProviderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object traceProvider = null;

  _TraceProviderRegistryRegisterTraceProviderParams() : super(kVersions.last.size);

  static _TraceProviderRegistryRegisterTraceProviderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceProviderRegistryRegisterTraceProviderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceProviderRegistryRegisterTraceProviderParams result = new _TraceProviderRegistryRegisterTraceProviderParams();

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
      
      result.traceProvider = decoder0.decodeServiceInterface(8, false, tracing_mojom.TraceProviderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(traceProvider, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "traceProvider of struct _TraceProviderRegistryRegisterTraceProviderParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TraceProviderRegistryRegisterTraceProviderParams("
           "traceProvider: $traceProvider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _traceProviderRegistryMethodRegisterTraceProviderName = 0;

class _TraceProviderRegistryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TraceProviderRegistry {
  static const String serviceName = "tracing.TraceProviderRegistry";
  void registerTraceProvider(Object traceProvider);
}


class _TraceProviderRegistryProxyImpl extends bindings.Proxy {
  _TraceProviderRegistryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TraceProviderRegistryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TraceProviderRegistryProxyImpl.unbound() : super.unbound();

  static _TraceProviderRegistryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TraceProviderRegistryProxyImpl"));
    return new _TraceProviderRegistryProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TraceProviderRegistryServiceDescription();

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
    return "_TraceProviderRegistryProxyImpl($superString)";
  }
}


class _TraceProviderRegistryProxyCalls implements TraceProviderRegistry {
  _TraceProviderRegistryProxyImpl _proxyImpl;

  _TraceProviderRegistryProxyCalls(this._proxyImpl);
    void registerTraceProvider(Object traceProvider) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TraceProviderRegistryRegisterTraceProviderParams();
      params.traceProvider = traceProvider;
      _proxyImpl.sendMessage(params, _traceProviderRegistryMethodRegisterTraceProviderName);
    }
}


class TraceProviderRegistryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TraceProviderRegistry ptr;

  TraceProviderRegistryProxy(_TraceProviderRegistryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TraceProviderRegistryProxyCalls(proxyImpl);

  TraceProviderRegistryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TraceProviderRegistryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TraceProviderRegistryProxyCalls(impl);
  }

  TraceProviderRegistryProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TraceProviderRegistryProxyImpl.fromHandle(handle) {
    ptr = new _TraceProviderRegistryProxyCalls(impl);
  }

  TraceProviderRegistryProxy.unbound() :
      impl = new _TraceProviderRegistryProxyImpl.unbound() {
    ptr = new _TraceProviderRegistryProxyCalls(impl);
  }

  factory TraceProviderRegistryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TraceProviderRegistryProxy p = new TraceProviderRegistryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TraceProviderRegistryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceProviderRegistryProxy"));
    return new TraceProviderRegistryProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TraceProviderRegistry.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TraceProviderRegistryProxy($impl)";
  }
}


class TraceProviderRegistryStub extends bindings.Stub {
  TraceProviderRegistry _impl;

  TraceProviderRegistryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TraceProviderRegistry impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  TraceProviderRegistryStub.fromHandle(
      core.MojoHandle handle, [TraceProviderRegistry impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  TraceProviderRegistryStub.unbound() : super.unbound();

  static TraceProviderRegistryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceProviderRegistryStub"));
    return new TraceProviderRegistryStub.fromEndpoint(endpoint);
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
      case _traceProviderRegistryMethodRegisterTraceProviderName:
        var params = _TraceProviderRegistryRegisterTraceProviderParams.deserialize(
            message.payload);
        _impl.registerTraceProvider(params.traceProvider);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TraceProviderRegistry get impl => _impl;
  set impl(TraceProviderRegistry d) {
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
    return "TraceProviderRegistryStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TraceProviderRegistryServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



