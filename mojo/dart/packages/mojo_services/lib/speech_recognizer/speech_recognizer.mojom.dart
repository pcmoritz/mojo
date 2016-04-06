// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library speech_recognizer_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class Error extends bindings.MojoEnum {
  static const Error networkTimeout = const Error._(1);
  static const Error network = const Error._(2);
  static const Error audio = const Error._(3);
  static const Error server = const Error._(4);
  static const Error client = const Error._(5);
  static const Error speechTimeout = const Error._(6);
  static const Error noMatch = const Error._(7);
  static const Error recognizerBusy = const Error._(8);
  static const Error insufficientPermissions = const Error._(9);

  const Error._(int v) : super(v);

  static const Map<String, Error> valuesMap = const {
    "networkTimeout": networkTimeout,
    "network": network,
    "audio": audio,
    "server": server,
    "client": client,
    "speechTimeout": speechTimeout,
    "noMatch": noMatch,
    "recognizerBusy": recognizerBusy,
    "insufficientPermissions": insufficientPermissions,
  };
  static const List<Error> values = const [
    networkTimeout,
    network,
    audio,
    server,
    client,
    speechTimeout,
    noMatch,
    recognizerBusy,
    insufficientPermissions,
  ];

  static Error valueOf(String name) => valuesMap[name];

  factory Error(int v) {
    switch (v) {
      case 1:
        return Error.networkTimeout;
      case 2:
        return Error.network;
      case 3:
        return Error.audio;
      case 4:
        return Error.server;
      case 5:
        return Error.client;
      case 6:
        return Error.speechTimeout;
      case 7:
        return Error.noMatch;
      case 8:
        return Error.recognizerBusy;
      case 9:
        return Error.insufficientPermissions;
      default:
        return null;
    }
  }

  static Error decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Error result = new Error(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Error.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case networkTimeout:
        return 'Error.networkTimeout';
      case network:
        return 'Error.network';
      case audio:
        return 'Error.audio';
      case server:
        return 'Error.server';
      case client:
        return 'Error.client';
      case speechTimeout:
        return 'Error.speechTimeout';
      case noMatch:
        return 'Error.noMatch';
      case recognizerBusy:
        return 'Error.recognizerBusy';
      case insufficientPermissions:
        return 'Error.insufficientPermissions';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class UtteranceCandidate extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String text = null;
  double confidenceScore = 0.0;

  UtteranceCandidate() : super(kVersions.last.size);

  static UtteranceCandidate deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UtteranceCandidate decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UtteranceCandidate result = new UtteranceCandidate();

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
      
      result.text = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.confidenceScore = decoder0.decodeFloat(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(text, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct UtteranceCandidate: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(confidenceScore, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "confidenceScore of struct UtteranceCandidate: $e";
      rethrow;
    }
  }

  String toString() {
    return "UtteranceCandidate("
           "text: $text" ", "
           "confidenceScore: $confidenceScore" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    map["confidenceScore"] = confidenceScore;
    return map;
  }
}


class _SpeechRecognizerListenerOnRecognizerErrorParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Error errorCode = null;

  _SpeechRecognizerListenerOnRecognizerErrorParams() : super(kVersions.last.size);

  static _SpeechRecognizerListenerOnRecognizerErrorParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SpeechRecognizerListenerOnRecognizerErrorParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SpeechRecognizerListenerOnRecognizerErrorParams result = new _SpeechRecognizerListenerOnRecognizerErrorParams();

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
      
        result.errorCode = Error.decode(decoder0, 8);
        if (result.errorCode == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(errorCode, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "errorCode of struct _SpeechRecognizerListenerOnRecognizerErrorParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SpeechRecognizerListenerOnRecognizerErrorParams("
           "errorCode: $errorCode" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["errorCode"] = errorCode;
    return map;
  }
}


class _SpeechRecognizerListenerOnResultsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<UtteranceCandidate> results = null;

  _SpeechRecognizerListenerOnResultsParams() : super(kVersions.last.size);

  static _SpeechRecognizerListenerOnResultsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SpeechRecognizerListenerOnResultsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SpeechRecognizerListenerOnResultsParams result = new _SpeechRecognizerListenerOnResultsParams();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.results = new List<UtteranceCandidate>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.results[i1] = UtteranceCandidate.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (results == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(results.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < results.length; ++i0) {
          encoder1.encodeStruct(results[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "results of struct _SpeechRecognizerListenerOnResultsParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SpeechRecognizerListenerOnResultsParams("
           "results: $results" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["results"] = results;
    return map;
  }
}


class _SpeechRecognizerListenerOnSoundLevelChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double rmsDb = 0.0;

  _SpeechRecognizerListenerOnSoundLevelChangedParams() : super(kVersions.last.size);

  static _SpeechRecognizerListenerOnSoundLevelChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SpeechRecognizerListenerOnSoundLevelChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SpeechRecognizerListenerOnSoundLevelChangedParams result = new _SpeechRecognizerListenerOnSoundLevelChangedParams();

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
      
      result.rmsDb = decoder0.decodeFloat(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeFloat(rmsDb, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rmsDb of struct _SpeechRecognizerListenerOnSoundLevelChangedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SpeechRecognizerListenerOnSoundLevelChangedParams("
           "rmsDb: $rmsDb" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rmsDb"] = rmsDb;
    return map;
  }
}


class _SpeechRecognizerServiceListenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object listener = null;

  _SpeechRecognizerServiceListenParams() : super(kVersions.last.size);

  static _SpeechRecognizerServiceListenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SpeechRecognizerServiceListenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SpeechRecognizerServiceListenParams result = new _SpeechRecognizerServiceListenParams();

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
      
      result.listener = decoder0.decodeServiceInterface(8, false, SpeechRecognizerListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(listener, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "listener of struct _SpeechRecognizerServiceListenParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SpeechRecognizerServiceListenParams("
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _SpeechRecognizerServiceStopListeningParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SpeechRecognizerServiceStopListeningParams() : super(kVersions.last.size);

  static _SpeechRecognizerServiceStopListeningParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SpeechRecognizerServiceStopListeningParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SpeechRecognizerServiceStopListeningParams result = new _SpeechRecognizerServiceStopListeningParams();

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
    return "_SpeechRecognizerServiceStopListeningParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _speechRecognizerListenerMethodOnRecognizerErrorName = 0;
const int _speechRecognizerListenerMethodOnResultsName = 1;
const int _speechRecognizerListenerMethodOnSoundLevelChangedName = 2;

class _SpeechRecognizerListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SpeechRecognizerListener {
  static const String serviceName = null;
  void onRecognizerError(Error errorCode);
  void onResults(List<UtteranceCandidate> results);
  void onSoundLevelChanged(double rmsDb);
}


class _SpeechRecognizerListenerProxyImpl extends bindings.Proxy {
  _SpeechRecognizerListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SpeechRecognizerListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SpeechRecognizerListenerProxyImpl.unbound() : super.unbound();

  static _SpeechRecognizerListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SpeechRecognizerListenerProxyImpl"));
    return new _SpeechRecognizerListenerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SpeechRecognizerListenerServiceDescription();

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
    return "_SpeechRecognizerListenerProxyImpl($superString)";
  }
}


class _SpeechRecognizerListenerProxyCalls implements SpeechRecognizerListener {
  _SpeechRecognizerListenerProxyImpl _proxyImpl;

  _SpeechRecognizerListenerProxyCalls(this._proxyImpl);
    void onRecognizerError(Error errorCode) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SpeechRecognizerListenerOnRecognizerErrorParams();
      params.errorCode = errorCode;
      _proxyImpl.sendMessage(params, _speechRecognizerListenerMethodOnRecognizerErrorName);
    }
    void onResults(List<UtteranceCandidate> results) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SpeechRecognizerListenerOnResultsParams();
      params.results = results;
      _proxyImpl.sendMessage(params, _speechRecognizerListenerMethodOnResultsName);
    }
    void onSoundLevelChanged(double rmsDb) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SpeechRecognizerListenerOnSoundLevelChangedParams();
      params.rmsDb = rmsDb;
      _proxyImpl.sendMessage(params, _speechRecognizerListenerMethodOnSoundLevelChangedName);
    }
}


class SpeechRecognizerListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SpeechRecognizerListener ptr;

  SpeechRecognizerListenerProxy(_SpeechRecognizerListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SpeechRecognizerListenerProxyCalls(proxyImpl);

  SpeechRecognizerListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SpeechRecognizerListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SpeechRecognizerListenerProxyCalls(impl);
  }

  SpeechRecognizerListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SpeechRecognizerListenerProxyImpl.fromHandle(handle) {
    ptr = new _SpeechRecognizerListenerProxyCalls(impl);
  }

  SpeechRecognizerListenerProxy.unbound() :
      impl = new _SpeechRecognizerListenerProxyImpl.unbound() {
    ptr = new _SpeechRecognizerListenerProxyCalls(impl);
  }

  factory SpeechRecognizerListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SpeechRecognizerListenerProxy p = new SpeechRecognizerListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SpeechRecognizerListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SpeechRecognizerListenerProxy"));
    return new SpeechRecognizerListenerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SpeechRecognizerListener.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SpeechRecognizerListenerProxy($impl)";
  }
}


class SpeechRecognizerListenerStub extends bindings.Stub {
  SpeechRecognizerListener _impl = null;

  SpeechRecognizerListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SpeechRecognizerListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SpeechRecognizerListenerStub.unbound() : super.unbound();

  static SpeechRecognizerListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SpeechRecognizerListenerStub"));
    return new SpeechRecognizerListenerStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _speechRecognizerListenerMethodOnRecognizerErrorName:
        var params = _SpeechRecognizerListenerOnRecognizerErrorParams.deserialize(
            message.payload);
        _impl.onRecognizerError(params.errorCode);
        break;
      case _speechRecognizerListenerMethodOnResultsName:
        var params = _SpeechRecognizerListenerOnResultsParams.deserialize(
            message.payload);
        _impl.onResults(params.results);
        break;
      case _speechRecognizerListenerMethodOnSoundLevelChangedName:
        var params = _SpeechRecognizerListenerOnSoundLevelChangedParams.deserialize(
            message.payload);
        _impl.onSoundLevelChanged(params.rmsDb);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SpeechRecognizerListener get impl => _impl;
  set impl(SpeechRecognizerListener d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SpeechRecognizerListenerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SpeechRecognizerListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _speechRecognizerServiceMethodListenName = 0;
const int _speechRecognizerServiceMethodStopListeningName = 1;

class _SpeechRecognizerServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SpeechRecognizerService {
  static const String serviceName = "speech_recognizer::SpeechRecognizerService";
  void listen(Object listener);
  void stopListening();
}


class _SpeechRecognizerServiceProxyImpl extends bindings.Proxy {
  _SpeechRecognizerServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SpeechRecognizerServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SpeechRecognizerServiceProxyImpl.unbound() : super.unbound();

  static _SpeechRecognizerServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SpeechRecognizerServiceProxyImpl"));
    return new _SpeechRecognizerServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SpeechRecognizerServiceServiceDescription();

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
    return "_SpeechRecognizerServiceProxyImpl($superString)";
  }
}


class _SpeechRecognizerServiceProxyCalls implements SpeechRecognizerService {
  _SpeechRecognizerServiceProxyImpl _proxyImpl;

  _SpeechRecognizerServiceProxyCalls(this._proxyImpl);
    void listen(Object listener) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SpeechRecognizerServiceListenParams();
      params.listener = listener;
      _proxyImpl.sendMessage(params, _speechRecognizerServiceMethodListenName);
    }
    void stopListening() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SpeechRecognizerServiceStopListeningParams();
      _proxyImpl.sendMessage(params, _speechRecognizerServiceMethodStopListeningName);
    }
}


class SpeechRecognizerServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SpeechRecognizerService ptr;

  SpeechRecognizerServiceProxy(_SpeechRecognizerServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SpeechRecognizerServiceProxyCalls(proxyImpl);

  SpeechRecognizerServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SpeechRecognizerServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SpeechRecognizerServiceProxyCalls(impl);
  }

  SpeechRecognizerServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SpeechRecognizerServiceProxyImpl.fromHandle(handle) {
    ptr = new _SpeechRecognizerServiceProxyCalls(impl);
  }

  SpeechRecognizerServiceProxy.unbound() :
      impl = new _SpeechRecognizerServiceProxyImpl.unbound() {
    ptr = new _SpeechRecognizerServiceProxyCalls(impl);
  }

  factory SpeechRecognizerServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SpeechRecognizerServiceProxy p = new SpeechRecognizerServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SpeechRecognizerServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SpeechRecognizerServiceProxy"));
    return new SpeechRecognizerServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SpeechRecognizerService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SpeechRecognizerServiceProxy($impl)";
  }
}


class SpeechRecognizerServiceStub extends bindings.Stub {
  SpeechRecognizerService _impl = null;

  SpeechRecognizerServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SpeechRecognizerServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SpeechRecognizerServiceStub.unbound() : super.unbound();

  static SpeechRecognizerServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SpeechRecognizerServiceStub"));
    return new SpeechRecognizerServiceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _speechRecognizerServiceMethodListenName:
        var params = _SpeechRecognizerServiceListenParams.deserialize(
            message.payload);
        _impl.listen(params.listener);
        break;
      case _speechRecognizerServiceMethodStopListeningName:
        _impl.stopListening();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SpeechRecognizerService get impl => _impl;
  set impl(SpeechRecognizerService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SpeechRecognizerServiceStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SpeechRecognizerServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



