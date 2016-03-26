// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_import2_mojom;
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;

import 'package:_mojo_for_test_only/imported/sample_import.mojom.dart' as sample_import_mojom;

class Color extends bindings.MojoEnum {
  static const Color red = const Color._(0);
  static const Color black = const Color._(1);

  const Color._(int v) : super(v);

  static const Map<String, Color> valuesMap = const {
    "red": red,
    "black": black,
  };
  static const List<Color> values = const [
    red,
    black,
  ];

  static Color valueOf(String name) => valuesMap[name];

  factory Color(int v) {
    switch (v) {
      case 0:
        return Color.red;
      case 1:
        return Color.black;
      default:
        return null;
    }
  }

  static Color decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Color result = new Color(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Color.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case red:
        return 'Color.red';
      case black:
        return 'Color.black';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Size extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int width = 0;
  int height = 0;

  Size() : super(kVersions.last.size);

  static Size deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Size decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Size result = new Size();

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
      
      result.width = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(width, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "width of struct Size: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(height, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "height of struct Size: $e";
      rethrow;
    }
  }

  String toString() {
    return "Size("
           "width: $width" ", "
           "height: $height" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["width"] = width;
    map["height"] = height;
    return map;
  }
}


class Thing extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  sample_import_mojom.Shape shape = new sample_import_mojom.Shape(1);
  Color color = new Color(1);
  sample_import_mojom.Point location = null;
  Size size = null;

  Thing() : super(kVersions.last.size);

  static Thing deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Thing decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Thing result = new Thing();

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
      
        result.shape = sample_import_mojom.Shape.decode(decoder0, 8);
        if (result.shape == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable sample_import_mojom.Shape.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.color = Color.decode(decoder0, 12);
        if (result.color == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Color.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.location = sample_import_mojom.Point.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.size = Size.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(shape, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "shape of struct Thing: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(color, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "color of struct Thing: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(location, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "location of struct Thing: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(size, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct Thing: $e";
      rethrow;
    }
  }

  String toString() {
    return "Thing("
           "shape: $shape" ", "
           "color: $color" ", "
           "location: $location" ", "
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["shape"] = shape;
    map["color"] = color;
    map["location"] = location;
    map["size"] = size;
    return map;
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
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/8yXzW7TQBCA101DgoASaKGh/IUDkrnEiFPEKSVERGqFKpJLxaFKHVMvir2R7QqJJ+AReAwehUfhyA3G8Wzkjr3ZJGrcjjTa2Lve3flmdmZTZ4nUsH2NLX0v2ypp6bgf2DZAS6l+OW8P2+egu6CD46PuyUH3+C33JiKInFGzI8YiYM+g72Fuf59/d+Z9P3C5f8ZauL7cl5napwH6q3TxuVrJt+cP2Xda/oFIu1qpd3HbZvlyB7QMmliZ2LgFSszP7EN+9xm0D2q5wnOs4HwkPO47geWJr8IKAzv5MTk/HXPb4n7kBF+GthNap9wfAZfQipwwCq1w6E3Gzkmy6ptm/JE3s38jtW7PuOi/GUeDzZVlefUU89xCP37qvp8+74Hez/Bqyu4Mty20Z93cdPG8KD/jkvnJuHl3uN85gPYJ6E6Wn+zO8Lt7Tfg1SL75K3mWLvd83gbdjG2dZhnGHiBDkn4ynOKYrFzB+axjwLSJnbK/zBYTHT8qpibevvFR5OZw2sbasW5Oy/LYXJGHoeER558boK7Dz9woy2OnIB6zOkfOESPxpDpnPyvrqYNJtc6pg9hBee0WdM5MjIlGGhLIb8w3Zll97sopbnLfbaOYcxe6w0lefoqf7xXArUH2ReMq4+d+smF1/k8G0Pg1ybwqXrHNN6f3h85g/+OHwy6+fwX6Qr1ek45f1M8tY735RPrZxvsj9fOjgvKJys91xT1XV99X9e823hHJNYa9BH2qXm82UudXKtUV/bqh8WsN5x4Lexhx4VO/7l0zvx4JmHyuX5MRy/Ktrci3pOEr73Uh3uso38cF1RUdX3r/1P0PnlfX0/XrfwAAAP//FZeVoOgPAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  sample_import_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
          _runtimeTypeInfo.typeMap[s] = udt;
      });

  return _runtimeTypeInfo;
}
