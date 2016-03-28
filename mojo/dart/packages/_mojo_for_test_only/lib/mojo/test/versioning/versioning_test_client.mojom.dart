// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library versioning_test_client_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class Department extends bindings.MojoEnum {
  static const Department sales = const Department._(0);
  static const Department dev = const Department._(1);

  const Department._(int v) : super(v);

  static const Map<String, Department> valuesMap = const {
    "sales": sales,
    "dev": dev,
  };
  static const List<Department> values = const [
    sales,
    dev,
  ];

  static Department valueOf(String name) => valuesMap[name];

  factory Department(int v) {
    switch (v) {
      case 0:
        return Department.sales;
      case 1:
        return Department.dev;
      default:
        return null;
    }
  }

  static Department decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Department result = new Department(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Department.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case sales:
        return 'Department.sales';
      case dev:
        return 'Department.dev';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Employee extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int employeeId = 0;
  String name = null;
  Department department = null;

  Employee() : super(kVersions.last.size);

  static Employee deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Employee decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Employee result = new Employee();

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
      
      result.employeeId = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.department = Department.decode(decoder0, 24);
        if (result.department == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Department.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(employeeId, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "employeeId of struct Employee: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(name, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct Employee: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(department, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "department of struct Employee: $e";
      rethrow;
    }
  }

  String toString() {
    return "Employee("
           "employeeId: $employeeId" ", "
           "name: $name" ", "
           "department: $department" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["employeeId"] = employeeId;
    map["name"] = name;
    map["department"] = department;
    return map;
  }
}


class _HumanResourceDatabaseAddEmployeeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Employee employee = null;

  _HumanResourceDatabaseAddEmployeeParams() : super(kVersions.last.size);

  static _HumanResourceDatabaseAddEmployeeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HumanResourceDatabaseAddEmployeeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HumanResourceDatabaseAddEmployeeParams result = new _HumanResourceDatabaseAddEmployeeParams();

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
      result.employee = Employee.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(employee, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "employee of struct _HumanResourceDatabaseAddEmployeeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HumanResourceDatabaseAddEmployeeParams("
           "employee: $employee" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["employee"] = employee;
    return map;
  }
}


class HumanResourceDatabaseAddEmployeeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  HumanResourceDatabaseAddEmployeeResponseParams() : super(kVersions.last.size);

  static HumanResourceDatabaseAddEmployeeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HumanResourceDatabaseAddEmployeeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HumanResourceDatabaseAddEmployeeResponseParams result = new HumanResourceDatabaseAddEmployeeResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(success, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "success of struct HumanResourceDatabaseAddEmployeeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HumanResourceDatabaseAddEmployeeResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _HumanResourceDatabaseQueryEmployeeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1)
  ];
  int id = 0;
  bool retrieveFingerPrint = false;

  _HumanResourceDatabaseQueryEmployeeParams() : super(kVersions.last.size);

  static _HumanResourceDatabaseQueryEmployeeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HumanResourceDatabaseQueryEmployeeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HumanResourceDatabaseQueryEmployeeParams result = new _HumanResourceDatabaseQueryEmployeeParams();

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
      
      result.id = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 1) {
      
      result.retrieveFingerPrint = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct _HumanResourceDatabaseQueryEmployeeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(retrieveFingerPrint, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "retrieveFingerPrint of struct _HumanResourceDatabaseQueryEmployeeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HumanResourceDatabaseQueryEmployeeParams("
           "id: $id" ", "
           "retrieveFingerPrint: $retrieveFingerPrint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["retrieveFingerPrint"] = retrieveFingerPrint;
    return map;
  }
}


class HumanResourceDatabaseQueryEmployeeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1)
  ];
  Employee employee = null;
  List<int> fingerPrint = null;

  HumanResourceDatabaseQueryEmployeeResponseParams() : super(kVersions.last.size);

  static HumanResourceDatabaseQueryEmployeeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HumanResourceDatabaseQueryEmployeeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HumanResourceDatabaseQueryEmployeeResponseParams result = new HumanResourceDatabaseQueryEmployeeResponseParams();

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
      result.employee = Employee.decode(decoder1);
    }
    if (mainDataHeader.version >= 1) {
      
      result.fingerPrint = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(employee, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "employee of struct HumanResourceDatabaseQueryEmployeeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(fingerPrint, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fingerPrint of struct HumanResourceDatabaseQueryEmployeeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HumanResourceDatabaseQueryEmployeeResponseParams("
           "employee: $employee" ", "
           "fingerPrint: $fingerPrint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["employee"] = employee;
    map["fingerPrint"] = fingerPrint;
    return map;
  }
}


class _HumanResourceDatabaseAttachFingerPrintParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int id = 0;
  List<int> fingerPrint = null;

  _HumanResourceDatabaseAttachFingerPrintParams() : super(kVersions.last.size);

  static _HumanResourceDatabaseAttachFingerPrintParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HumanResourceDatabaseAttachFingerPrintParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HumanResourceDatabaseAttachFingerPrintParams result = new _HumanResourceDatabaseAttachFingerPrintParams();

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
      
      result.id = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.fingerPrint = decoder0.decodeUint8Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct _HumanResourceDatabaseAttachFingerPrintParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(fingerPrint, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fingerPrint of struct _HumanResourceDatabaseAttachFingerPrintParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HumanResourceDatabaseAttachFingerPrintParams("
           "id: $id" ", "
           "fingerPrint: $fingerPrint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["fingerPrint"] = fingerPrint;
    return map;
  }
}


class HumanResourceDatabaseAttachFingerPrintResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  HumanResourceDatabaseAttachFingerPrintResponseParams() : super(kVersions.last.size);

  static HumanResourceDatabaseAttachFingerPrintResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HumanResourceDatabaseAttachFingerPrintResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HumanResourceDatabaseAttachFingerPrintResponseParams result = new HumanResourceDatabaseAttachFingerPrintResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(success, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "success of struct HumanResourceDatabaseAttachFingerPrintResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HumanResourceDatabaseAttachFingerPrintResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _HumanResourceDatabaseListEmployeeIdsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _HumanResourceDatabaseListEmployeeIdsParams() : super(kVersions.last.size);

  static _HumanResourceDatabaseListEmployeeIdsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HumanResourceDatabaseListEmployeeIdsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HumanResourceDatabaseListEmployeeIdsParams result = new _HumanResourceDatabaseListEmployeeIdsParams();

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
    return "_HumanResourceDatabaseListEmployeeIdsParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class HumanResourceDatabaseListEmployeeIdsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> ids = null;

  HumanResourceDatabaseListEmployeeIdsResponseParams() : super(kVersions.last.size);

  static HumanResourceDatabaseListEmployeeIdsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HumanResourceDatabaseListEmployeeIdsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HumanResourceDatabaseListEmployeeIdsResponseParams result = new HumanResourceDatabaseListEmployeeIdsResponseParams();

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
      
      result.ids = decoder0.decodeUint64Array(8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64Array(ids, 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ids of struct HumanResourceDatabaseListEmployeeIdsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HumanResourceDatabaseListEmployeeIdsResponseParams("
           "ids: $ids" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["ids"] = ids;
    return map;
  }
}

const int _humanResourceDatabaseMethodAddEmployeeName = 0;
const int _humanResourceDatabaseMethodQueryEmployeeName = 1;
const int _humanResourceDatabaseMethodAttachFingerPrintName = 2;
const int _humanResourceDatabaseMethodListEmployeeIdsName = 3;

class _HumanResourceDatabaseServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().servicesByName["mojo::test::versioning::HumanResourceDatabase"].topLevelInterface;
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class HumanResourceDatabase {
  static const String serviceName = "mojo::test::versioning::HumanResourceDatabase";
  dynamic addEmployee(Employee employee,[Function responseFactory = null]);
  dynamic queryEmployee(int id,bool retrieveFingerPrint,[Function responseFactory = null]);
  dynamic attachFingerPrint(int id,List<int> fingerPrint,[Function responseFactory = null]);
  dynamic listEmployeeIds([Function responseFactory = null]);
}


class _HumanResourceDatabaseProxyImpl extends bindings.Proxy {
  _HumanResourceDatabaseProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HumanResourceDatabaseProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HumanResourceDatabaseProxyImpl.unbound() : super.unbound();

  static _HumanResourceDatabaseProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HumanResourceDatabaseProxyImpl"));
    return new _HumanResourceDatabaseProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _HumanResourceDatabaseServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _humanResourceDatabaseMethodAddEmployeeName:
        var r = HumanResourceDatabaseAddEmployeeResponseParams.deserialize(
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
      case _humanResourceDatabaseMethodQueryEmployeeName:
        var r = HumanResourceDatabaseQueryEmployeeResponseParams.deserialize(
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
      case _humanResourceDatabaseMethodAttachFingerPrintName:
        var r = HumanResourceDatabaseAttachFingerPrintResponseParams.deserialize(
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
      case _humanResourceDatabaseMethodListEmployeeIdsName:
        var r = HumanResourceDatabaseListEmployeeIdsResponseParams.deserialize(
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
    return "_HumanResourceDatabaseProxyImpl($superString)";
  }
}


class _HumanResourceDatabaseProxyCalls implements HumanResourceDatabase {
  _HumanResourceDatabaseProxyImpl _proxyImpl;

  _HumanResourceDatabaseProxyCalls(this._proxyImpl);
    dynamic addEmployee(Employee employee,[Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseAddEmployeeParams();
      params.employee = employee;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _humanResourceDatabaseMethodAddEmployeeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic queryEmployee(int id,bool retrieveFingerPrint,[Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseQueryEmployeeParams();
      params.id = id;
      params.retrieveFingerPrint = retrieveFingerPrint;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _humanResourceDatabaseMethodQueryEmployeeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic attachFingerPrint(int id,List<int> fingerPrint,[Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseAttachFingerPrintParams();
      params.id = id;
      params.fingerPrint = fingerPrint;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _humanResourceDatabaseMethodAttachFingerPrintName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic listEmployeeIds([Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseListEmployeeIdsParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _humanResourceDatabaseMethodListEmployeeIdsName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HumanResourceDatabaseProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HumanResourceDatabase ptr;

  HumanResourceDatabaseProxy(_HumanResourceDatabaseProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HumanResourceDatabaseProxyCalls(proxyImpl);

  HumanResourceDatabaseProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HumanResourceDatabaseProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HumanResourceDatabaseProxyCalls(impl);
  }

  HumanResourceDatabaseProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HumanResourceDatabaseProxyImpl.fromHandle(handle) {
    ptr = new _HumanResourceDatabaseProxyCalls(impl);
  }

  HumanResourceDatabaseProxy.unbound() :
      impl = new _HumanResourceDatabaseProxyImpl.unbound() {
    ptr = new _HumanResourceDatabaseProxyCalls(impl);
  }

  factory HumanResourceDatabaseProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HumanResourceDatabaseProxy p = new HumanResourceDatabaseProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HumanResourceDatabaseProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HumanResourceDatabaseProxy"));
    return new HumanResourceDatabaseProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HumanResourceDatabase.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HumanResourceDatabaseProxy($impl)";
  }
}


class HumanResourceDatabaseStub extends bindings.Stub {
  HumanResourceDatabase _impl = null;

  HumanResourceDatabaseStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HumanResourceDatabaseStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HumanResourceDatabaseStub.unbound() : super.unbound();

  static HumanResourceDatabaseStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HumanResourceDatabaseStub"));
    return new HumanResourceDatabaseStub.fromEndpoint(endpoint);
  }


  HumanResourceDatabaseAddEmployeeResponseParams _humanResourceDatabaseAddEmployeeResponseParamsFactory(bool success) {
    var result = new HumanResourceDatabaseAddEmployeeResponseParams();
    result.success = success;
    return result;
  }
  HumanResourceDatabaseQueryEmployeeResponseParams _humanResourceDatabaseQueryEmployeeResponseParamsFactory(Employee employee, List<int> fingerPrint) {
    var result = new HumanResourceDatabaseQueryEmployeeResponseParams();
    result.employee = employee;
    result.fingerPrint = fingerPrint;
    return result;
  }
  HumanResourceDatabaseAttachFingerPrintResponseParams _humanResourceDatabaseAttachFingerPrintResponseParamsFactory(bool success) {
    var result = new HumanResourceDatabaseAttachFingerPrintResponseParams();
    result.success = success;
    return result;
  }
  HumanResourceDatabaseListEmployeeIdsResponseParams _humanResourceDatabaseListEmployeeIdsResponseParamsFactory(List<int> ids) {
    var result = new HumanResourceDatabaseListEmployeeIdsResponseParams();
    result.ids = ids;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          1,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _humanResourceDatabaseMethodAddEmployeeName:
        var params = _HumanResourceDatabaseAddEmployeeParams.deserialize(
            message.payload);
        var response = _impl.addEmployee(params.employee,_humanResourceDatabaseAddEmployeeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _humanResourceDatabaseMethodAddEmployeeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _humanResourceDatabaseMethodAddEmployeeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _humanResourceDatabaseMethodQueryEmployeeName:
        var params = _HumanResourceDatabaseQueryEmployeeParams.deserialize(
            message.payload);
        var response = _impl.queryEmployee(params.id,params.retrieveFingerPrint,_humanResourceDatabaseQueryEmployeeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _humanResourceDatabaseMethodQueryEmployeeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _humanResourceDatabaseMethodQueryEmployeeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _humanResourceDatabaseMethodAttachFingerPrintName:
        var params = _HumanResourceDatabaseAttachFingerPrintParams.deserialize(
            message.payload);
        var response = _impl.attachFingerPrint(params.id,params.fingerPrint,_humanResourceDatabaseAttachFingerPrintResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _humanResourceDatabaseMethodAttachFingerPrintName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _humanResourceDatabaseMethodAttachFingerPrintName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _humanResourceDatabaseMethodListEmployeeIdsName:
        var response = _impl.listEmployeeIds(_humanResourceDatabaseListEmployeeIdsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _humanResourceDatabaseMethodListEmployeeIdsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _humanResourceDatabaseMethodListEmployeeIdsName,
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

  HumanResourceDatabase get impl => _impl;
  set impl(HumanResourceDatabase d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HumanResourceDatabaseStub($superString)";
  }

  int get version => 1;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HumanResourceDatabaseServiceDescription();
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
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xaz4/bRBS2nVYbUgqh7RJDYesFAVGhcQVCitLLrtigIgoKLCrtKfU6U9Zo4wTbWW058adw7JEjR478CTly7DHHvcFM8oZMxjP+kTh2Ku1IT7N2HM+8b9775nuz0ZVZq0I/hp6/32GuVWxluP4c2x1s/cHPg1YrQH7Qap0iz3cGruP+1GrdH/Ut93vkD0aejQ6swDqyfCR4Dz/efejvYfsM2w+PO+3u1+3HLTJQg4zTmA/TkI0if//f0BvYSszne9AfQ38XWz12/AM0tLygj9yggZ/9MPb5dn94MniG0Or+NWH+1K86t06T0vya/Dkui/GYPsz4rzD+s/f/hfZIEbdr2CrY5ojM7n+E7RbESQR8oXldwXYZWxfbj9jM40EfmdavluuY5F2m79mzP4ajoxPHNh03QN5Ty0a+eeS4Pfx63yTj+eZ8wC650bVPHLJg5Mv96bgaM+4TddF/iquuKpFNhl8zIX5Xwd/D/QftQ8itD+Jxa9DnefxeBb/WjV/aPEmKq5oRrlcg/g/aD6fXH2N7PwGu9Hke16sbiqvB8R0F8M9L6XDsSHCsAqdSBiOx+a4MxznNhfAj/VYO+PH8btC81hbxaHLzqyjJmgxPhcFTdJ+26xCbCKDqOj1hvL2B7ZUc8BLhMd1HJPMvL4GHyuQ93whfkVB1rT4S4XAtJxyqEr9YXAhPn0fkSVpctIg4oftqj9tXeXyuAzflkVcif40YHZCWz2Q6UYG8Nrh9hF4/hzwfq9Hr+AenByn/TSLWlZ2PIdCXW8x9mt+HyDt1bPQthPXSuplw7TbRx5LPP8V2W8bHchkZiqMarN+642hZHHRJ3OnAH3Tr0yBO6nCfPvfPZVj312b9X9viOHoB/VkpfT6TFsf7+70es0uG/dJz0hl8HFO/H2np/G1K/L0JPjP+3vHQLyM8EXE9Ai0PnmfzWcbzk4z1QD1GX1E9IIqHWoH8rkt0YNq6N4rXVUles3F5rmYTl+9guxGKS384cH206XGZpq0al6/DvuaPbOyKL+Sp2wXgIosbGY//filZXZmUx7dBb303Qt6ziHrn7YJ5/Ekpm3yh+mPBX4bJi8oX/vymquZb38nypgLzgrJOGBe1guq6qFaWnL/Q759J6rrfVtDNJWY8Wj9847gPZ34txp+HAs9Bp6j7FPuLvO7Qc9xAgq9ZQPwZMfykcxpVj9nvxhnl7w62NwX5S3e8Tcnfofpy6LGboB/y4nV1TXpMhDNZjz01W344WzM/3IAzJI4WFNG63ct53QgGdPwtrr5blTd4vdMEoJ6D3tFSrBNp6+bxt+BMcz8ILPv4y+lqdehiCdZrpyD9RHmmmZJ/9yT47YLvIb8XquELHZVWR+1ATheho7SIc+Blz8dl9UZSfiN4fJLzOYGI36LqtSjdM2EfyiDv3gMtKMq7ebV/Ue8nrfdJfH2xwfX+XeCtjjb/X0Ga/W9VnaLF7H81wPiB4wdUhX3VC+O8W/C5wQslm7rjFvjM+fv/rldU3pUT8JQSsd4UHz2jc3ID3h3GacZSm8xPWo51Gf09h4NzRsTbu/Cbo6L0fSVBXLH89V8AAAD//zeVL6uIJwAA";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
