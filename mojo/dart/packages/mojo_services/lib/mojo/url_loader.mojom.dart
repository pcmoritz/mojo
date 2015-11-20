// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library url_loader_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo/mojo/url_request.mojom.dart' as url_request_mojom;
import 'package:mojo/mojo/url_response.mojom.dart' as url_response_mojom;



class UrlLoaderStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError error = null;
  bool isLoading = false;

  UrlLoaderStatus() : super(kVersions.last.size);

  static UrlLoaderStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderStatus result = new UrlLoaderStatus();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.error = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isLoading = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(error, 8, true);
    
    encoder0.encodeBool(isLoading, 16, 0);
  }

  String toString() {
    return "UrlLoaderStatus("
           "error: $error" ", "
           "isLoading: $isLoading" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["isLoading"] = isLoading;
    return map;
  }
}


class UrlLoaderStartParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_request_mojom.UrlRequest request = null;

  UrlLoaderStartParams() : super(kVersions.last.size);

  static UrlLoaderStartParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderStartParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderStartParams result = new UrlLoaderStartParams();

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
      result.request = url_request_mojom.UrlRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(request, 8, false);
  }

  String toString() {
    return "UrlLoaderStartParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlLoaderStartResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlLoaderStartResponseParams() : super(kVersions.last.size);

  static UrlLoaderStartResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderStartResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderStartResponseParams result = new UrlLoaderStartResponseParams();

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
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(response, 8, false);
  }

  String toString() {
    return "UrlLoaderStartResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlLoaderFollowRedirectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  UrlLoaderFollowRedirectParams() : super(kVersions.last.size);

  static UrlLoaderFollowRedirectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderFollowRedirectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderFollowRedirectParams result = new UrlLoaderFollowRedirectParams();

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
    return "UrlLoaderFollowRedirectParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class UrlLoaderFollowRedirectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlLoaderFollowRedirectResponseParams() : super(kVersions.last.size);

  static UrlLoaderFollowRedirectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderFollowRedirectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderFollowRedirectResponseParams result = new UrlLoaderFollowRedirectResponseParams();

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
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(response, 8, false);
  }

  String toString() {
    return "UrlLoaderFollowRedirectResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlLoaderQueryStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  UrlLoaderQueryStatusParams() : super(kVersions.last.size);

  static UrlLoaderQueryStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderQueryStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderQueryStatusParams result = new UrlLoaderQueryStatusParams();

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
    return "UrlLoaderQueryStatusParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class UrlLoaderQueryStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderStatus status = null;

  UrlLoaderQueryStatusResponseParams() : super(kVersions.last.size);

  static UrlLoaderQueryStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderQueryStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderQueryStatusResponseParams result = new UrlLoaderQueryStatusResponseParams();

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
      result.status = UrlLoaderStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(status, 8, false);
  }

  String toString() {
    return "UrlLoaderQueryStatusResponseParams("
           "status: $status" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["status"] = status;
    return map;
  }
}

const int kUrlLoader_start_name = 0;
const int kUrlLoader_followRedirect_name = 1;
const int kUrlLoader_queryStatus_name = 2;

const String UrlLoaderName =
      'mojo::URLLoader';

abstract class UrlLoader {
  dynamic start(url_request_mojom.UrlRequest request,[Function responseFactory = null]);
  dynamic followRedirect([Function responseFactory = null]);
  dynamic queryStatus([Function responseFactory = null]);

}


class UrlLoaderProxyImpl extends bindings.Proxy {
  UrlLoaderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  UrlLoaderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  UrlLoaderProxyImpl.unbound() : super.unbound();

  static UrlLoaderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderProxyImpl"));
    return new UrlLoaderProxyImpl.fromEndpoint(endpoint);
  }

  String get name => UrlLoaderName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kUrlLoader_start_name:
        var r = UrlLoaderStartResponseParams.deserialize(
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
      case kUrlLoader_followRedirect_name:
        var r = UrlLoaderFollowRedirectResponseParams.deserialize(
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
      case kUrlLoader_queryStatus_name:
        var r = UrlLoaderQueryStatusResponseParams.deserialize(
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
    return "UrlLoaderProxyImpl($superString)";
  }
}


class _UrlLoaderProxyCalls implements UrlLoader {
  UrlLoaderProxyImpl _proxyImpl;

  _UrlLoaderProxyCalls(this._proxyImpl);
    dynamic start(url_request_mojom.UrlRequest request,[Function responseFactory = null]) {
      var params = new UrlLoaderStartParams();
      params.request = request;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUrlLoader_start_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic followRedirect([Function responseFactory = null]) {
      var params = new UrlLoaderFollowRedirectParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUrlLoader_followRedirect_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic queryStatus([Function responseFactory = null]) {
      var params = new UrlLoaderQueryStatusParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUrlLoader_queryStatus_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class UrlLoaderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UrlLoader ptr;
  final String name = UrlLoaderName;

  UrlLoaderProxy(UrlLoaderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UrlLoaderProxyCalls(proxyImpl);

  UrlLoaderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new UrlLoaderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UrlLoaderProxyCalls(impl);
  }

  UrlLoaderProxy.fromHandle(core.MojoHandle handle) :
      impl = new UrlLoaderProxyImpl.fromHandle(handle) {
    ptr = new _UrlLoaderProxyCalls(impl);
  }

  UrlLoaderProxy.unbound() :
      impl = new UrlLoaderProxyImpl.unbound() {
    ptr = new _UrlLoaderProxyCalls(impl);
  }

  factory UrlLoaderProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    UrlLoaderProxy p = new UrlLoaderProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static UrlLoaderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderProxy"));
    return new UrlLoaderProxy.fromEndpoint(endpoint);
  }

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "UrlLoaderProxy($impl)";
  }
}


class UrlLoaderStub extends bindings.Stub {
  UrlLoader _impl = null;

  UrlLoaderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UrlLoaderStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UrlLoaderStub.unbound() : super.unbound();

  static UrlLoaderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderStub"));
    return new UrlLoaderStub.fromEndpoint(endpoint);
  }

  static const String name = UrlLoaderName;


  UrlLoaderStartResponseParams _UrlLoaderStartResponseParamsFactory(url_response_mojom.UrlResponse response) {
    var mojo_factory_result = new UrlLoaderStartResponseParams();
    mojo_factory_result.response = response;
    return mojo_factory_result;
  }
  UrlLoaderFollowRedirectResponseParams _UrlLoaderFollowRedirectResponseParamsFactory(url_response_mojom.UrlResponse response) {
    var mojo_factory_result = new UrlLoaderFollowRedirectResponseParams();
    mojo_factory_result.response = response;
    return mojo_factory_result;
  }
  UrlLoaderQueryStatusResponseParams _UrlLoaderQueryStatusResponseParamsFactory(UrlLoaderStatus status) {
    var mojo_factory_result = new UrlLoaderQueryStatusResponseParams();
    mojo_factory_result.status = status;
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
      case kUrlLoader_start_name:
        var params = UrlLoaderStartParams.deserialize(
            message.payload);
        var response = _impl.start(params.request,_UrlLoaderStartResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUrlLoader_start_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUrlLoader_start_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUrlLoader_followRedirect_name:
        var params = UrlLoaderFollowRedirectParams.deserialize(
            message.payload);
        var response = _impl.followRedirect(_UrlLoaderFollowRedirectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUrlLoader_followRedirect_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUrlLoader_followRedirect_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUrlLoader_queryStatus_name:
        var params = UrlLoaderQueryStatusParams.deserialize(
            message.payload);
        var response = _impl.queryStatus(_UrlLoaderQueryStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUrlLoader_queryStatus_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUrlLoader_queryStatus_name,
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

  UrlLoader get impl => _impl;
  set impl(UrlLoader d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UrlLoaderStub($superString)";
  }

  int get version => 0;
}

