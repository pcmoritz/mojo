// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library views_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/gfx/composition/scenes.mojom.dart' as scenes_mojom;
import 'package:mojo_services/mojo/ui/layouts.mojom.dart' as layouts_mojom;
import 'package:mojo_services/mojo/ui/view_containers.mojom.dart' as view_containers_mojom;
import 'package:mojo_services/mojo/ui/view_token.mojom.dart' as view_token_mojom;



class _ViewGetTokenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewGetTokenParams() : super(kVersions.last.size);

  static _ViewGetTokenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewGetTokenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewGetTokenParams result = new _ViewGetTokenParams();

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
    return "_ViewGetTokenParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewGetTokenResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  view_token_mojom.ViewToken token = null;

  ViewGetTokenResponseParams() : super(kVersions.last.size);

  static ViewGetTokenResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewGetTokenResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewGetTokenResponseParams result = new ViewGetTokenResponseParams();

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
      result.token = view_token_mojom.ViewToken.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(token, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "token of struct ViewGetTokenResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewGetTokenResponseParams("
           "token: $token" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["token"] = token;
    return map;
  }
}


class _ViewGetServiceProviderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object serviceProvider = null;

  _ViewGetServiceProviderParams() : super(kVersions.last.size);

  static _ViewGetServiceProviderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewGetServiceProviderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewGetServiceProviderParams result = new _ViewGetServiceProviderParams();

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
          "serviceProvider of struct _ViewGetServiceProviderParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewGetServiceProviderParams("
           "serviceProvider: $serviceProvider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewCreateSceneParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object scene = null;

  _ViewCreateSceneParams() : super(kVersions.last.size);

  static _ViewCreateSceneParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewCreateSceneParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewCreateSceneParams result = new _ViewCreateSceneParams();

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
      
      result.scene = decoder0.decodeInterfaceRequest(8, false, scenes_mojom.SceneStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(scene, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "scene of struct _ViewCreateSceneParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewCreateSceneParams("
           "scene: $scene" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewRequestLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewRequestLayoutParams() : super(kVersions.last.size);

  static _ViewRequestLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewRequestLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewRequestLayoutParams result = new _ViewRequestLayoutParams();

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
    return "_ViewRequestLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewGetContainerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object container = null;

  _ViewGetContainerParams() : super(kVersions.last.size);

  static _ViewGetContainerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewGetContainerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewGetContainerParams result = new _ViewGetContainerParams();

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
          "container of struct _ViewGetContainerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewGetContainerParams("
           "container: $container" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewListenerOnLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  layouts_mojom.ViewLayoutParams layoutParams = null;
  List<int> childrenNeedingLayout = null;

  _ViewListenerOnLayoutParams() : super(kVersions.last.size);

  static _ViewListenerOnLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewListenerOnLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewListenerOnLayoutParams result = new _ViewListenerOnLayoutParams();

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
      result.layoutParams = layouts_mojom.ViewLayoutParams.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.childrenNeedingLayout = decoder0.decodeUint32Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(layoutParams, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "layoutParams of struct _ViewListenerOnLayoutParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32Array(childrenNeedingLayout, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childrenNeedingLayout of struct _ViewListenerOnLayoutParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewListenerOnLayoutParams("
           "layoutParams: $layoutParams" ", "
           "childrenNeedingLayout: $childrenNeedingLayout" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["layoutParams"] = layoutParams;
    map["childrenNeedingLayout"] = childrenNeedingLayout;
    return map;
  }
}


class ViewListenerOnLayoutResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutResult result = null;

  ViewListenerOnLayoutResponseParams() : super(kVersions.last.size);

  static ViewListenerOnLayoutResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewListenerOnLayoutResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewListenerOnLayoutResponseParams result = new ViewListenerOnLayoutResponseParams();

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
      result.result = layouts_mojom.ViewLayoutResult.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct ViewListenerOnLayoutResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewListenerOnLayoutResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}

const int _View_getTokenName = 0;
const int _View_getServiceProviderName = 1;
const int _View_createSceneName = 2;
const int _View_requestLayoutName = 3;
const int _View_getContainerName = 4;

class _ViewServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class View {
  static const String serviceName = null;
  dynamic getToken([Function responseFactory = null]);
  void getServiceProvider(Object serviceProvider);
  void createScene(Object scene);
  void requestLayout();
  void getContainer(Object container);
}


class _ViewProxyImpl extends bindings.Proxy {
  _ViewProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewProxyImpl.unbound() : super.unbound();

  static _ViewProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewProxyImpl"));
    return new _ViewProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _View_getTokenName:
        var r = ViewGetTokenResponseParams.deserialize(
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
    return "_ViewProxyImpl($superString)";
  }
}


class _ViewProxyCalls implements View {
  _ViewProxyImpl _proxyImpl;

  _ViewProxyCalls(this._proxyImpl);
    dynamic getToken([Function responseFactory = null]) {
      var params = new _ViewGetTokenParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _View_getTokenName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getServiceProvider(Object serviceProvider) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewGetServiceProviderParams();
      params.serviceProvider = serviceProvider;
      _proxyImpl.sendMessage(params, _View_getServiceProviderName);
    }
    void createScene(Object scene) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewCreateSceneParams();
      params.scene = scene;
      _proxyImpl.sendMessage(params, _View_createSceneName);
    }
    void requestLayout() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewRequestLayoutParams();
      _proxyImpl.sendMessage(params, _View_requestLayoutName);
    }
    void getContainer(Object container) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewGetContainerParams();
      params.container = container;
      _proxyImpl.sendMessage(params, _View_getContainerName);
    }
}


class ViewProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  View ptr;

  ViewProxy(_ViewProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewProxyCalls(proxyImpl);

  ViewProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewProxyCalls(impl);
  }

  ViewProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewProxyImpl.fromHandle(handle) {
    ptr = new _ViewProxyCalls(impl);
  }

  ViewProxy.unbound() :
      impl = new _ViewProxyImpl.unbound() {
    ptr = new _ViewProxyCalls(impl);
  }

  factory ViewProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewProxy p = new ViewProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProxy"));
    return new ViewProxy.fromEndpoint(endpoint);
  }

  String get serviceName => View.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewProxy($impl)";
  }
}


class ViewStub extends bindings.Stub {
  View _impl = null;

  ViewStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewStub.unbound() : super.unbound();

  static ViewStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewStub"));
    return new ViewStub.fromEndpoint(endpoint);
  }


  ViewGetTokenResponseParams _ViewGetTokenResponseParamsFactory(view_token_mojom.ViewToken token) {
    var mojo_factory_result = new ViewGetTokenResponseParams();
    mojo_factory_result.token = token;
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
      case _View_getTokenName:
        var response = _impl.getToken(_ViewGetTokenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _View_getTokenName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _View_getTokenName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _View_getServiceProviderName:
        var params = _ViewGetServiceProviderParams.deserialize(
            message.payload);
        _impl.getServiceProvider(params.serviceProvider);
        break;
      case _View_createSceneName:
        var params = _ViewCreateSceneParams.deserialize(
            message.payload);
        _impl.createScene(params.scene);
        break;
      case _View_requestLayoutName:
        _impl.requestLayout();
        break;
      case _View_getContainerName:
        var params = _ViewGetContainerParams.deserialize(
            message.payload);
        _impl.getContainer(params.container);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  View get impl => _impl;
  set impl(View d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _ViewListener_onLayoutName = 0;

class _ViewListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewListener {
  static const String serviceName = null;
  dynamic onLayout(layouts_mojom.ViewLayoutParams layoutParams,List<int> childrenNeedingLayout,[Function responseFactory = null]);
}


class _ViewListenerProxyImpl extends bindings.Proxy {
  _ViewListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewListenerProxyImpl.unbound() : super.unbound();

  static _ViewListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewListenerProxyImpl"));
    return new _ViewListenerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewListenerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ViewListener_onLayoutName:
        var r = ViewListenerOnLayoutResponseParams.deserialize(
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
    return "_ViewListenerProxyImpl($superString)";
  }
}


class _ViewListenerProxyCalls implements ViewListener {
  _ViewListenerProxyImpl _proxyImpl;

  _ViewListenerProxyCalls(this._proxyImpl);
    dynamic onLayout(layouts_mojom.ViewLayoutParams layoutParams,List<int> childrenNeedingLayout,[Function responseFactory = null]) {
      var params = new _ViewListenerOnLayoutParams();
      params.layoutParams = layoutParams;
      params.childrenNeedingLayout = childrenNeedingLayout;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewListener_onLayoutName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewListener ptr;

  ViewListenerProxy(_ViewListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewListenerProxyCalls(proxyImpl);

  ViewListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewListenerProxyCalls(impl);
  }

  ViewListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewListenerProxyImpl.fromHandle(handle) {
    ptr = new _ViewListenerProxyCalls(impl);
  }

  ViewListenerProxy.unbound() :
      impl = new _ViewListenerProxyImpl.unbound() {
    ptr = new _ViewListenerProxyCalls(impl);
  }

  factory ViewListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewListenerProxy p = new ViewListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewListenerProxy"));
    return new ViewListenerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewListener.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewListenerProxy($impl)";
  }
}


class ViewListenerStub extends bindings.Stub {
  ViewListener _impl = null;

  ViewListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewListenerStub.unbound() : super.unbound();

  static ViewListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewListenerStub"));
    return new ViewListenerStub.fromEndpoint(endpoint);
  }


  ViewListenerOnLayoutResponseParams _ViewListenerOnLayoutResponseParamsFactory(layouts_mojom.ViewLayoutResult result) {
    var mojo_factory_result = new ViewListenerOnLayoutResponseParams();
    mojo_factory_result.result = result;
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
      case _ViewListener_onLayoutName:
        var params = _ViewListenerOnLayoutParams.deserialize(
            message.payload);
        var response = _impl.onLayout(params.layoutParams,params.childrenNeedingLayout,_ViewListenerOnLayoutResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewListener_onLayoutName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewListener_onLayoutName,
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

  ViewListener get impl => _impl;
  set impl(ViewListener d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewListenerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



