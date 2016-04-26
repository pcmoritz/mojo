// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_types_mojom;
import 'package:mojo/bindings.dart' as bindings;


class MediaTypeMedium extends bindings.MojoEnum {
  static const MediaTypeMedium audio = const MediaTypeMedium._(0);
  static const MediaTypeMedium video = const MediaTypeMedium._(1);
  static const MediaTypeMedium text = const MediaTypeMedium._(2);
  static const MediaTypeMedium subpicture = const MediaTypeMedium._(3);

  const MediaTypeMedium._(int v) : super(v);

  static const Map<String, MediaTypeMedium> valuesMap = const {
    "audio": audio,
    "video": video,
    "text": text,
    "subpicture": subpicture,
  };
  static const List<MediaTypeMedium> values = const [
    audio,
    video,
    text,
    subpicture,
  ];

  static MediaTypeMedium valueOf(String name) => valuesMap[name];

  factory MediaTypeMedium(int v) {
    switch (v) {
      case 0:
        return MediaTypeMedium.audio;
      case 1:
        return MediaTypeMedium.video;
      case 2:
        return MediaTypeMedium.text;
      case 3:
        return MediaTypeMedium.subpicture;
      default:
        return null;
    }
  }

  static MediaTypeMedium decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    MediaTypeMedium result = new MediaTypeMedium(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum MediaTypeMedium.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case audio:
        return 'MediaTypeMedium.audio';
      case video:
        return 'MediaTypeMedium.video';
      case text:
        return 'MediaTypeMedium.text';
      case subpicture:
        return 'MediaTypeMedium.subpicture';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class AudioSampleFormat extends bindings.MojoEnum {
  static const AudioSampleFormat any = const AudioSampleFormat._(0);
  static const AudioSampleFormat unsigned8 = const AudioSampleFormat._(1);
  static const AudioSampleFormat signed16 = const AudioSampleFormat._(2);
  static const AudioSampleFormat signed24In32 = const AudioSampleFormat._(3);
  static const AudioSampleFormat float = const AudioSampleFormat._(4);

  const AudioSampleFormat._(int v) : super(v);

  static const Map<String, AudioSampleFormat> valuesMap = const {
    "any": any,
    "unsigned8": unsigned8,
    "signed16": signed16,
    "signed24In32": signed24In32,
    "float": float,
  };
  static const List<AudioSampleFormat> values = const [
    any,
    unsigned8,
    signed16,
    signed24In32,
    float,
  ];

  static AudioSampleFormat valueOf(String name) => valuesMap[name];

  factory AudioSampleFormat(int v) {
    switch (v) {
      case 0:
        return AudioSampleFormat.any;
      case 1:
        return AudioSampleFormat.unsigned8;
      case 2:
        return AudioSampleFormat.signed16;
      case 3:
        return AudioSampleFormat.signed24In32;
      case 4:
        return AudioSampleFormat.float;
      default:
        return null;
    }
  }

  static AudioSampleFormat decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AudioSampleFormat result = new AudioSampleFormat(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AudioSampleFormat.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case any:
        return 'AudioSampleFormat.any';
      case unsigned8:
        return 'AudioSampleFormat.unsigned8';
      case signed16:
        return 'AudioSampleFormat.signed16';
      case signed24In32:
        return 'AudioSampleFormat.signed24In32';
      case float:
        return 'AudioSampleFormat.float';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class VideoProfile extends bindings.MojoEnum {
  static const VideoProfile unknown = const VideoProfile._(0);
  static const VideoProfile notApplicable = const VideoProfile._(1);
  static const VideoProfile h264Baseline = const VideoProfile._(2);
  static const VideoProfile h264Main = const VideoProfile._(3);
  static const VideoProfile h264Extended = const VideoProfile._(4);
  static const VideoProfile h264High = const VideoProfile._(5);
  static const VideoProfile h264High10 = const VideoProfile._(6);
  static const VideoProfile h264High422 = const VideoProfile._(7);
  static const VideoProfile h264High444Predictive = const VideoProfile._(8);
  static const VideoProfile h264ScalableBaseline = const VideoProfile._(9);
  static const VideoProfile h264ScalableHigh = const VideoProfile._(10);
  static const VideoProfile h264StereoHigh = const VideoProfile._(11);
  static const VideoProfile h264MultiviewHigh = const VideoProfile._(12);

  const VideoProfile._(int v) : super(v);

  static const Map<String, VideoProfile> valuesMap = const {
    "unknown": unknown,
    "notApplicable": notApplicable,
    "h264Baseline": h264Baseline,
    "h264Main": h264Main,
    "h264Extended": h264Extended,
    "h264High": h264High,
    "h264High10": h264High10,
    "h264High422": h264High422,
    "h264High444Predictive": h264High444Predictive,
    "h264ScalableBaseline": h264ScalableBaseline,
    "h264ScalableHigh": h264ScalableHigh,
    "h264StereoHigh": h264StereoHigh,
    "h264MultiviewHigh": h264MultiviewHigh,
  };
  static const List<VideoProfile> values = const [
    unknown,
    notApplicable,
    h264Baseline,
    h264Main,
    h264Extended,
    h264High,
    h264High10,
    h264High422,
    h264High444Predictive,
    h264ScalableBaseline,
    h264ScalableHigh,
    h264StereoHigh,
    h264MultiviewHigh,
  ];

  static VideoProfile valueOf(String name) => valuesMap[name];

  factory VideoProfile(int v) {
    switch (v) {
      case 0:
        return VideoProfile.unknown;
      case 1:
        return VideoProfile.notApplicable;
      case 2:
        return VideoProfile.h264Baseline;
      case 3:
        return VideoProfile.h264Main;
      case 4:
        return VideoProfile.h264Extended;
      case 5:
        return VideoProfile.h264High;
      case 6:
        return VideoProfile.h264High10;
      case 7:
        return VideoProfile.h264High422;
      case 8:
        return VideoProfile.h264High444Predictive;
      case 9:
        return VideoProfile.h264ScalableBaseline;
      case 10:
        return VideoProfile.h264ScalableHigh;
      case 11:
        return VideoProfile.h264StereoHigh;
      case 12:
        return VideoProfile.h264MultiviewHigh;
      default:
        return null;
    }
  }

  static VideoProfile decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    VideoProfile result = new VideoProfile(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum VideoProfile.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'VideoProfile.unknown';
      case notApplicable:
        return 'VideoProfile.notApplicable';
      case h264Baseline:
        return 'VideoProfile.h264Baseline';
      case h264Main:
        return 'VideoProfile.h264Main';
      case h264Extended:
        return 'VideoProfile.h264Extended';
      case h264High:
        return 'VideoProfile.h264High';
      case h264High10:
        return 'VideoProfile.h264High10';
      case h264High422:
        return 'VideoProfile.h264High422';
      case h264High444Predictive:
        return 'VideoProfile.h264High444Predictive';
      case h264ScalableBaseline:
        return 'VideoProfile.h264ScalableBaseline';
      case h264ScalableHigh:
        return 'VideoProfile.h264ScalableHigh';
      case h264StereoHigh:
        return 'VideoProfile.h264StereoHigh';
      case h264MultiviewHigh:
        return 'VideoProfile.h264MultiviewHigh';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class PixelFormat extends bindings.MojoEnum {
  static const PixelFormat unknown = const PixelFormat._(0);
  static const PixelFormat i420 = const PixelFormat._(1);
  static const PixelFormat yv12 = const PixelFormat._(2);
  static const PixelFormat yv16 = const PixelFormat._(3);
  static const PixelFormat yv12A = const PixelFormat._(4);
  static const PixelFormat yv24 = const PixelFormat._(5);
  static const PixelFormat nv12 = const PixelFormat._(6);
  static const PixelFormat nv21 = const PixelFormat._(7);
  static const PixelFormat uyvy = const PixelFormat._(8);
  static const PixelFormat yuy2 = const PixelFormat._(9);
  static const PixelFormat argb = const PixelFormat._(10);
  static const PixelFormat xrgb = const PixelFormat._(11);
  static const PixelFormat rgb24 = const PixelFormat._(12);
  static const PixelFormat rgb32 = const PixelFormat._(13);
  static const PixelFormat mjpeg = const PixelFormat._(14);
  static const PixelFormat mt21 = const PixelFormat._(15);

  const PixelFormat._(int v) : super(v);

  static const Map<String, PixelFormat> valuesMap = const {
    "unknown": unknown,
    "i420": i420,
    "yv12": yv12,
    "yv16": yv16,
    "yv12A": yv12A,
    "yv24": yv24,
    "nv12": nv12,
    "nv21": nv21,
    "uyvy": uyvy,
    "yuy2": yuy2,
    "argb": argb,
    "xrgb": xrgb,
    "rgb24": rgb24,
    "rgb32": rgb32,
    "mjpeg": mjpeg,
    "mt21": mt21,
  };
  static const List<PixelFormat> values = const [
    unknown,
    i420,
    yv12,
    yv16,
    yv12A,
    yv24,
    nv12,
    nv21,
    uyvy,
    yuy2,
    argb,
    xrgb,
    rgb24,
    rgb32,
    mjpeg,
    mt21,
  ];

  static PixelFormat valueOf(String name) => valuesMap[name];

  factory PixelFormat(int v) {
    switch (v) {
      case 0:
        return PixelFormat.unknown;
      case 1:
        return PixelFormat.i420;
      case 2:
        return PixelFormat.yv12;
      case 3:
        return PixelFormat.yv16;
      case 4:
        return PixelFormat.yv12A;
      case 5:
        return PixelFormat.yv24;
      case 6:
        return PixelFormat.nv12;
      case 7:
        return PixelFormat.nv21;
      case 8:
        return PixelFormat.uyvy;
      case 9:
        return PixelFormat.yuy2;
      case 10:
        return PixelFormat.argb;
      case 11:
        return PixelFormat.xrgb;
      case 12:
        return PixelFormat.rgb24;
      case 13:
        return PixelFormat.rgb32;
      case 14:
        return PixelFormat.mjpeg;
      case 15:
        return PixelFormat.mt21;
      default:
        return null;
    }
  }

  static PixelFormat decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    PixelFormat result = new PixelFormat(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum PixelFormat.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'PixelFormat.unknown';
      case i420:
        return 'PixelFormat.i420';
      case yv12:
        return 'PixelFormat.yv12';
      case yv16:
        return 'PixelFormat.yv16';
      case yv12A:
        return 'PixelFormat.yv12A';
      case yv24:
        return 'PixelFormat.yv24';
      case nv12:
        return 'PixelFormat.nv12';
      case nv21:
        return 'PixelFormat.nv21';
      case uyvy:
        return 'PixelFormat.uyvy';
      case yuy2:
        return 'PixelFormat.yuy2';
      case argb:
        return 'PixelFormat.argb';
      case xrgb:
        return 'PixelFormat.xrgb';
      case rgb24:
        return 'PixelFormat.rgb24';
      case rgb32:
        return 'PixelFormat.rgb32';
      case mjpeg:
        return 'PixelFormat.mjpeg';
      case mt21:
        return 'PixelFormat.mt21';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class ColorSpace extends bindings.MojoEnum {
  static const ColorSpace unknown = const ColorSpace._(0);
  static const ColorSpace notApplicable = const ColorSpace._(1);
  static const ColorSpace jpeg = const ColorSpace._(2);
  static const ColorSpace hdRec709 = const ColorSpace._(3);
  static const ColorSpace sdRec601 = const ColorSpace._(4);

  const ColorSpace._(int v) : super(v);

  static const Map<String, ColorSpace> valuesMap = const {
    "unknown": unknown,
    "notApplicable": notApplicable,
    "jpeg": jpeg,
    "hdRec709": hdRec709,
    "sdRec601": sdRec601,
  };
  static const List<ColorSpace> values = const [
    unknown,
    notApplicable,
    jpeg,
    hdRec709,
    sdRec601,
  ];

  static ColorSpace valueOf(String name) => valuesMap[name];

  factory ColorSpace(int v) {
    switch (v) {
      case 0:
        return ColorSpace.unknown;
      case 1:
        return ColorSpace.notApplicable;
      case 2:
        return ColorSpace.jpeg;
      case 3:
        return ColorSpace.hdRec709;
      case 4:
        return ColorSpace.sdRec601;
      default:
        return null;
    }
  }

  static ColorSpace decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ColorSpace result = new ColorSpace(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ColorSpace.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'ColorSpace.unknown';
      case notApplicable:
        return 'ColorSpace.notApplicable';
      case jpeg:
        return 'ColorSpace.jpeg';
      case hdRec709:
        return 'ColorSpace.hdRec709';
      case sdRec601:
        return 'ColorSpace.sdRec601';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class MediaType extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  static const String kAudioEncodingAac = "aac";
  static const String kAudioEncodingAmrNb = "amrnb";
  static const String kAudioEncodingAmrWb = "amrwb";
  static const String kAudioEncodingFlac = "flac";
  static const String kAudioEncodingGsmMs = "gsmms";
  static const String kAudioEncodingLpcm = "lpcm";
  static const String kAudioEncodingMp3 = "mp3";
  static const String kAudioEncodingPcmALaw = "pcmalaw";
  static const String kAudioEncodingPcmMuLaw = "pcmmulaw";
  static const String kAudioEncodingVorbis = "vorbis";
  static const String kVideoEncodingH263 = "h263";
  static const String kVideoEncodingH264 = "h264";
  static const String kVideoEncodingMpeg4 = "mpeg4";
  static const String kVideoEncodingTheora = "theora";
  static const String kVideoEncodingUncompressed = "uncompressed_video";
  static const String kVideoEncodingVp3 = "vp3";
  static const String kVideoEncodingVp8 = "vp8";
  MediaTypeMedium medium = null;
  MediaTypeDetails details = null;
  String encoding = null;
  List<int> encodingParameters = null;

  MediaType() : super(kVersions.last.size);

  static MediaType deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaType decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaType result = new MediaType();

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
      
        result.medium = MediaTypeMedium.decode(decoder0, 8);
        if (result.medium == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable MediaTypeMedium.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.details = MediaTypeDetails.decode(decoder0, 16);
        if (result.details == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable MediaTypeDetails.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.encoding = decoder0.decodeString(32, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.encodingParameters = decoder0.decodeUint8Array(40, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(medium, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "medium of struct MediaType: $e";
      rethrow;
    }
    try {
      encoder0.encodeUnion(details, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "details of struct MediaType: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(encoding, 32, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "encoding of struct MediaType: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(encodingParameters, 40, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "encodingParameters of struct MediaType: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaType("
           "medium: $medium" ", "
           "details: $details" ", "
           "encoding: $encoding" ", "
           "encodingParameters: $encodingParameters" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["medium"] = medium;
    map["details"] = details;
    map["encoding"] = encoding;
    map["encodingParameters"] = encodingParameters;
    return map;
  }
}


class MediaTypeSet extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  MediaTypeMedium medium = null;
  MediaTypeSetDetails details = null;
  List<String> encodings = null;

  MediaTypeSet() : super(kVersions.last.size);

  static MediaTypeSet deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaTypeSet decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaTypeSet result = new MediaTypeSet();

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
      
        result.medium = MediaTypeMedium.decode(decoder0, 8);
        if (result.medium == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable MediaTypeMedium.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.details = MediaTypeSetDetails.decode(decoder0, 16);
        if (result.details == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable MediaTypeSetDetails.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.encodings = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.encodings[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(medium, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "medium of struct MediaTypeSet: $e";
      rethrow;
    }
    try {
      encoder0.encodeUnion(details, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "details of struct MediaTypeSet: $e";
      rethrow;
    }
    try {
      if (encodings == null) {
        encoder0.encodeNullPointer(32, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(encodings.length, 32, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < encodings.length; ++i0) {
          encoder1.encodeString(encodings[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "encodings of struct MediaTypeSet: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaTypeSet("
           "medium: $medium" ", "
           "details: $details" ", "
           "encodings: $encodings" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["medium"] = medium;
    map["details"] = details;
    map["encodings"] = encodings;
    return map;
  }
}


class AudioMediaTypeDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  AudioSampleFormat sampleFormat = null;
  int channels = 0;
  int framesPerSecond = 0;

  AudioMediaTypeDetails() : super(kVersions.last.size);

  static AudioMediaTypeDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AudioMediaTypeDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AudioMediaTypeDetails result = new AudioMediaTypeDetails();

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
      
        result.sampleFormat = AudioSampleFormat.decode(decoder0, 8);
        if (result.sampleFormat == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable AudioSampleFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.channels = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.framesPerSecond = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(sampleFormat, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sampleFormat of struct AudioMediaTypeDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(channels, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "channels of struct AudioMediaTypeDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(framesPerSecond, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "framesPerSecond of struct AudioMediaTypeDetails: $e";
      rethrow;
    }
  }

  String toString() {
    return "AudioMediaTypeDetails("
           "sampleFormat: $sampleFormat" ", "
           "channels: $channels" ", "
           "framesPerSecond: $framesPerSecond" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sampleFormat"] = sampleFormat;
    map["channels"] = channels;
    map["framesPerSecond"] = framesPerSecond;
    return map;
  }
}


class AudioMediaTypeSetDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  AudioSampleFormat sampleFormat = null;
  int minChannels = 0;
  int maxChannels = 0;
  int minFramesPerSecond = 0;
  int maxFramesPerSecond = 0;

  AudioMediaTypeSetDetails() : super(kVersions.last.size);

  static AudioMediaTypeSetDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AudioMediaTypeSetDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AudioMediaTypeSetDetails result = new AudioMediaTypeSetDetails();

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
      
        result.sampleFormat = AudioSampleFormat.decode(decoder0, 8);
        if (result.sampleFormat == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable AudioSampleFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.minChannels = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxChannels = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.minFramesPerSecond = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxFramesPerSecond = decoder0.decodeUint32(24);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(sampleFormat, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sampleFormat of struct AudioMediaTypeSetDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(minChannels, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "minChannels of struct AudioMediaTypeSetDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(maxChannels, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "maxChannels of struct AudioMediaTypeSetDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(minFramesPerSecond, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "minFramesPerSecond of struct AudioMediaTypeSetDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(maxFramesPerSecond, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "maxFramesPerSecond of struct AudioMediaTypeSetDetails: $e";
      rethrow;
    }
  }

  String toString() {
    return "AudioMediaTypeSetDetails("
           "sampleFormat: $sampleFormat" ", "
           "minChannels: $minChannels" ", "
           "maxChannels: $maxChannels" ", "
           "minFramesPerSecond: $minFramesPerSecond" ", "
           "maxFramesPerSecond: $maxFramesPerSecond" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sampleFormat"] = sampleFormat;
    map["minChannels"] = minChannels;
    map["maxChannels"] = maxChannels;
    map["minFramesPerSecond"] = minFramesPerSecond;
    map["maxFramesPerSecond"] = maxFramesPerSecond;
    return map;
  }
}


class VideoMediaTypeDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  VideoProfile profile = null;
  PixelFormat pixelFormat = null;
  ColorSpace colorSpace = null;
  int width = 0;
  int height = 0;
  int codedWidth = 0;
  int codedHeight = 0;

  VideoMediaTypeDetails() : super(kVersions.last.size);

  static VideoMediaTypeDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static VideoMediaTypeDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    VideoMediaTypeDetails result = new VideoMediaTypeDetails();

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
      
        result.profile = VideoProfile.decode(decoder0, 8);
        if (result.profile == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable VideoProfile.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.pixelFormat = PixelFormat.decode(decoder0, 12);
        if (result.pixelFormat == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable PixelFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.colorSpace = ColorSpace.decode(decoder0, 16);
        if (result.colorSpace == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ColorSpace.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.width = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.codedWidth = decoder0.decodeUint32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.codedHeight = decoder0.decodeUint32(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(profile, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "profile of struct VideoMediaTypeDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(pixelFormat, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pixelFormat of struct VideoMediaTypeDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(colorSpace, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "colorSpace of struct VideoMediaTypeDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(width, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "width of struct VideoMediaTypeDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(height, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "height of struct VideoMediaTypeDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(codedWidth, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "codedWidth of struct VideoMediaTypeDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(codedHeight, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "codedHeight of struct VideoMediaTypeDetails: $e";
      rethrow;
    }
  }

  String toString() {
    return "VideoMediaTypeDetails("
           "profile: $profile" ", "
           "pixelFormat: $pixelFormat" ", "
           "colorSpace: $colorSpace" ", "
           "width: $width" ", "
           "height: $height" ", "
           "codedWidth: $codedWidth" ", "
           "codedHeight: $codedHeight" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["profile"] = profile;
    map["pixelFormat"] = pixelFormat;
    map["colorSpace"] = colorSpace;
    map["width"] = width;
    map["height"] = height;
    map["codedWidth"] = codedWidth;
    map["codedHeight"] = codedHeight;
    return map;
  }
}


class VideoMediaTypeSetDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int minWidth = 0;
  int maxWidth = 0;
  int minHeight = 0;
  int maxHeight = 0;

  VideoMediaTypeSetDetails() : super(kVersions.last.size);

  static VideoMediaTypeSetDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static VideoMediaTypeSetDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    VideoMediaTypeSetDetails result = new VideoMediaTypeSetDetails();

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
      
      result.minWidth = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxWidth = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.minHeight = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxHeight = decoder0.decodeUint32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(minWidth, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "minWidth of struct VideoMediaTypeSetDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(maxWidth, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "maxWidth of struct VideoMediaTypeSetDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(minHeight, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "minHeight of struct VideoMediaTypeSetDetails: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(maxHeight, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "maxHeight of struct VideoMediaTypeSetDetails: $e";
      rethrow;
    }
  }

  String toString() {
    return "VideoMediaTypeSetDetails("
           "minWidth: $minWidth" ", "
           "maxWidth: $maxWidth" ", "
           "minHeight: $minHeight" ", "
           "maxHeight: $maxHeight" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["minWidth"] = minWidth;
    map["maxWidth"] = maxWidth;
    map["minHeight"] = minHeight;
    map["maxHeight"] = maxHeight;
    return map;
  }
}


class TextMediaTypeDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  TextMediaTypeDetails() : super(kVersions.last.size);

  static TextMediaTypeDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TextMediaTypeDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TextMediaTypeDetails result = new TextMediaTypeDetails();

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
    return "TextMediaTypeDetails("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class TextMediaTypeSetDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  TextMediaTypeSetDetails() : super(kVersions.last.size);

  static TextMediaTypeSetDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TextMediaTypeSetDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TextMediaTypeSetDetails result = new TextMediaTypeSetDetails();

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
    return "TextMediaTypeSetDetails("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class SubpictureMediaTypeDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  SubpictureMediaTypeDetails() : super(kVersions.last.size);

  static SubpictureMediaTypeDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SubpictureMediaTypeDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SubpictureMediaTypeDetails result = new SubpictureMediaTypeDetails();

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
    return "SubpictureMediaTypeDetails("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class SubpictureMediaTypeSetDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  SubpictureMediaTypeSetDetails() : super(kVersions.last.size);

  static SubpictureMediaTypeSetDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SubpictureMediaTypeSetDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SubpictureMediaTypeSetDetails result = new SubpictureMediaTypeSetDetails();

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
    return "SubpictureMediaTypeSetDetails("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}



enum MediaTypeDetailsTag {
  audio,
  video,
  text,
  subpicture,
  unknown
}

class MediaTypeDetails extends bindings.Union {
  static final _tagToInt = const {
    MediaTypeDetailsTag.audio: 0,
    MediaTypeDetailsTag.video: 1,
    MediaTypeDetailsTag.text: 2,
    MediaTypeDetailsTag.subpicture: 3,
  };

  static final _intToTag = const {
    0: MediaTypeDetailsTag.audio,
    1: MediaTypeDetailsTag.video,
    2: MediaTypeDetailsTag.text,
    3: MediaTypeDetailsTag.subpicture,
  };

  var _data;
  MediaTypeDetailsTag _tag = MediaTypeDetailsTag.unknown;

  MediaTypeDetailsTag get tag => _tag;
  AudioMediaTypeDetails get audio {
    if (_tag != MediaTypeDetailsTag.audio) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeDetailsTag.audio);
    }
    return _data;
  }

  set audio(AudioMediaTypeDetails value) {
    _tag = MediaTypeDetailsTag.audio;
    _data = value;
  }
  VideoMediaTypeDetails get video {
    if (_tag != MediaTypeDetailsTag.video) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeDetailsTag.video);
    }
    return _data;
  }

  set video(VideoMediaTypeDetails value) {
    _tag = MediaTypeDetailsTag.video;
    _data = value;
  }
  TextMediaTypeDetails get text {
    if (_tag != MediaTypeDetailsTag.text) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeDetailsTag.text);
    }
    return _data;
  }

  set text(TextMediaTypeDetails value) {
    _tag = MediaTypeDetailsTag.text;
    _data = value;
  }
  SubpictureMediaTypeDetails get subpicture {
    if (_tag != MediaTypeDetailsTag.subpicture) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeDetailsTag.subpicture);
    }
    return _data;
  }

  set subpicture(SubpictureMediaTypeDetails value) {
    _tag = MediaTypeDetailsTag.subpicture;
    _data = value;
  }

  static MediaTypeDetails decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    MediaTypeDetails result = new MediaTypeDetails();

    
    MediaTypeDetailsTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case MediaTypeDetailsTag.audio:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.audio = AudioMediaTypeDetails.decode(decoder1);
        break;
      case MediaTypeDetailsTag.video:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.video = VideoMediaTypeDetails.decode(decoder1);
        break;
      case MediaTypeDetailsTag.text:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.text = TextMediaTypeDetails.decode(decoder1);
        break;
      case MediaTypeDetailsTag.subpicture:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.subpicture = SubpictureMediaTypeDetails.decode(decoder1);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case MediaTypeDetailsTag.audio:
        encoder0.encodeStruct(audio, offset + 8, false);
        break;
      case MediaTypeDetailsTag.video:
        encoder0.encodeStruct(video, offset + 8, false);
        break;
      case MediaTypeDetailsTag.text:
        encoder0.encodeStruct(text, offset + 8, false);
        break;
      case MediaTypeDetailsTag.subpicture:
        encoder0.encodeStruct(subpicture, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "MediaTypeDetails(";
    switch (_tag) {
      case MediaTypeDetailsTag.audio:
        result += "audio";
        break;
      case MediaTypeDetailsTag.video:
        result += "video";
        break;
      case MediaTypeDetailsTag.text:
        result += "text";
        break;
      case MediaTypeDetailsTag.subpicture:
        result += "subpicture";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum MediaTypeSetDetailsTag {
  audio,
  video,
  text,
  subpicture,
  unknown
}

class MediaTypeSetDetails extends bindings.Union {
  static final _tagToInt = const {
    MediaTypeSetDetailsTag.audio: 0,
    MediaTypeSetDetailsTag.video: 1,
    MediaTypeSetDetailsTag.text: 2,
    MediaTypeSetDetailsTag.subpicture: 3,
  };

  static final _intToTag = const {
    0: MediaTypeSetDetailsTag.audio,
    1: MediaTypeSetDetailsTag.video,
    2: MediaTypeSetDetailsTag.text,
    3: MediaTypeSetDetailsTag.subpicture,
  };

  var _data;
  MediaTypeSetDetailsTag _tag = MediaTypeSetDetailsTag.unknown;

  MediaTypeSetDetailsTag get tag => _tag;
  AudioMediaTypeSetDetails get audio {
    if (_tag != MediaTypeSetDetailsTag.audio) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeSetDetailsTag.audio);
    }
    return _data;
  }

  set audio(AudioMediaTypeSetDetails value) {
    _tag = MediaTypeSetDetailsTag.audio;
    _data = value;
  }
  VideoMediaTypeSetDetails get video {
    if (_tag != MediaTypeSetDetailsTag.video) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeSetDetailsTag.video);
    }
    return _data;
  }

  set video(VideoMediaTypeSetDetails value) {
    _tag = MediaTypeSetDetailsTag.video;
    _data = value;
  }
  TextMediaTypeSetDetails get text {
    if (_tag != MediaTypeSetDetailsTag.text) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeSetDetailsTag.text);
    }
    return _data;
  }

  set text(TextMediaTypeSetDetails value) {
    _tag = MediaTypeSetDetailsTag.text;
    _data = value;
  }
  SubpictureMediaTypeSetDetails get subpicture {
    if (_tag != MediaTypeSetDetailsTag.subpicture) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeSetDetailsTag.subpicture);
    }
    return _data;
  }

  set subpicture(SubpictureMediaTypeSetDetails value) {
    _tag = MediaTypeSetDetailsTag.subpicture;
    _data = value;
  }

  static MediaTypeSetDetails decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    MediaTypeSetDetails result = new MediaTypeSetDetails();

    
    MediaTypeSetDetailsTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case MediaTypeSetDetailsTag.audio:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.audio = AudioMediaTypeSetDetails.decode(decoder1);
        break;
      case MediaTypeSetDetailsTag.video:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.video = VideoMediaTypeSetDetails.decode(decoder1);
        break;
      case MediaTypeSetDetailsTag.text:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.text = TextMediaTypeSetDetails.decode(decoder1);
        break;
      case MediaTypeSetDetailsTag.subpicture:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.subpicture = SubpictureMediaTypeSetDetails.decode(decoder1);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case MediaTypeSetDetailsTag.audio:
        encoder0.encodeStruct(audio, offset + 8, false);
        break;
      case MediaTypeSetDetailsTag.video:
        encoder0.encodeStruct(video, offset + 8, false);
        break;
      case MediaTypeSetDetailsTag.text:
        encoder0.encodeStruct(text, offset + 8, false);
        break;
      case MediaTypeSetDetailsTag.subpicture:
        encoder0.encodeStruct(subpicture, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "MediaTypeSetDetails(";
    switch (_tag) {
      case MediaTypeSetDetailsTag.audio:
        result += "audio";
        break;
      case MediaTypeSetDetailsTag.video:
        result += "video";
        break;
      case MediaTypeSetDetailsTag.text:
        result += "text";
        break;
      case MediaTypeSetDetailsTag.subpicture:
        result += "subpicture";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


