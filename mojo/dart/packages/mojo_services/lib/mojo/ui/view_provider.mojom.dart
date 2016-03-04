// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_provider_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/ui/views.mojom.dart' as views_mojom;



class _ViewProviderCreateViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object viewOwner = null;
  Object services = null;
  Object exposedServices = null;

  _ViewProviderCreateViewParams() : super(kVersions.last.size);

  static _ViewProviderCreateViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewProviderCreateViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewProviderCreateViewParams result = new _ViewProviderCreateViewParams();

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
      
      result.viewOwner = decoder0.decodeInterfaceRequest(8, false, views_mojom.ViewOwnerStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.services = decoder0.decodeInterfaceRequest(12, true, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.exposedServices = decoder0.decodeServiceInterface(16, true, service_provider_mojom.ServiceProviderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(viewOwner, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewOwner of struct _ViewProviderCreateViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(services, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "services of struct _ViewProviderCreateViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(exposedServices, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "exposedServices of struct _ViewProviderCreateViewParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewProviderCreateViewParams("
           "viewOwner: $viewOwner" ", "
           "services: $services" ", "
           "exposedServices: $exposedServices" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _ViewProvider_createViewName = 0;

class _ViewProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewProvider {
  static const String serviceName = "mojo::ui::ViewProvider";
  void createView(Object viewOwner, Object services, Object exposedServices);
}


class _ViewProviderProxyImpl extends bindings.Proxy {
  _ViewProviderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewProviderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewProviderProxyImpl.unbound() : super.unbound();

  static _ViewProviderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewProviderProxyImpl"));
    return new _ViewProviderProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewProviderServiceDescription();

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
    return "_ViewProviderProxyImpl($superString)";
  }
}


class _ViewProviderProxyCalls implements ViewProvider {
  _ViewProviderProxyImpl _proxyImpl;

  _ViewProviderProxyCalls(this._proxyImpl);
    void createView(Object viewOwner, Object services, Object exposedServices) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewProviderCreateViewParams();
      params.viewOwner = viewOwner;
      params.services = services;
      params.exposedServices = exposedServices;
      _proxyImpl.sendMessage(params, _ViewProvider_createViewName);
    }
}


class ViewProviderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewProvider ptr;

  ViewProviderProxy(_ViewProviderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewProviderProxyCalls(proxyImpl);

  ViewProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewProviderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewProviderProxyCalls(impl);
  }

  ViewProviderProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewProviderProxyImpl.fromHandle(handle) {
    ptr = new _ViewProviderProxyCalls(impl);
  }

  ViewProviderProxy.unbound() :
      impl = new _ViewProviderProxyImpl.unbound() {
    ptr = new _ViewProviderProxyCalls(impl);
  }

  factory ViewProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewProviderProxy p = new ViewProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProviderProxy"));
    return new ViewProviderProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewProvider.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewProviderProxy($impl)";
  }
}


class ViewProviderStub extends bindings.Stub {
  ViewProvider _impl = null;

  ViewProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewProviderStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewProviderStub.unbound() : super.unbound();

  static ViewProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProviderStub"));
    return new ViewProviderStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ViewProvider_createViewName:
        var params = _ViewProviderCreateViewParams.deserialize(
            message.payload);
        _impl.createView(params.viewOwner, params.services, params.exposedServices);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewProvider get impl => _impl;
  set impl(ViewProvider d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewProviderStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewProviderServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



