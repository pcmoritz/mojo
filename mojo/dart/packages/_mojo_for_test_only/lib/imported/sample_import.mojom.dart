// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_import_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class Shape extends bindings.MojoEnum {
  static const Shape rectangle = const Shape._(1);
  static const Shape circle = const Shape._(2);
  static const Shape triangle = const Shape._(3);
  static const Shape last = const Shape._(3);

  const Shape._(int v) : super(v);

  static const Map<String, Shape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
    "last": last,
  };
  static const List<Shape> values = const [
    rectangle,
    circle,
    triangle,
    last,
  ];

  static Shape valueOf(String name) => valuesMap[name];

  factory Shape(int v) {
    switch (v) {
      case 1:
        return Shape.rectangle;
      case 2:
        return Shape.circle;
      case 3:
        return Shape.triangle;
      case 3:
        return Shape.last;
      default:
        return null;
    }
  }

  static Shape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Shape result = new Shape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Shape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'Shape.rectangle';
      case circle:
        return 'Shape.circle';
      case triangle:
        return 'Shape.triangle';
      case last:
        return 'Shape.last';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class AnotherShape extends bindings.MojoEnum {
  static const AnotherShape rectangle = const AnotherShape._(10);
  static const AnotherShape circle = const AnotherShape._(11);
  static const AnotherShape triangle = const AnotherShape._(12);

  const AnotherShape._(int v) : super(v);

  static const Map<String, AnotherShape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
  };
  static const List<AnotherShape> values = const [
    rectangle,
    circle,
    triangle,
  ];

  static AnotherShape valueOf(String name) => valuesMap[name];

  factory AnotherShape(int v) {
    switch (v) {
      case 10:
        return AnotherShape.rectangle;
      case 11:
        return AnotherShape.circle;
      case 12:
        return AnotherShape.triangle;
      default:
        return null;
    }
  }

  static AnotherShape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AnotherShape result = new AnotherShape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AnotherShape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'AnotherShape.rectangle';
      case circle:
        return 'AnotherShape.circle';
      case triangle:
        return 'AnotherShape.triangle';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class YetAnotherShape extends bindings.MojoEnum {
  static const YetAnotherShape rectangle = const YetAnotherShape._(20);
  static const YetAnotherShape circle = const YetAnotherShape._(21);
  static const YetAnotherShape triangle = const YetAnotherShape._(22);

  const YetAnotherShape._(int v) : super(v);

  static const Map<String, YetAnotherShape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
  };
  static const List<YetAnotherShape> values = const [
    rectangle,
    circle,
    triangle,
  ];

  static YetAnotherShape valueOf(String name) => valuesMap[name];

  factory YetAnotherShape(int v) {
    switch (v) {
      case 20:
        return YetAnotherShape.rectangle;
      case 21:
        return YetAnotherShape.circle;
      case 22:
        return YetAnotherShape.triangle;
      default:
        return null;
    }
  }

  static YetAnotherShape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    YetAnotherShape result = new YetAnotherShape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum YetAnotherShape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'YetAnotherShape.rectangle';
      case circle:
        return 'YetAnotherShape.circle';
      case triangle:
        return 'YetAnotherShape.triangle';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Point extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int x = 0;
  int y = 0;

  Point() : super(kVersions.last.size);

  static Point deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Point decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Point result = new Point();

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
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Point: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct Point: $e";
      rethrow;
    }
  }

  String toString() {
    return "Point("
           "x: $x" ", "
           "y: $y" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    return map;
  }
}


class _ImportedInterfaceDoSomethingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ImportedInterfaceDoSomethingParams() : super(kVersions.last.size);

  static _ImportedInterfaceDoSomethingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ImportedInterfaceDoSomethingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ImportedInterfaceDoSomethingParams result = new _ImportedInterfaceDoSomethingParams();

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
    return "_ImportedInterfaceDoSomethingParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _ImportedInterface_doSomethingName = 0;

class _ImportedInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ImportedInterface {
  static const String serviceName = null;
  void doSomething();
}


class _ImportedInterfaceProxyImpl extends bindings.Proxy {
  _ImportedInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ImportedInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ImportedInterfaceProxyImpl.unbound() : super.unbound();

  static _ImportedInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ImportedInterfaceProxyImpl"));
    return new _ImportedInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ImportedInterfaceServiceDescription();

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
    return "_ImportedInterfaceProxyImpl($superString)";
  }
}


class _ImportedInterfaceProxyCalls implements ImportedInterface {
  _ImportedInterfaceProxyImpl _proxyImpl;

  _ImportedInterfaceProxyCalls(this._proxyImpl);
    void doSomething() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ImportedInterfaceDoSomethingParams();
      _proxyImpl.sendMessage(params, _ImportedInterface_doSomethingName);
    }
}


class ImportedInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ImportedInterface ptr;

  ImportedInterfaceProxy(_ImportedInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ImportedInterfaceProxyCalls(proxyImpl);

  ImportedInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ImportedInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ImportedInterfaceProxyCalls(impl);
  }

  ImportedInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ImportedInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _ImportedInterfaceProxyCalls(impl);
  }

  ImportedInterfaceProxy.unbound() :
      impl = new _ImportedInterfaceProxyImpl.unbound() {
    ptr = new _ImportedInterfaceProxyCalls(impl);
  }

  factory ImportedInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ImportedInterfaceProxy p = new ImportedInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ImportedInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ImportedInterfaceProxy"));
    return new ImportedInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ImportedInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ImportedInterfaceProxy($impl)";
  }
}


class ImportedInterfaceStub extends bindings.Stub {
  ImportedInterface _impl = null;

  ImportedInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ImportedInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ImportedInterfaceStub.unbound() : super.unbound();

  static ImportedInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ImportedInterfaceStub"));
    return new ImportedInterfaceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ImportedInterface_doSomethingName:
        _impl.doSomething();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ImportedInterface get impl => _impl;
  set impl(ImportedInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ImportedInterfaceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ImportedInterfaceServiceDescription();
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
  var serializedRuntimeTypeInfo = new Uint8List.fromList(const [24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,48,0,0,0,5,0,0,0,40,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,104,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,160,0,0,0,0,0,0,0,43,0,0,0,35,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,80,111,105,110,116,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,83,104,97,112,101,0,38,0,0,0,30,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,65,110,111,116,104,101,114,83,104,97,112,101,0,0,41,0,0,0,33,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,0,0,0,0,0,0,0,88,0,0,0,5,0,0,0,16,0,0,0,3,0,0,0,72,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,160,3,0,0,0,0,0,0,16,0,0,0,0,0,0,0,192,6,0,0,0,0,0,0,16,0,0,0,0,0,0,0,80,13,0,0,0,0,0,0,16,0,0,0,0,0,0,0,120,18,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,96,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,25,0,0,0,17,0,0,0,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,105,109,112,111,114,116,101,100,46,73,109,112,111,114,116,101,100,73,110,116,101,114,102,97,99,101,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,35,0,0,0,10,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,12,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,68,111,83,111,109,101,116,104,105,110,103,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,36,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,
47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,27,0,0,0,19,0,0,0,68,111,83,111,109,101,116,104,105,110,103,45,114,101,113,117,101,115,116,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,80,111,105,110,116,0,0,0,22,0,0,0,14,0,0,0,105,109,112,111,114,116,101,100,46,80,111,105,110,116,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,30,0,0,0,7,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,16,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,1,0,0,0,120,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,31,0,0,0,8,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,1,0,0,0,121,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,
16,0,0,0,0,0,0,0,32,0,0,0,8,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,240,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,83,104,97,112,101,0,0,0,22,0,0,0,14,0,0,0,105,109,112,111,114,116,101,100,46,83,104,97,112,101,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,5,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,40,0,0,0,4,0,0,0,32,0,0,0,0,0,0,0,112,1,0,0,0,0,0,0,168,2,0,0,0,0,0,0,224,3,0,0,0,0,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,24,1,0,0,0,0,0,0,16,0,0,0,0,0,0,0,40,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,0,0,0,9,0,0,0,82,69,67,84,65,78,71,76,69,0,0,0,0,0,0,0,32,0,0,0,24,0,0,0,105,109,112,111,114,116,101,100,46,83,104,97,112,101,46,82,69,67,84,65,78,71,76,69,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,11,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,83,104,97,112,101,0,16,0,0,0,3,0,0,0,1,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,16,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0,0,0,6,0,0,0,67,73,82,67,76,69,0,0,29,0,0,0,21,0,0,0,105,109,112,111,114,116,101,100,46,83,104,97,112,101,46,67,73,82,67,76,69,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,12,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,
98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,83,104,97,112,101,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,16,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,84,82,73,65,78,71,76,69,31,0,0,0,23,0,0,0,105,109,112,111,114,116,101,100,46,83,104,97,112,101,46,84,82,73,65,78,71,76,69,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,13,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,83,104,97,112,101,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,16,1,0,0,0,0,0,0,16,0,0,0,1,0,0,0,32,1,0,0,0,0,0,0,3,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,76,65,83,84,0,0,0,0,27,0,0,0,19,0,0,0,105,109,112,111,114,116,101,100,46,83,104,97,112,101,46,76,65,83,84,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,14,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,31,0,0,0,23,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,83,104,97,112,101,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,84,82,73,65,78,71,76,69,40,0,0,0,32,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,83,104,97,112,101,46,84,82,73,65,78,71,76,69,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,0,0,0,12,0,0,0,65,110,111,116,104,101,114,83,104,97,112,101,0,0,0,0,29,0,0,0,21,0,0,0,105,109,112,111,114,116,101,100,46,65,110,111,116,104,101,114,83,104,97,112,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,18,0,0,0,5,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,
100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,32,0,0,0,3,0,0,0,24,0,0,0,0,0,0,0,120,1,0,0,0,0,0,0,192,2,0,0,0,0,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,1,0,0,0,0,0,0,16,0,0,0,0,0,0,0,56,1,0,0,0,0,0,0,10,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,88,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,0,0,0,9,0,0,0,82,69,67,84,65,78,71,76,69,0,0,0,0,0,0,0,39,0,0,0,31,0,0,0,105,109,112,111,114,116,101,100,46,65,110,111,116,104,101,114,83,104,97,112,101,46,82,69,67,84,65,78,71,76,69,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,19,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,38,0,0,0,30,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,65,110,111,116,104,101,114,83,104,97,112,101,0,0,16,0,0,0,3,0,0,0,10,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,24,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0,0,0,6,0,0,0,67,73,82,67,76,69,0,0,36,0,0,0,28,0,0,0,105,109,112,111,114,116,101,100,46,65,110,111,116,104,101,114,83,104,97,112,101,46,67,73,82,67,76,69,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,20,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,38,0,0,0,30,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,65,110,111,116,104,101,114,83,104,97,112,101,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,24,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,84,82,73,65,78,71,76,69,38,0,0,0,30,0,0,0,105,109,112,111,114,116,101,100,46,65,110,111,116,104,101,114,83,104,97,112,101,46,84,82,73,65,78,71,76,69,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,
21,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,38,0,0,0,30,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,65,110,111,116,104,101,114,83,104,97,112,101,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,23,0,0,0,15,0,0,0,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,0,32,0,0,0,24,0,0,0,105,109,112,111,114,116,101,100,46,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,5,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,32,0,0,0,3,0,0,0,24,0,0,0,0,0,0,0,136,1,0,0,0,0,0,0,216,2,0,0,0,0,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,40,1,0,0,0,0,0,0,16,0,0,0,0,0,0,0,72,1,0,0,0,0,0,0,20,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,96,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17,0,0,0,9,0,0,0,82,69,67,84,65,78,71,76,69,0,0,0,0,0,0,0,42,0,0,0,34,0,0,0,105,109,112,111,114,116,101,100,46,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,46,82,69,67,84,65,78,71,76,69,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,25,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,41,0,0,0,33,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,20,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,24,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,0,0,0,6,0,0,0,67,73,82,67,76,69,0,0,39,0,0,0,31,0,0,0,105,109,112,111,114,116,101,100,46,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,46,67,73,82,67,76,69,0,
24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,26,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,41,0,0,0,33,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,88,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,84,82,73,65,78,71,76,69,41,0,0,0,33,0,0,0,105,109,112,111,114,116,101,100,46,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,46,84,82,73,65,78,71,76,69,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,27,0,0,0,2,0,0,0,90,0,0,0,82,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,115,97,109,112,108,101,95,105,109,112,111,114,116,46,109,111,106,111,109,0,0,0,0,0,0,41,0,0,0,33,0,0,0,84,89,80,69,95,75,69,89,58,105,109,112,111,114,116,101,100,46,89,101,116,65,110,111,116,104,101,114,83,104,97,112,101,0,0,0,0,0,0,0]);

  // Deserialize RuntimeTypeInfo
  var bdata = new ByteData.view(serializedRuntimeTypeInfo.buffer);
  var message = new bindings.Message(bdata, null, serializedRuntimeTypeInfo.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
