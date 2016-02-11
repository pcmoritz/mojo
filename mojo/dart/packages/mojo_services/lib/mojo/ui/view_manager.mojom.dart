// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_manager_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/ui/views.mojom.dart' as views_mojom;
import 'package:mojo_services/mojo/ui/view_associates.mojom.dart' as view_associates_mojom;
import 'package:mojo_services/mojo/ui/view_trees.mojom.dart' as view_trees_mojom;
const int kLabelMaxLength = 32;



class _ViewManagerRegisterViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  Object view = null;
  Object viewHost = null;
  Object viewOwner = null;
  String label = null;

  _ViewManagerRegisterViewParams() : super(kVersions.last.size);

  static _ViewManagerRegisterViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewManagerRegisterViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewManagerRegisterViewParams result = new _ViewManagerRegisterViewParams();

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
      
      result.view = decoder0.decodeServiceInterface(8, false, views_mojom.ViewProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewHost = decoder0.decodeInterfaceRequest(16, false, views_mojom.ViewHostStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewOwner = decoder0.decodeInterfaceRequest(20, false, views_mojom.ViewOwnerStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(view, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "view of struct _ViewManagerRegisterViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(viewHost, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewHost of struct _ViewManagerRegisterViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(viewOwner, 20, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewOwner of struct _ViewManagerRegisterViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(label, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct _ViewManagerRegisterViewParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewManagerRegisterViewParams("
           "view: $view" ", "
           "viewHost: $viewHost" ", "
           "viewOwner: $viewOwner" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _ViewManagerRegisterViewTreeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  Object viewTree = null;
  Object viewTreeHost = null;
  String label = null;

  _ViewManagerRegisterViewTreeParams() : super(kVersions.last.size);

  static _ViewManagerRegisterViewTreeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewManagerRegisterViewTreeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewManagerRegisterViewTreeParams result = new _ViewManagerRegisterViewTreeParams();

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
      
      result.viewTree = decoder0.decodeServiceInterface(8, false, view_trees_mojom.ViewTreeProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewTreeHost = decoder0.decodeInterfaceRequest(16, false, view_trees_mojom.ViewTreeHostStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(viewTree, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewTree of struct _ViewManagerRegisterViewTreeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(viewTreeHost, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewTreeHost of struct _ViewManagerRegisterViewTreeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(label, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct _ViewManagerRegisterViewTreeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewManagerRegisterViewTreeParams("
           "viewTree: $viewTree" ", "
           "viewTreeHost: $viewTreeHost" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _ViewManager_registerViewName = 0;
const int _ViewManager_registerViewTreeName = 1;



class _ViewManagerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewManager {
  static const String serviceName = "mojo::ui::ViewManager";
  void registerView(Object view, Object viewHost, Object viewOwner, String label);
  void registerViewTree(Object viewTree, Object viewTreeHost, String label);
}


class _ViewManagerProxyImpl extends bindings.Proxy {
  _ViewManagerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewManagerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewManagerProxyImpl.unbound() : super.unbound();

  static _ViewManagerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewManagerProxyImpl"));
    return new _ViewManagerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewManagerServiceDescription();

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
    return "_ViewManagerProxyImpl($superString)";
  }
}


class _ViewManagerProxyCalls implements ViewManager {
  _ViewManagerProxyImpl _proxyImpl;

  _ViewManagerProxyCalls(this._proxyImpl);
    void registerView(Object view, Object viewHost, Object viewOwner, String label) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewManagerRegisterViewParams();
      params.view = view;
      params.viewHost = viewHost;
      params.viewOwner = viewOwner;
      params.label = label;
      _proxyImpl.sendMessage(params, _ViewManager_registerViewName);
    }
    void registerViewTree(Object viewTree, Object viewTreeHost, String label) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewManagerRegisterViewTreeParams();
      params.viewTree = viewTree;
      params.viewTreeHost = viewTreeHost;
      params.label = label;
      _proxyImpl.sendMessage(params, _ViewManager_registerViewTreeName);
    }
}


class ViewManagerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewManager ptr;

  ViewManagerProxy(_ViewManagerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewManagerProxyCalls(proxyImpl);

  ViewManagerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewManagerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewManagerProxyCalls(impl);
  }

  ViewManagerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewManagerProxyImpl.fromHandle(handle) {
    ptr = new _ViewManagerProxyCalls(impl);
  }

  ViewManagerProxy.unbound() :
      impl = new _ViewManagerProxyImpl.unbound() {
    ptr = new _ViewManagerProxyCalls(impl);
  }

  factory ViewManagerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewManagerProxy p = new ViewManagerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewManagerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerProxy"));
    return new ViewManagerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewManager.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewManagerProxy($impl)";
  }
}


class ViewManagerStub extends bindings.Stub {
  ViewManager _impl = null;

  ViewManagerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewManagerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewManagerStub.unbound() : super.unbound();

  static ViewManagerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerStub"));
    return new ViewManagerStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ViewManager_registerViewName:
        var params = _ViewManagerRegisterViewParams.deserialize(
            message.payload);
        _impl.registerView(params.view, params.viewHost, params.viewOwner, params.label);
        break;
      case _ViewManager_registerViewTreeName:
        var params = _ViewManagerRegisterViewTreeParams.deserialize(
            message.payload);
        _impl.registerViewTree(params.viewTree, params.viewTreeHost, params.label);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewManager get impl => _impl;
  set impl(ViewManager d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewManagerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewManagerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



