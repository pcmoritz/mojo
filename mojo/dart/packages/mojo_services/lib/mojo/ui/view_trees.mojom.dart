// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_trees_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/ui/layouts.mojom.dart' as layouts_mojom;
import 'package:mojo_services/mojo/ui/views.mojom.dart' as views_mojom;



class ViewTreeToken extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int value = 0;

  ViewTreeToken() : super(kVersions.last.size);

  static ViewTreeToken deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeToken decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeToken result = new ViewTreeToken();

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
      
      result.value = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct ViewTreeToken: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewTreeToken("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


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
  ViewTreeToken token = null;

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
      result.token = ViewTreeToken.decode(decoder1);
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


class _ViewTreeRequestLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeRequestLayoutParams() : super(kVersions.last.size);

  static _ViewTreeRequestLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeRequestLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeRequestLayoutParams result = new _ViewTreeRequestLayoutParams();

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
    return "_ViewTreeRequestLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewTreeSetRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int rootKey = 0;
  Object rootViewOwner = null;

  _ViewTreeSetRootParams() : super(kVersions.last.size);

  static _ViewTreeSetRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeSetRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeSetRootParams result = new _ViewTreeSetRootParams();

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
      
      result.rootKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.rootViewOwner = decoder0.decodeServiceInterface(12, false, views_mojom.ViewOwnerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(rootKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rootKey of struct _ViewTreeSetRootParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(rootViewOwner, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rootViewOwner of struct _ViewTreeSetRootParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeSetRootParams("
           "rootKey: $rootKey" ", "
           "rootViewOwner: $rootViewOwner" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeResetRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object transferredViewOwner = null;

  _ViewTreeResetRootParams() : super(kVersions.last.size);

  static _ViewTreeResetRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeResetRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeResetRootParams result = new _ViewTreeResetRootParams();

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
      
      result.transferredViewOwner = decoder0.decodeInterfaceRequest(8, true, views_mojom.ViewOwnerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(transferredViewOwner, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "transferredViewOwner of struct _ViewTreeResetRootParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeResetRootParams("
           "transferredViewOwner: $transferredViewOwner" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeLayoutRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutParams rootLayoutParams = null;

  _ViewTreeLayoutRootParams() : super(kVersions.last.size);

  static _ViewTreeLayoutRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeLayoutRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeLayoutRootParams result = new _ViewTreeLayoutRootParams();

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
      result.rootLayoutParams = layouts_mojom.ViewLayoutParams.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(rootLayoutParams, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rootLayoutParams of struct _ViewTreeLayoutRootParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeLayoutRootParams("
           "rootLayoutParams: $rootLayoutParams" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rootLayoutParams"] = rootLayoutParams;
    return map;
  }
}


class ViewTreeLayoutRootResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutInfo info = null;

  ViewTreeLayoutRootResponseParams() : super(kVersions.last.size);

  static ViewTreeLayoutRootResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeLayoutRootResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeLayoutRootResponseParams result = new ViewTreeLayoutRootResponseParams();

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
      result.info = layouts_mojom.ViewLayoutInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(info, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "info of struct ViewTreeLayoutRootResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewTreeLayoutRootResponseParams("
           "info: $info" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["info"] = info;
    return map;
  }
}


class _ViewTreeListenerOnLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeListenerOnLayoutParams() : super(kVersions.last.size);

  static _ViewTreeListenerOnLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeListenerOnLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeListenerOnLayoutParams result = new _ViewTreeListenerOnLayoutParams();

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
    return "_ViewTreeListenerOnLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeListenerOnLayoutResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeListenerOnLayoutResponseParams() : super(kVersions.last.size);

  static ViewTreeListenerOnLayoutResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeListenerOnLayoutResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeListenerOnLayoutResponseParams result = new ViewTreeListenerOnLayoutResponseParams();

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
    return "ViewTreeListenerOnLayoutResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewTreeListenerOnRootUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int rootKey = 0;

  _ViewTreeListenerOnRootUnavailableParams() : super(kVersions.last.size);

  static _ViewTreeListenerOnRootUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeListenerOnRootUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeListenerOnRootUnavailableParams result = new _ViewTreeListenerOnRootUnavailableParams();

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
      
      result.rootKey = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(rootKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rootKey of struct _ViewTreeListenerOnRootUnavailableParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeListenerOnRootUnavailableParams("
           "rootKey: $rootKey" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rootKey"] = rootKey;
    return map;
  }
}


class ViewTreeListenerOnRootUnavailableResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeListenerOnRootUnavailableResponseParams() : super(kVersions.last.size);

  static ViewTreeListenerOnRootUnavailableResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeListenerOnRootUnavailableResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeListenerOnRootUnavailableResponseParams result = new ViewTreeListenerOnRootUnavailableResponseParams();

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
    return "ViewTreeListenerOnRootUnavailableResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _ViewTree_getTokenName = 0;
const int _ViewTree_getServiceProviderName = 1;
const int _ViewTree_requestLayoutName = 2;
const int _ViewTree_setRootName = 3;
const int _ViewTree_resetRootName = 4;
const int _ViewTree_layoutRootName = 5;

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
  void requestLayout();
  void setRoot(int rootKey, Object rootViewOwner);
  void resetRoot(Object transferredViewOwner);
  dynamic layoutRoot(layouts_mojom.ViewLayoutParams rootLayoutParams,[Function responseFactory = null]);
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
      case _ViewTree_getTokenName:
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
      case _ViewTree_layoutRootName:
        var r = ViewTreeLayoutRootResponseParams.deserialize(
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
          _ViewTree_getTokenName,
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
      _proxyImpl.sendMessage(params, _ViewTree_getServiceProviderName);
    }
    void requestLayout() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeRequestLayoutParams();
      _proxyImpl.sendMessage(params, _ViewTree_requestLayoutName);
    }
    void setRoot(int rootKey, Object rootViewOwner) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeSetRootParams();
      params.rootKey = rootKey;
      params.rootViewOwner = rootViewOwner;
      _proxyImpl.sendMessage(params, _ViewTree_setRootName);
    }
    void resetRoot(Object transferredViewOwner) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeResetRootParams();
      params.transferredViewOwner = transferredViewOwner;
      _proxyImpl.sendMessage(params, _ViewTree_resetRootName);
    }
    dynamic layoutRoot(layouts_mojom.ViewLayoutParams rootLayoutParams,[Function responseFactory = null]) {
      var params = new _ViewTreeLayoutRootParams();
      params.rootLayoutParams = rootLayoutParams;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewTree_layoutRootName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
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
  ViewTree _impl = null;

  ViewTreeStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewTreeStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewTreeStub.unbound() : super.unbound();

  static ViewTreeStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeStub"));
    return new ViewTreeStub.fromEndpoint(endpoint);
  }


  ViewTreeGetTokenResponseParams _ViewTreeGetTokenResponseParamsFactory(ViewTreeToken token) {
    var mojo_factory_result = new ViewTreeGetTokenResponseParams();
    mojo_factory_result.token = token;
    return mojo_factory_result;
  }
  ViewTreeLayoutRootResponseParams _ViewTreeLayoutRootResponseParamsFactory(layouts_mojom.ViewLayoutInfo info) {
    var mojo_factory_result = new ViewTreeLayoutRootResponseParams();
    mojo_factory_result.info = info;
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
      case _ViewTree_getTokenName:
        var response = _impl.getToken(_ViewTreeGetTokenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewTree_getTokenName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewTree_getTokenName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _ViewTree_getServiceProviderName:
        var params = _ViewTreeGetServiceProviderParams.deserialize(
            message.payload);
        _impl.getServiceProvider(params.serviceProvider);
        break;
      case _ViewTree_requestLayoutName:
        _impl.requestLayout();
        break;
      case _ViewTree_setRootName:
        var params = _ViewTreeSetRootParams.deserialize(
            message.payload);
        _impl.setRoot(params.rootKey, params.rootViewOwner);
        break;
      case _ViewTree_resetRootName:
        var params = _ViewTreeResetRootParams.deserialize(
            message.payload);
        _impl.resetRoot(params.transferredViewOwner);
        break;
      case _ViewTree_layoutRootName:
        var params = _ViewTreeLayoutRootParams.deserialize(
            message.payload);
        var response = _impl.layoutRoot(params.rootLayoutParams,_ViewTreeLayoutRootResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewTree_layoutRootName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewTree_layoutRootName,
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

  ViewTree get impl => _impl;
  set impl(ViewTree d) {
    assert(_impl == null);
    _impl = d;
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

const int _ViewTreeListener_onLayoutName = 0;
const int _ViewTreeListener_onRootUnavailableName = 1;

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
  dynamic onLayout([Function responseFactory = null]);
  dynamic onRootUnavailable(int rootKey,[Function responseFactory = null]);
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
      case _ViewTreeListener_onLayoutName:
        var r = ViewTreeListenerOnLayoutResponseParams.deserialize(
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
      case _ViewTreeListener_onRootUnavailableName:
        var r = ViewTreeListenerOnRootUnavailableResponseParams.deserialize(
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
    dynamic onLayout([Function responseFactory = null]) {
      var params = new _ViewTreeListenerOnLayoutParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewTreeListener_onLayoutName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic onRootUnavailable(int rootKey,[Function responseFactory = null]) {
      var params = new _ViewTreeListenerOnRootUnavailableParams();
      params.rootKey = rootKey;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewTreeListener_onRootUnavailableName,
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
  ViewTreeListener _impl = null;

  ViewTreeListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewTreeListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewTreeListenerStub.unbound() : super.unbound();

  static ViewTreeListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeListenerStub"));
    return new ViewTreeListenerStub.fromEndpoint(endpoint);
  }


  ViewTreeListenerOnLayoutResponseParams _ViewTreeListenerOnLayoutResponseParamsFactory() {
    var mojo_factory_result = new ViewTreeListenerOnLayoutResponseParams();
    return mojo_factory_result;
  }
  ViewTreeListenerOnRootUnavailableResponseParams _ViewTreeListenerOnRootUnavailableResponseParamsFactory() {
    var mojo_factory_result = new ViewTreeListenerOnRootUnavailableResponseParams();
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
      case _ViewTreeListener_onLayoutName:
        var response = _impl.onLayout(_ViewTreeListenerOnLayoutResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewTreeListener_onLayoutName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewTreeListener_onLayoutName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _ViewTreeListener_onRootUnavailableName:
        var params = _ViewTreeListenerOnRootUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onRootUnavailable(params.rootKey,_ViewTreeListenerOnRootUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewTreeListener_onRootUnavailableName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewTreeListener_onRootUnavailableName,
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
    assert(_impl == null);
    _impl = d;
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



