// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_trees_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/gfx/composition/renderers.mojom.dart' as renderers_mojom;
import 'package:mojo_services/mojo/ui/view_containers.mojom.dart' as view_containers_mojom;
import 'package:mojo_services/mojo/ui/view_tree_token.mojom.dart' as view_tree_token_mojom;



class _ViewTreeGetTokenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeGetTokenParams() : super(kVersions.last.size);

  static _ViewTreeGetTokenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeGetTokenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeGetTokenParams result = new _ViewTreeGetTokenParams();

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
    return "_ViewTreeGetTokenParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeGetTokenResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  view_tree_token_mojom.ViewTreeToken token = null;

  ViewTreeGetTokenResponseParams() : super(kVersions.last.size);

  static ViewTreeGetTokenResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeGetTokenResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeGetTokenResponseParams result = new ViewTreeGetTokenResponseParams();

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
      result.token = view_tree_token_mojom.ViewTreeToken.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(token, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "token of struct ViewTreeGetTokenResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewTreeGetTokenResponseParams("
           "token: $token" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["token"] = token;
    return map;
  }
}


class _ViewTreeGetServiceProviderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object serviceProvider = null;

  _ViewTreeGetServiceProviderParams() : super(kVersions.last.size);

  static _ViewTreeGetServiceProviderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeGetServiceProviderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeGetServiceProviderParams result = new _ViewTreeGetServiceProviderParams();

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
      
      result.serviceProvider = decoder0.decodeInterfaceRequest(8, false, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(serviceProvider, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serviceProvider of struct _ViewTreeGetServiceProviderParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeGetServiceProviderParams("
           "serviceProvider: $serviceProvider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeSetRendererParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object renderer = null;

  _ViewTreeSetRendererParams() : super(kVersions.last.size);

  static _ViewTreeSetRendererParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeSetRendererParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeSetRendererParams result = new _ViewTreeSetRendererParams();

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
      
      result.renderer = decoder0.decodeServiceInterface(8, true, renderers_mojom.RendererProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(renderer, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "renderer of struct _ViewTreeSetRendererParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeSetRendererParams("
           "renderer: $renderer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeGetContainerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object container = null;

  _ViewTreeGetContainerParams() : super(kVersions.last.size);

  static _ViewTreeGetContainerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeGetContainerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeGetContainerParams result = new _ViewTreeGetContainerParams();

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
      
      result.container = decoder0.decodeInterfaceRequest(8, false, view_containers_mojom.ViewContainerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(container, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "container of struct _ViewTreeGetContainerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeGetContainerParams("
           "container: $container" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeListenerOnRendererDiedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeListenerOnRendererDiedParams() : super(kVersions.last.size);

  static _ViewTreeListenerOnRendererDiedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeListenerOnRendererDiedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeListenerOnRendererDiedParams result = new _ViewTreeListenerOnRendererDiedParams();

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
    return "_ViewTreeListenerOnRendererDiedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeListenerOnRendererDiedResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeListenerOnRendererDiedResponseParams() : super(kVersions.last.size);

  static ViewTreeListenerOnRendererDiedResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeListenerOnRendererDiedResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeListenerOnRendererDiedResponseParams result = new ViewTreeListenerOnRendererDiedResponseParams();

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
    return "ViewTreeListenerOnRendererDiedResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _viewTreeMethodGetTokenName = 0;
const int _viewTreeMethodGetServiceProviderName = 1;
const int _viewTreeMethodSetRendererName = 2;
const int _viewTreeMethodGetContainerName = 3;

class _ViewTreeServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewTree {
  static const String serviceName = null;
  dynamic getToken([Function responseFactory = null]);
  void getServiceProvider(Object serviceProvider);
  void setRenderer(Object renderer);
  void getContainer(Object container);
}


class _ViewTreeProxyImpl extends bindings.Proxy {
  _ViewTreeProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewTreeProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewTreeProxyImpl.unbound() : super.unbound();

  static _ViewTreeProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewTreeProxyImpl"));
    return new _ViewTreeProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewTreeServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _viewTreeMethodGetTokenName:
        var r = ViewTreeGetTokenResponseParams.deserialize(
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
    return "_ViewTreeProxyImpl($superString)";
  }
}


class _ViewTreeProxyCalls implements ViewTree {
  _ViewTreeProxyImpl _proxyImpl;

  _ViewTreeProxyCalls(this._proxyImpl);
    dynamic getToken([Function responseFactory = null]) {
      var params = new _ViewTreeGetTokenParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _viewTreeMethodGetTokenName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getServiceProvider(Object serviceProvider) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeGetServiceProviderParams();
      params.serviceProvider = serviceProvider;
      _proxyImpl.sendMessage(params, _viewTreeMethodGetServiceProviderName);
    }
    void setRenderer(Object renderer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeSetRendererParams();
      params.renderer = renderer;
      _proxyImpl.sendMessage(params, _viewTreeMethodSetRendererName);
    }
    void getContainer(Object container) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeGetContainerParams();
      params.container = container;
      _proxyImpl.sendMessage(params, _viewTreeMethodGetContainerName);
    }
}


class ViewTreeProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewTree ptr;

  ViewTreeProxy(_ViewTreeProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewTreeProxyCalls(proxyImpl);

  ViewTreeProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewTreeProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  ViewTreeProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewTreeProxyImpl.fromHandle(handle) {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  ViewTreeProxy.unbound() :
      impl = new _ViewTreeProxyImpl.unbound() {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  factory ViewTreeProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewTreeProxy p = new ViewTreeProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewTreeProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeProxy"));
    return new ViewTreeProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewTree.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewTreeProxy($impl)";
  }
}


class ViewTreeStub extends bindings.Stub {
  ViewTree _impl;

  ViewTreeStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewTree impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ViewTreeStub.fromHandle(
      core.MojoHandle handle, [ViewTree impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ViewTreeStub.unbound([this._impl]) : super.unbound();

  static ViewTreeStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeStub"));
    return new ViewTreeStub.fromEndpoint(endpoint);
  }


  ViewTreeGetTokenResponseParams _viewTreeGetTokenResponseParamsFactory(view_tree_token_mojom.ViewTreeToken token) {
    var result = new ViewTreeGetTokenResponseParams();
    result.token = token;
    return result;
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
      case _viewTreeMethodGetTokenName:
        var response = _impl.getToken(_viewTreeGetTokenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewTreeMethodGetTokenName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewTreeMethodGetTokenName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _viewTreeMethodGetServiceProviderName:
        var params = _ViewTreeGetServiceProviderParams.deserialize(
            message.payload);
        _impl.getServiceProvider(params.serviceProvider);
        break;
      case _viewTreeMethodSetRendererName:
        var params = _ViewTreeSetRendererParams.deserialize(
            message.payload);
        _impl.setRenderer(params.renderer);
        break;
      case _viewTreeMethodGetContainerName:
        var params = _ViewTreeGetContainerParams.deserialize(
            message.payload);
        _impl.getContainer(params.container);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewTree get impl => _impl;
  set impl(ViewTree d) {
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
    return "ViewTreeStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewTreeServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _viewTreeListenerMethodOnRendererDiedName = 0;

class _ViewTreeListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewTreeListener {
  static const String serviceName = null;
  dynamic onRendererDied([Function responseFactory = null]);
}


class _ViewTreeListenerProxyImpl extends bindings.Proxy {
  _ViewTreeListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewTreeListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewTreeListenerProxyImpl.unbound() : super.unbound();

  static _ViewTreeListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewTreeListenerProxyImpl"));
    return new _ViewTreeListenerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewTreeListenerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _viewTreeListenerMethodOnRendererDiedName:
        var r = ViewTreeListenerOnRendererDiedResponseParams.deserialize(
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
    return "_ViewTreeListenerProxyImpl($superString)";
  }
}


class _ViewTreeListenerProxyCalls implements ViewTreeListener {
  _ViewTreeListenerProxyImpl _proxyImpl;

  _ViewTreeListenerProxyCalls(this._proxyImpl);
    dynamic onRendererDied([Function responseFactory = null]) {
      var params = new _ViewTreeListenerOnRendererDiedParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _viewTreeListenerMethodOnRendererDiedName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewTreeListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewTreeListener ptr;

  ViewTreeListenerProxy(_ViewTreeListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewTreeListenerProxyCalls(proxyImpl);

  ViewTreeListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewTreeListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewTreeListenerProxyCalls(impl);
  }

  ViewTreeListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewTreeListenerProxyImpl.fromHandle(handle) {
    ptr = new _ViewTreeListenerProxyCalls(impl);
  }

  ViewTreeListenerProxy.unbound() :
      impl = new _ViewTreeListenerProxyImpl.unbound() {
    ptr = new _ViewTreeListenerProxyCalls(impl);
  }

  factory ViewTreeListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewTreeListenerProxy p = new ViewTreeListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewTreeListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeListenerProxy"));
    return new ViewTreeListenerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewTreeListener.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewTreeListenerProxy($impl)";
  }
}


class ViewTreeListenerStub extends bindings.Stub {
  ViewTreeListener _impl;

  ViewTreeListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewTreeListener impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ViewTreeListenerStub.fromHandle(
      core.MojoHandle handle, [ViewTreeListener impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ViewTreeListenerStub.unbound([this._impl]) : super.unbound();

  static ViewTreeListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeListenerStub"));
    return new ViewTreeListenerStub.fromEndpoint(endpoint);
  }


  ViewTreeListenerOnRendererDiedResponseParams _viewTreeListenerOnRendererDiedResponseParamsFactory() {
    var result = new ViewTreeListenerOnRendererDiedResponseParams();
    return result;
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
      case _viewTreeListenerMethodOnRendererDiedName:
        var response = _impl.onRendererDied(_viewTreeListenerOnRendererDiedResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewTreeListenerMethodOnRendererDiedName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewTreeListenerMethodOnRendererDiedName,
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

  ViewTreeListener get impl => _impl;
  set impl(ViewTreeListener d) {
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
    return "ViewTreeListenerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewTreeListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



