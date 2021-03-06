// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library application_connector_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;



class _ApplicationConnectorConnectToApplicationParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String applicationUrl = null;
  Object services = null;
  Object exposedServices = null;

  _ApplicationConnectorConnectToApplicationParams() : super(kVersions.last.size);

  static _ApplicationConnectorConnectToApplicationParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ApplicationConnectorConnectToApplicationParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ApplicationConnectorConnectToApplicationParams result = new _ApplicationConnectorConnectToApplicationParams();

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
      
      result.applicationUrl = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.services = decoder0.decodeInterfaceRequest(16, true, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.exposedServices = decoder0.decodeServiceInterface(20, true, service_provider_mojom.ServiceProviderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(applicationUrl, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "applicationUrl of struct _ApplicationConnectorConnectToApplicationParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(services, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "services of struct _ApplicationConnectorConnectToApplicationParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(exposedServices, 20, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "exposedServices of struct _ApplicationConnectorConnectToApplicationParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ApplicationConnectorConnectToApplicationParams("
           "applicationUrl: $applicationUrl" ", "
           "services: $services" ", "
           "exposedServices: $exposedServices" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ApplicationConnectorDuplicateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object applicationConnectorRequest = null;

  _ApplicationConnectorDuplicateParams() : super(kVersions.last.size);

  static _ApplicationConnectorDuplicateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ApplicationConnectorDuplicateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ApplicationConnectorDuplicateParams result = new _ApplicationConnectorDuplicateParams();

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
      
      result.applicationConnectorRequest = decoder0.decodeInterfaceRequest(8, false, ApplicationConnectorStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(applicationConnectorRequest, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "applicationConnectorRequest of struct _ApplicationConnectorDuplicateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ApplicationConnectorDuplicateParams("
           "applicationConnectorRequest: $applicationConnectorRequest" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _applicationConnectorMethodConnectToApplicationName = 0;
const int _applicationConnectorMethodDuplicateName = 1;

class _ApplicationConnectorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ApplicationConnector {
  static const String serviceName = null;
  void connectToApplication(String applicationUrl, Object services, Object exposedServices);
  void duplicate(Object applicationConnectorRequest);
}


class _ApplicationConnectorProxyImpl extends bindings.Proxy {
  _ApplicationConnectorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ApplicationConnectorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ApplicationConnectorProxyImpl.unbound() : super.unbound();

  static _ApplicationConnectorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ApplicationConnectorProxyImpl"));
    return new _ApplicationConnectorProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ApplicationConnectorServiceDescription();

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
    return "_ApplicationConnectorProxyImpl($superString)";
  }
}


class _ApplicationConnectorProxyCalls implements ApplicationConnector {
  _ApplicationConnectorProxyImpl _proxyImpl;

  _ApplicationConnectorProxyCalls(this._proxyImpl);
    void connectToApplication(String applicationUrl, Object services, Object exposedServices) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ApplicationConnectorConnectToApplicationParams();
      params.applicationUrl = applicationUrl;
      params.services = services;
      params.exposedServices = exposedServices;
      _proxyImpl.sendMessage(params, _applicationConnectorMethodConnectToApplicationName);
    }
    void duplicate(Object applicationConnectorRequest) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ApplicationConnectorDuplicateParams();
      params.applicationConnectorRequest = applicationConnectorRequest;
      _proxyImpl.sendMessage(params, _applicationConnectorMethodDuplicateName);
    }
}


class ApplicationConnectorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ApplicationConnector ptr;

  ApplicationConnectorProxy(_ApplicationConnectorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ApplicationConnectorProxyCalls(proxyImpl);

  ApplicationConnectorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ApplicationConnectorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ApplicationConnectorProxyCalls(impl);
  }

  ApplicationConnectorProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ApplicationConnectorProxyImpl.fromHandle(handle) {
    ptr = new _ApplicationConnectorProxyCalls(impl);
  }

  ApplicationConnectorProxy.unbound() :
      impl = new _ApplicationConnectorProxyImpl.unbound() {
    ptr = new _ApplicationConnectorProxyCalls(impl);
  }

  factory ApplicationConnectorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ApplicationConnectorProxy p = new ApplicationConnectorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ApplicationConnectorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ApplicationConnectorProxy"));
    return new ApplicationConnectorProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ApplicationConnector.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ApplicationConnectorProxy($impl)";
  }
}


class ApplicationConnectorStub extends bindings.Stub {
  ApplicationConnector _impl;

  ApplicationConnectorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ApplicationConnector impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ApplicationConnectorStub.fromHandle(
      core.MojoHandle handle, [ApplicationConnector impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ApplicationConnectorStub.unbound([this._impl]) : super.unbound();

  static ApplicationConnectorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ApplicationConnectorStub"));
    return new ApplicationConnectorStub.fromEndpoint(endpoint);
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
      case _applicationConnectorMethodConnectToApplicationName:
        var params = _ApplicationConnectorConnectToApplicationParams.deserialize(
            message.payload);
        _impl.connectToApplication(params.applicationUrl, params.services, params.exposedServices);
        break;
      case _applicationConnectorMethodDuplicateName:
        var params = _ApplicationConnectorDuplicateParams.deserialize(
            message.payload);
        _impl.duplicate(params.applicationConnectorRequest);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ApplicationConnector get impl => _impl;
  set impl(ApplicationConnector d) {
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
    return "ApplicationConnectorStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ApplicationConnectorServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



