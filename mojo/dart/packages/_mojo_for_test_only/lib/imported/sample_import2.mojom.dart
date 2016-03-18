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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/8xXzW7TQBBeJ4QGQavQQlsqfsIBKVyyiFPFKSVERGqFIppDe6rSxMSLbG+wXSHxBDwmj8AbwDg7i5yxnQ3Q2hnp0zQ7a3vmm53Z6T5T0kD9CjVd17pONN33HXUTUE3Y9Xv7qJ8B9gDD80Hv4rh3/kZ4MxlE9qTdla4M2FOw7WbaT8U3e9nzQ0f4U3aI39d+tRJ+WoAf1cXfnY3seObGhN9J+QWi4zpMrMW6w7JlE1ADqChVjFsAEn7Kj3v4nAeA8Bm/CgPuyvHI5VMpp67NHenZXIx8V4oxj75wT36WPAzG6o/Z1aUL68KP7ODTaGyH/FL4E2Aq5JEdRiEPR97MtS+UH6/b8UMe8lFJ+HFmLeZT89q02FL5W/76Oe+5i3n92Hs3/30A2E7x19bmFI+bGE/RPJrO+6p8WtfMpz6Pb0+OusegHwMepPnU5hSfW2vKZ5P0p7r1f+cxr57jurwFUF2JsYfIKWlXKd7uAzbWoJ5byEuHxK3tNbaamPik0jKcx69iEjkZvG3j3VM0b0XxYxn4ievtNsCxxdSJ0vzslMRPUfWmz4e65TPuTzRQXnZLqrcW9gfNT6Oi9E+cP85q+fVXS/Co4xhYxdRf6IxmWX1rD3tXWeeLEX+aifwunINTFUD+PaE26PmvTu9fMrdSiTm4M59DusOjD+9Perj+EvA8/3ttun/VvPetm+0rOu9jnEtp3vdL7issw5+sedo0F/xrvndw9iTjEHsBeJL/vT87TXm+rvujYshzA2OPUxcJ6dM8P1rzPA8kvHppntWOoviuGvjW82GI8yHl+6Cke8nEN51rTf+P/w4AAP//kuiZJEgQAAA=";

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
