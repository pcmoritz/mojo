// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library test_included_unions_mojom;
import 'dart:collection';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;





enum IncludedUnionTag {
  a,
  unknown
}

class IncludedUnion extends bindings.Union {
  static final _tag_to_int = const {
    IncludedUnionTag.a: 0,
  };

  static final _int_to_tag = const {
    0: IncludedUnionTag.a,
  };

  var _data;
  IncludedUnionTag _tag = IncludedUnionTag.unknown;

  IncludedUnionTag get tag => _tag;
  int get a {
    if (_tag != IncludedUnionTag.a) {
      throw new bindings.UnsetUnionTagError(_tag, IncludedUnionTag.a);
    }
    return _data;
  }

  set a(int value) {
    _tag = IncludedUnionTag.a;
    _data = value;
  }

  static IncludedUnion decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    IncludedUnion result = new IncludedUnion();

    
    IncludedUnionTag tag = _int_to_tag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case IncludedUnionTag.a:
        
        result.a = decoder0.decodeInt8(offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tag_to_int[_tag], offset + 4);
    switch (_tag) {
      case IncludedUnionTag.a:
        encoder0.encodeInt8(a, offset + 8);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "IncludedUnion(";
    switch (_tag) {
      case IncludedUnionTag.a:
        result += "a";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
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
  var serializedRuntimeTypeInfo = new Uint8List.fromList(const [24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,40,0,0,0,32,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,73,110,99,108,117,100,101,100,85,110,105,111,110,24,0,0,0,1,0,0,0,16,0,0,0,2,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,0,0,0,13,0,0,0,73,110,99,108,117,100,101,100,85,110,105,111,110,0,0,0,31,0,0,0,23,0,0,0,109,111,106,111,46,116,101,115,116,46,73,110,99,108,117,100,101,100,85,110,105,111,110,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,7,0,0,0,6,0,0,0,97,0,0,0,89,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,116,101,115,116,95,105,110,99,108,117,100,101,100,95,117,110,105,111,110,115,46,109,111,106,111,109,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,1,0,0,0,97,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,8,0,0,0,7,0,0,0,97,0,0,0,89,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,116,101,115,116,95,105,110,99,108,117,100,101,100,95,117,110,105,111,110,115,46,109,111,106,111,109,0,0,0,0,0,0,0]);

  // Deserialize RuntimeTypeInfo
  var bdata = new ByteData.view(serializedRuntimeTypeInfo.buffer);
  var message = new bindings.Message(bdata, null, serializedRuntimeTypeInfo.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
