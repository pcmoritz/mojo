// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_transport_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_common.mojom.dart' as media_common_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;



class MediaPacketRegion extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int offset = 0;
  int length = 0;

  MediaPacketRegion() : super(kVersions.last.size);

  static MediaPacketRegion deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPacketRegion decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPacketRegion result = new MediaPacketRegion();

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
      
      result.offset = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.length = decoder0.decodeUint64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(offset, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "offset of struct MediaPacketRegion: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(length, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "length of struct MediaPacketRegion: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaPacketRegion("
           "offset: $offset" ", "
           "length: $length" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["offset"] = offset;
    map["length"] = length;
    return map;
  }
}


class MediaPacket extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  static const int kNoTimestamp = 9223372036854775807;
  int pts = 9223372036854775807;
  bool endOfStream = false;
  MediaPacketRegion payload = null;
  List<MediaPacketRegion> extraPayload = null;

  MediaPacket() : super(kVersions.last.size);

  static MediaPacket deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPacket decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPacket result = new MediaPacket();

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
      
      result.pts = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.endOfStream = decoder0.decodeBool(16, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.payload = MediaPacketRegion.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, true);
      if (decoder1 == null) {
        result.extraPayload = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.extraPayload = new List<MediaPacketRegion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.extraPayload[i1] = MediaPacketRegion.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(pts, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pts of struct MediaPacket: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(endOfStream, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "endOfStream of struct MediaPacket: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(payload, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "payload of struct MediaPacket: $e";
      rethrow;
    }
    try {
      if (extraPayload == null) {
        encoder0.encodeNullPointer(32, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(extraPayload.length, 32, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < extraPayload.length; ++i0) {
          encoder1.encodeStruct(extraPayload[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "extraPayload of struct MediaPacket: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaPacket("
           "pts: $pts" ", "
           "endOfStream: $endOfStream" ", "
           "payload: $payload" ", "
           "extraPayload: $extraPayload" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pts"] = pts;
    map["endOfStream"] = endOfStream;
    map["payload"] = payload;
    map["extraPayload"] = extraPayload;
    return map;
  }
}


class _MediaProducerConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object consumer = null;

  _MediaProducerConnectParams() : super(kVersions.last.size);

  static _MediaProducerConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaProducerConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaProducerConnectParams result = new _MediaProducerConnectParams();

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
      
      result.consumer = decoder0.decodeServiceInterface(8, false, MediaConsumerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(consumer, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "consumer of struct _MediaProducerConnectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaProducerConnectParams("
           "consumer: $consumer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class MediaProducerConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaProducerConnectResponseParams() : super(kVersions.last.size);

  static MediaProducerConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaProducerConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaProducerConnectResponseParams result = new MediaProducerConnectResponseParams();

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
    return "MediaProducerConnectResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaProducerDisconnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaProducerDisconnectParams() : super(kVersions.last.size);

  static _MediaProducerDisconnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaProducerDisconnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaProducerDisconnectParams result = new _MediaProducerDisconnectParams();

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
    return "_MediaProducerDisconnectParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaPullModeProducerGetBufferParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaPullModeProducerGetBufferParams() : super(kVersions.last.size);

  static _MediaPullModeProducerGetBufferParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPullModeProducerGetBufferParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPullModeProducerGetBufferParams result = new _MediaPullModeProducerGetBufferParams();

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
    return "_MediaPullModeProducerGetBufferParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaPullModeProducerGetBufferResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoSharedBuffer buffer = null;

  MediaPullModeProducerGetBufferResponseParams() : super(kVersions.last.size);

  static MediaPullModeProducerGetBufferResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPullModeProducerGetBufferResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPullModeProducerGetBufferResponseParams result = new MediaPullModeProducerGetBufferResponseParams();

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
      
      result.buffer = decoder0.decodeSharedBufferHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeSharedBufferHandle(buffer, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "buffer of struct MediaPullModeProducerGetBufferResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaPullModeProducerGetBufferResponseParams("
           "buffer: $buffer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaPullModeProducerPullPacketParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaPacket toRelease = null;

  _MediaPullModeProducerPullPacketParams() : super(kVersions.last.size);

  static _MediaPullModeProducerPullPacketParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPullModeProducerPullPacketParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPullModeProducerPullPacketParams result = new _MediaPullModeProducerPullPacketParams();

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
      result.toRelease = MediaPacket.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(toRelease, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "toRelease of struct _MediaPullModeProducerPullPacketParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaPullModeProducerPullPacketParams("
           "toRelease: $toRelease" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["toRelease"] = toRelease;
    return map;
  }
}


class MediaPullModeProducerPullPacketResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaPacket packet = null;

  MediaPullModeProducerPullPacketResponseParams() : super(kVersions.last.size);

  static MediaPullModeProducerPullPacketResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPullModeProducerPullPacketResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPullModeProducerPullPacketResponseParams result = new MediaPullModeProducerPullPacketResponseParams();

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
      result.packet = MediaPacket.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(packet, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "packet of struct MediaPullModeProducerPullPacketResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaPullModeProducerPullPacketResponseParams("
           "packet: $packet" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["packet"] = packet;
    return map;
  }
}


class _MediaPullModeProducerReleasePacketParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaPacket toRelease = null;

  _MediaPullModeProducerReleasePacketParams() : super(kVersions.last.size);

  static _MediaPullModeProducerReleasePacketParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPullModeProducerReleasePacketParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPullModeProducerReleasePacketParams result = new _MediaPullModeProducerReleasePacketParams();

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
      result.toRelease = MediaPacket.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(toRelease, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "toRelease of struct _MediaPullModeProducerReleasePacketParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaPullModeProducerReleasePacketParams("
           "toRelease: $toRelease" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["toRelease"] = toRelease;
    return map;
  }
}


class _MediaConsumerSetBufferParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoSharedBuffer buffer = null;
  int size = 0;

  _MediaConsumerSetBufferParams() : super(kVersions.last.size);

  static _MediaConsumerSetBufferParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaConsumerSetBufferParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaConsumerSetBufferParams result = new _MediaConsumerSetBufferParams();

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
      
      result.buffer = decoder0.decodeSharedBufferHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.size = decoder0.decodeUint64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeSharedBufferHandle(buffer, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "buffer of struct _MediaConsumerSetBufferParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(size, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct _MediaConsumerSetBufferParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaConsumerSetBufferParams("
           "buffer: $buffer" ", "
           "size: $size" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class MediaConsumerSetBufferResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaConsumerSetBufferResponseParams() : super(kVersions.last.size);

  static MediaConsumerSetBufferResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaConsumerSetBufferResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaConsumerSetBufferResponseParams result = new MediaConsumerSetBufferResponseParams();

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
    return "MediaConsumerSetBufferResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaConsumerSendPacketParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaPacket packet = null;

  _MediaConsumerSendPacketParams() : super(kVersions.last.size);

  static _MediaConsumerSendPacketParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaConsumerSendPacketParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaConsumerSendPacketParams result = new _MediaConsumerSendPacketParams();

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
      result.packet = MediaPacket.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(packet, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "packet of struct _MediaConsumerSendPacketParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaConsumerSendPacketParams("
           "packet: $packet" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["packet"] = packet;
    return map;
  }
}


class MediaConsumerSendPacketResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaConsumerSendResult result = null;

  MediaConsumerSendPacketResponseParams() : super(kVersions.last.size);

  static MediaConsumerSendPacketResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaConsumerSendPacketResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaConsumerSendPacketResponseParams result = new MediaConsumerSendPacketResponseParams();

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
      
        result.result = MediaConsumerSendResult.decode(decoder0, 8);
        if (result.result == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable MediaConsumerSendResult.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(result, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct MediaConsumerSendPacketResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaConsumerSendPacketResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _MediaConsumerPrimeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaConsumerPrimeParams() : super(kVersions.last.size);

  static _MediaConsumerPrimeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaConsumerPrimeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaConsumerPrimeParams result = new _MediaConsumerPrimeParams();

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
    return "_MediaConsumerPrimeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaConsumerPrimeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaConsumerPrimeResponseParams() : super(kVersions.last.size);

  static MediaConsumerPrimeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaConsumerPrimeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaConsumerPrimeResponseParams result = new MediaConsumerPrimeResponseParams();

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
    return "MediaConsumerPrimeResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaConsumerFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaConsumerFlushParams() : super(kVersions.last.size);

  static _MediaConsumerFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaConsumerFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaConsumerFlushParams result = new _MediaConsumerFlushParams();

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
    return "_MediaConsumerFlushParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaConsumerFlushResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaConsumerFlushResponseParams() : super(kVersions.last.size);

  static MediaConsumerFlushResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaConsumerFlushResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaConsumerFlushResponseParams result = new MediaConsumerFlushResponseParams();

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
    return "MediaConsumerFlushResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _mediaProducerMethodConnectName = 0;
const int _mediaProducerMethodDisconnectName = 1;

class _MediaProducerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaProducer {
  static const String serviceName = null;
  dynamic connect(Object consumer,[Function responseFactory = null]);
  void disconnect();
}


class _MediaProducerProxyImpl extends bindings.Proxy {
  _MediaProducerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaProducerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaProducerProxyImpl.unbound() : super.unbound();

  static _MediaProducerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaProducerProxyImpl"));
    return new _MediaProducerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _MediaProducerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaProducerMethodConnectName:
        var r = MediaProducerConnectResponseParams.deserialize(
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
    return "_MediaProducerProxyImpl($superString)";
  }
}


class _MediaProducerProxyCalls implements MediaProducer {
  _MediaProducerProxyImpl _proxyImpl;

  _MediaProducerProxyCalls(this._proxyImpl);
    dynamic connect(Object consumer,[Function responseFactory = null]) {
      var params = new _MediaProducerConnectParams();
      params.consumer = consumer;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaProducerMethodConnectName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void disconnect() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaProducerDisconnectParams();
      _proxyImpl.sendMessage(params, _mediaProducerMethodDisconnectName);
    }
}


class MediaProducerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaProducer ptr;

  MediaProducerProxy(_MediaProducerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaProducerProxyCalls(proxyImpl);

  MediaProducerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaProducerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaProducerProxyCalls(impl);
  }

  MediaProducerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaProducerProxyImpl.fromHandle(handle) {
    ptr = new _MediaProducerProxyCalls(impl);
  }

  MediaProducerProxy.unbound() :
      impl = new _MediaProducerProxyImpl.unbound() {
    ptr = new _MediaProducerProxyCalls(impl);
  }

  factory MediaProducerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaProducerProxy p = new MediaProducerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaProducerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaProducerProxy"));
    return new MediaProducerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaProducer.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaProducerProxy($impl)";
  }
}


class MediaProducerStub extends bindings.Stub {
  MediaProducer _impl = null;

  MediaProducerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MediaProducerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MediaProducerStub.unbound() : super.unbound();

  static MediaProducerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaProducerStub"));
    return new MediaProducerStub.fromEndpoint(endpoint);
  }


  MediaProducerConnectResponseParams _mediaProducerConnectResponseParamsFactory() {
    var result = new MediaProducerConnectResponseParams();
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _mediaProducerMethodConnectName:
        var params = _MediaProducerConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.consumer,_mediaProducerConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaProducerMethodConnectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaProducerMethodConnectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaProducerMethodDisconnectName:
        _impl.disconnect();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaProducer get impl => _impl;
  set impl(MediaProducer d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MediaProducerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaProducerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _mediaPullModeProducerMethodGetBufferName = 0;
const int _mediaPullModeProducerMethodPullPacketName = 1;
const int _mediaPullModeProducerMethodReleasePacketName = 2;

class _MediaPullModeProducerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaPullModeProducer {
  static const String serviceName = null;
  dynamic getBuffer([Function responseFactory = null]);
  dynamic pullPacket(MediaPacket toRelease,[Function responseFactory = null]);
  void releasePacket(MediaPacket toRelease);
}


class _MediaPullModeProducerProxyImpl extends bindings.Proxy {
  _MediaPullModeProducerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaPullModeProducerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaPullModeProducerProxyImpl.unbound() : super.unbound();

  static _MediaPullModeProducerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaPullModeProducerProxyImpl"));
    return new _MediaPullModeProducerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _MediaPullModeProducerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaPullModeProducerMethodGetBufferName:
        var r = MediaPullModeProducerGetBufferResponseParams.deserialize(
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
      case _mediaPullModeProducerMethodPullPacketName:
        var r = MediaPullModeProducerPullPacketResponseParams.deserialize(
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
    return "_MediaPullModeProducerProxyImpl($superString)";
  }
}


class _MediaPullModeProducerProxyCalls implements MediaPullModeProducer {
  _MediaPullModeProducerProxyImpl _proxyImpl;

  _MediaPullModeProducerProxyCalls(this._proxyImpl);
    dynamic getBuffer([Function responseFactory = null]) {
      var params = new _MediaPullModeProducerGetBufferParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaPullModeProducerMethodGetBufferName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic pullPacket(MediaPacket toRelease,[Function responseFactory = null]) {
      var params = new _MediaPullModeProducerPullPacketParams();
      params.toRelease = toRelease;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaPullModeProducerMethodPullPacketName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void releasePacket(MediaPacket toRelease) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaPullModeProducerReleasePacketParams();
      params.toRelease = toRelease;
      _proxyImpl.sendMessage(params, _mediaPullModeProducerMethodReleasePacketName);
    }
}


class MediaPullModeProducerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaPullModeProducer ptr;

  MediaPullModeProducerProxy(_MediaPullModeProducerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaPullModeProducerProxyCalls(proxyImpl);

  MediaPullModeProducerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaPullModeProducerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaPullModeProducerProxyCalls(impl);
  }

  MediaPullModeProducerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaPullModeProducerProxyImpl.fromHandle(handle) {
    ptr = new _MediaPullModeProducerProxyCalls(impl);
  }

  MediaPullModeProducerProxy.unbound() :
      impl = new _MediaPullModeProducerProxyImpl.unbound() {
    ptr = new _MediaPullModeProducerProxyCalls(impl);
  }

  factory MediaPullModeProducerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaPullModeProducerProxy p = new MediaPullModeProducerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaPullModeProducerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaPullModeProducerProxy"));
    return new MediaPullModeProducerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaPullModeProducer.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaPullModeProducerProxy($impl)";
  }
}


class MediaPullModeProducerStub extends bindings.Stub {
  MediaPullModeProducer _impl = null;

  MediaPullModeProducerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MediaPullModeProducerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MediaPullModeProducerStub.unbound() : super.unbound();

  static MediaPullModeProducerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaPullModeProducerStub"));
    return new MediaPullModeProducerStub.fromEndpoint(endpoint);
  }


  MediaPullModeProducerGetBufferResponseParams _mediaPullModeProducerGetBufferResponseParamsFactory(core.MojoSharedBuffer buffer) {
    var result = new MediaPullModeProducerGetBufferResponseParams();
    result.buffer = buffer;
    return result;
  }
  MediaPullModeProducerPullPacketResponseParams _mediaPullModeProducerPullPacketResponseParamsFactory(MediaPacket packet) {
    var result = new MediaPullModeProducerPullPacketResponseParams();
    result.packet = packet;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _mediaPullModeProducerMethodGetBufferName:
        var response = _impl.getBuffer(_mediaPullModeProducerGetBufferResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaPullModeProducerMethodGetBufferName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaPullModeProducerMethodGetBufferName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaPullModeProducerMethodPullPacketName:
        var params = _MediaPullModeProducerPullPacketParams.deserialize(
            message.payload);
        var response = _impl.pullPacket(params.toRelease,_mediaPullModeProducerPullPacketResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaPullModeProducerMethodPullPacketName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaPullModeProducerMethodPullPacketName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaPullModeProducerMethodReleasePacketName:
        var params = _MediaPullModeProducerReleasePacketParams.deserialize(
            message.payload);
        _impl.releasePacket(params.toRelease);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaPullModeProducer get impl => _impl;
  set impl(MediaPullModeProducer d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MediaPullModeProducerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaPullModeProducerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _mediaConsumerMethodSetBufferName = 0;
const int _mediaConsumerMethodSendPacketName = 1;
const int _mediaConsumerMethodPrimeName = 2;
const int _mediaConsumerMethodFlushName = 3;
  
class MediaConsumerSendResult extends bindings.MojoEnum {
  static const MediaConsumerSendResult consumed = const MediaConsumerSendResult._(0);
  static const MediaConsumerSendResult flushed = const MediaConsumerSendResult._(1);

  const MediaConsumerSendResult._(int v) : super(v);

  static const Map<String, MediaConsumerSendResult> valuesMap = const {
    "consumed": consumed,
    "flushed": flushed,
  };
  static const List<MediaConsumerSendResult> values = const [
    consumed,
    flushed,
  ];

  static MediaConsumerSendResult valueOf(String name) => valuesMap[name];

  factory MediaConsumerSendResult(int v) {
    switch (v) {
      case 0:
        return MediaConsumerSendResult.consumed;
      case 1:
        return MediaConsumerSendResult.flushed;
      default:
        return null;
    }
  }

  static MediaConsumerSendResult decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    MediaConsumerSendResult result = new MediaConsumerSendResult(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum MediaConsumerSendResult.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case consumed:
        return 'MediaConsumerSendResult.consumed';
      case flushed:
        return 'MediaConsumerSendResult.flushed';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class _MediaConsumerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaConsumer {
  static const String serviceName = null;
  dynamic setBuffer(core.MojoSharedBuffer buffer,int size,[Function responseFactory = null]);
  dynamic sendPacket(MediaPacket packet,[Function responseFactory = null]);
  dynamic prime([Function responseFactory = null]);
  dynamic flush([Function responseFactory = null]);
  static const int kMaxBufferLen = 4611686018427387903;
}


class _MediaConsumerProxyImpl extends bindings.Proxy {
  _MediaConsumerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaConsumerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaConsumerProxyImpl.unbound() : super.unbound();

  static _MediaConsumerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaConsumerProxyImpl"));
    return new _MediaConsumerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _MediaConsumerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaConsumerMethodSetBufferName:
        var r = MediaConsumerSetBufferResponseParams.deserialize(
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
      case _mediaConsumerMethodSendPacketName:
        var r = MediaConsumerSendPacketResponseParams.deserialize(
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
      case _mediaConsumerMethodPrimeName:
        var r = MediaConsumerPrimeResponseParams.deserialize(
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
      case _mediaConsumerMethodFlushName:
        var r = MediaConsumerFlushResponseParams.deserialize(
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
    return "_MediaConsumerProxyImpl($superString)";
  }
}


class _MediaConsumerProxyCalls implements MediaConsumer {
  _MediaConsumerProxyImpl _proxyImpl;

  _MediaConsumerProxyCalls(this._proxyImpl);
    dynamic setBuffer(core.MojoSharedBuffer buffer,int size,[Function responseFactory = null]) {
      var params = new _MediaConsumerSetBufferParams();
      params.buffer = buffer;
      params.size = size;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaConsumerMethodSetBufferName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic sendPacket(MediaPacket packet,[Function responseFactory = null]) {
      var params = new _MediaConsumerSendPacketParams();
      params.packet = packet;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaConsumerMethodSendPacketName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic prime([Function responseFactory = null]) {
      var params = new _MediaConsumerPrimeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaConsumerMethodPrimeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic flush([Function responseFactory = null]) {
      var params = new _MediaConsumerFlushParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _mediaConsumerMethodFlushName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class MediaConsumerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaConsumer ptr;

  MediaConsumerProxy(_MediaConsumerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaConsumerProxyCalls(proxyImpl);

  MediaConsumerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaConsumerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaConsumerProxyCalls(impl);
  }

  MediaConsumerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaConsumerProxyImpl.fromHandle(handle) {
    ptr = new _MediaConsumerProxyCalls(impl);
  }

  MediaConsumerProxy.unbound() :
      impl = new _MediaConsumerProxyImpl.unbound() {
    ptr = new _MediaConsumerProxyCalls(impl);
  }

  factory MediaConsumerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaConsumerProxy p = new MediaConsumerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaConsumerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaConsumerProxy"));
    return new MediaConsumerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaConsumer.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaConsumerProxy($impl)";
  }
}


class MediaConsumerStub extends bindings.Stub {
  MediaConsumer _impl = null;

  MediaConsumerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MediaConsumerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MediaConsumerStub.unbound() : super.unbound();

  static MediaConsumerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaConsumerStub"));
    return new MediaConsumerStub.fromEndpoint(endpoint);
  }


  MediaConsumerSetBufferResponseParams _mediaConsumerSetBufferResponseParamsFactory() {
    var result = new MediaConsumerSetBufferResponseParams();
    return result;
  }
  MediaConsumerSendPacketResponseParams _mediaConsumerSendPacketResponseParamsFactory(MediaConsumerSendResult result) {
    var result = new MediaConsumerSendPacketResponseParams();
    result.result = result;
    return result;
  }
  MediaConsumerPrimeResponseParams _mediaConsumerPrimeResponseParamsFactory() {
    var result = new MediaConsumerPrimeResponseParams();
    return result;
  }
  MediaConsumerFlushResponseParams _mediaConsumerFlushResponseParamsFactory() {
    var result = new MediaConsumerFlushResponseParams();
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _mediaConsumerMethodSetBufferName:
        var params = _MediaConsumerSetBufferParams.deserialize(
            message.payload);
        var response = _impl.setBuffer(params.buffer,params.size,_mediaConsumerSetBufferResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaConsumerMethodSetBufferName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaConsumerMethodSetBufferName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaConsumerMethodSendPacketName:
        var params = _MediaConsumerSendPacketParams.deserialize(
            message.payload);
        var response = _impl.sendPacket(params.packet,_mediaConsumerSendPacketResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaConsumerMethodSendPacketName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaConsumerMethodSendPacketName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaConsumerMethodPrimeName:
        var response = _impl.prime(_mediaConsumerPrimeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaConsumerMethodPrimeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaConsumerMethodPrimeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaConsumerMethodFlushName:
        var response = _impl.flush(_mediaConsumerFlushResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaConsumerMethodFlushName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaConsumerMethodFlushName,
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

  MediaConsumer get impl => _impl;
  set impl(MediaConsumer d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MediaConsumerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaConsumerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



