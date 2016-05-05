// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_type_converter_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_transport.mojom.dart' as media_transport_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;



class _MediaTypeConverterGetOutputTypeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaTypeConverterGetOutputTypeParams() : super(kVersions.last.size);

  static _MediaTypeConverterGetOutputTypeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTypeConverterGetOutputTypeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTypeConverterGetOutputTypeParams result = new _MediaTypeConverterGetOutputTypeParams();

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
    return "_MediaTypeConverterGetOutputTypeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaTypeConverterGetOutputTypeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_types_mojom.MediaType outputType = null;

  MediaTypeConverterGetOutputTypeResponseParams() : super(kVersions.last.size);

  static MediaTypeConverterGetOutputTypeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaTypeConverterGetOutputTypeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaTypeConverterGetOutputTypeResponseParams result = new MediaTypeConverterGetOutputTypeResponseParams();

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
      result.outputType = media_types_mojom.MediaType.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(outputType, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "outputType of struct MediaTypeConverterGetOutputTypeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaTypeConverterGetOutputTypeResponseParams("
           "outputType: $outputType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["outputType"] = outputType;
    return map;
  }
}


class _MediaTypeConverterGetConsumerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object consumer = null;

  _MediaTypeConverterGetConsumerParams() : super(kVersions.last.size);

  static _MediaTypeConverterGetConsumerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTypeConverterGetConsumerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTypeConverterGetConsumerParams result = new _MediaTypeConverterGetConsumerParams();

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
      
      result.consumer = decoder0.decodeInterfaceRequest(8, false, media_transport_mojom.MediaConsumerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(consumer, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "consumer of struct _MediaTypeConverterGetConsumerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaTypeConverterGetConsumerParams("
           "consumer: $consumer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaTypeConverterGetProducerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object producer = null;

  _MediaTypeConverterGetProducerParams() : super(kVersions.last.size);

  static _MediaTypeConverterGetProducerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTypeConverterGetProducerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTypeConverterGetProducerParams result = new _MediaTypeConverterGetProducerParams();

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
      
      result.producer = decoder0.decodeInterfaceRequest(8, false, media_transport_mojom.MediaProducerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(producer, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "producer of struct _MediaTypeConverterGetProducerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaTypeConverterGetProducerParams("
           "producer: $producer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _mediaTypeConverterMethodGetOutputTypeName = 0;
const int _mediaTypeConverterMethodGetConsumerName = 1;
const int _mediaTypeConverterMethodGetProducerName = 2;

class _MediaTypeConverterServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaTypeConverter {
  static const String serviceName = null;
  dynamic getOutputType([Function responseFactory = null]);
  void getConsumer(Object consumer);
  void getProducer(Object producer);
}


class _MediaTypeConverterProxyImpl extends bindings.Proxy {
  _MediaTypeConverterProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaTypeConverterProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaTypeConverterProxyImpl.unbound() : super.unbound();

  static _MediaTypeConverterProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaTypeConverterProxyImpl"));
    return new _MediaTypeConverterProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _MediaTypeConverterServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaTypeConverterMethodGetOutputTypeName:
        var r = MediaTypeConverterGetOutputTypeResponseParams.deserialize(
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
    return "_MediaTypeConverterProxyImpl($superString)";
  }
}


class _MediaTypeConverterProxyCalls implements MediaTypeConverter {
  _MediaTypeConverterProxyImpl _proxyImpl;

  _MediaTypeConverterProxyCalls(this._proxyImpl);
    dynamic getOutputType([Function responseFactory = null]) {
      var params = new _MediaTypeConverterGetOutputTypeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaTypeConverterMethodGetOutputTypeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getConsumer(Object consumer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaTypeConverterGetConsumerParams();
      params.consumer = consumer;
      _proxyImpl.sendMessage(params, _mediaTypeConverterMethodGetConsumerName);
    }
    void getProducer(Object producer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaTypeConverterGetProducerParams();
      params.producer = producer;
      _proxyImpl.sendMessage(params, _mediaTypeConverterMethodGetProducerName);
    }
}


class MediaTypeConverterProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaTypeConverter ptr;

  MediaTypeConverterProxy(_MediaTypeConverterProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaTypeConverterProxyCalls(proxyImpl);

  MediaTypeConverterProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaTypeConverterProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaTypeConverterProxyCalls(impl);
  }

  MediaTypeConverterProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaTypeConverterProxyImpl.fromHandle(handle) {
    ptr = new _MediaTypeConverterProxyCalls(impl);
  }

  MediaTypeConverterProxy.unbound() :
      impl = new _MediaTypeConverterProxyImpl.unbound() {
    ptr = new _MediaTypeConverterProxyCalls(impl);
  }

  factory MediaTypeConverterProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaTypeConverterProxy p = new MediaTypeConverterProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaTypeConverterProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaTypeConverterProxy"));
    return new MediaTypeConverterProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaTypeConverter.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaTypeConverterProxy($impl)";
  }
}


class MediaTypeConverterStub extends bindings.Stub {
  MediaTypeConverter _impl;

  MediaTypeConverterStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaTypeConverter impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  MediaTypeConverterStub.fromHandle(
      core.MojoHandle handle, [MediaTypeConverter impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  MediaTypeConverterStub.unbound() : super.unbound();

  static MediaTypeConverterStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaTypeConverterStub"));
    return new MediaTypeConverterStub.fromEndpoint(endpoint);
  }


  MediaTypeConverterGetOutputTypeResponseParams _mediaTypeConverterGetOutputTypeResponseParamsFactory(media_types_mojom.MediaType outputType) {
    var result = new MediaTypeConverterGetOutputTypeResponseParams();
    result.outputType = outputType;
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
      case _mediaTypeConverterMethodGetOutputTypeName:
        var response = _impl.getOutputType(_mediaTypeConverterGetOutputTypeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaTypeConverterMethodGetOutputTypeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaTypeConverterMethodGetOutputTypeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaTypeConverterMethodGetConsumerName:
        var params = _MediaTypeConverterGetConsumerParams.deserialize(
            message.payload);
        _impl.getConsumer(params.consumer);
        break;
      case _mediaTypeConverterMethodGetProducerName:
        var params = _MediaTypeConverterGetProducerParams.deserialize(
            message.payload);
        _impl.getProducer(params.producer);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaTypeConverter get impl => _impl;
  set impl(MediaTypeConverter d) {
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
    return "MediaTypeConverterStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaTypeConverterServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



