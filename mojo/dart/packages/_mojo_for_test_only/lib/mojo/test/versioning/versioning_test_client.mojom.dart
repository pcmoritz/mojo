// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library versioning_test_client_mojom;
import 'dart:async';
import 'dart:collection';
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

const int _HumanResourceDatabase_addEmployeeName = 0;
const int _HumanResourceDatabase_queryEmployeeName = 1;
const int _HumanResourceDatabase_attachFingerPrintName = 2;
const int _HumanResourceDatabase_listEmployeeIdsName = 3;

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
      case _HumanResourceDatabase_addEmployeeName:
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
      case _HumanResourceDatabase_queryEmployeeName:
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
      case _HumanResourceDatabase_attachFingerPrintName:
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
      case _HumanResourceDatabase_listEmployeeIdsName:
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
          _HumanResourceDatabase_addEmployeeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic queryEmployee(int id,bool retrieveFingerPrint,[Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseQueryEmployeeParams();
      params.id = id;
      params.retrieveFingerPrint = retrieveFingerPrint;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HumanResourceDatabase_queryEmployeeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic attachFingerPrint(int id,List<int> fingerPrint,[Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseAttachFingerPrintParams();
      params.id = id;
      params.fingerPrint = fingerPrint;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HumanResourceDatabase_attachFingerPrintName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic listEmployeeIds([Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseListEmployeeIdsParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HumanResourceDatabase_listEmployeeIdsName,
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


  HumanResourceDatabaseAddEmployeeResponseParams _HumanResourceDatabaseAddEmployeeResponseParamsFactory(bool success) {
    var mojo_factory_result = new HumanResourceDatabaseAddEmployeeResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  HumanResourceDatabaseQueryEmployeeResponseParams _HumanResourceDatabaseQueryEmployeeResponseParamsFactory(Employee employee, List<int> fingerPrint) {
    var mojo_factory_result = new HumanResourceDatabaseQueryEmployeeResponseParams();
    mojo_factory_result.employee = employee;
    mojo_factory_result.fingerPrint = fingerPrint;
    return mojo_factory_result;
  }
  HumanResourceDatabaseAttachFingerPrintResponseParams _HumanResourceDatabaseAttachFingerPrintResponseParamsFactory(bool success) {
    var mojo_factory_result = new HumanResourceDatabaseAttachFingerPrintResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  HumanResourceDatabaseListEmployeeIdsResponseParams _HumanResourceDatabaseListEmployeeIdsResponseParamsFactory(List<int> ids) {
    var mojo_factory_result = new HumanResourceDatabaseListEmployeeIdsResponseParams();
    mojo_factory_result.ids = ids;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          1,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _HumanResourceDatabase_addEmployeeName:
        var params = _HumanResourceDatabaseAddEmployeeParams.deserialize(
            message.payload);
        var response = _impl.addEmployee(params.employee,_HumanResourceDatabaseAddEmployeeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HumanResourceDatabase_addEmployeeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HumanResourceDatabase_addEmployeeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _HumanResourceDatabase_queryEmployeeName:
        var params = _HumanResourceDatabaseQueryEmployeeParams.deserialize(
            message.payload);
        var response = _impl.queryEmployee(params.id,params.retrieveFingerPrint,_HumanResourceDatabaseQueryEmployeeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HumanResourceDatabase_queryEmployeeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HumanResourceDatabase_queryEmployeeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _HumanResourceDatabase_attachFingerPrintName:
        var params = _HumanResourceDatabaseAttachFingerPrintParams.deserialize(
            message.payload);
        var response = _impl.attachFingerPrint(params.id,params.fingerPrint,_HumanResourceDatabaseAttachFingerPrintResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HumanResourceDatabase_attachFingerPrintName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HumanResourceDatabase_attachFingerPrintName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _HumanResourceDatabase_listEmployeeIdsName:
        var response = _impl.listEmployeeIds(_HumanResourceDatabaseListEmployeeIdsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HumanResourceDatabase_listEmployeeIdsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HumanResourceDatabase_listEmployeeIdsName,
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
  // file.
  var serializedRuntimeTypeInfo = new Uint8List.fromList(const [24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,144,1,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,53,0,0,0,45,0,0,0,109,111,106,111,58,58,116,101,115,116,58,58,118,101,114,115,105,111,110,105,110,103,58,58,72,117,109,97,110,82,101,115,111,117,114,99,101,68,97,116,97,98,97,115,101,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,59,0,0,0,51,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,72,117,109,97,110,82,101,115,111,117,114,99,101,68,97,116,97,98,97,115,101,0,0,0,0,0,32,0,0,0,3,0,0,0,24,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,104,0,0,0,0,0,0,0,48,0,0,0,40,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,68,101,112,97,114,116,109,101,110,116,46,0,0,0,38,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,69,109,112,108,111,121,101,101,0,0,59,0,0,0,51,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,72,117,109,97,110,82,101,115,111,117,114,99,101,68,97,116,97,98,97,115,101,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,200,0,0,0,0,0,0,0,32,0,0,0,3,0,0,0,24,0,0,0,0,0,0,0,80,0,0,0,0,0,0,0,120,0,0,0,0,0,0,0,59,0,0,0,51,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,72,117,109,97,110,82,101,115,111,117,114,99,101,68,97,116,97,98,97,115,101,0,0,0,0,0,46,0,0,0,38,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,69,109,112,108,111,121,101,101,0,0,48,0,0,0,40,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,68,101,112,97,114,116,109,101,110,116,56,0,0,0,3,0,0,0,16,0,0,0,3,0,0,0,40,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,112,28,0,0,0,0,0,0,16,0,0,0,0,0,0,0,88,33,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,176,1,0,0,0,0,0,0,224,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,176,0,0,0,0,0,0,0,200,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,7,0,0,0,32,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,83,101,114,118,105,99,101,78,97,109,101,0,0,0,0,0,53,0,0,0,45,0,0,0,109,111,106,111,58,58,116,101,115,116,58,58,118,101,114,115,105,111,110,105,110,103,58,58,72,117,109,97,110,82,101,115,111,117,114,99,101,68,97,116,97,98,97,115,101,0,0,0,29,0,0,0,21,0,0,0,72,117,109,97,110,82,101,115,111,117,114,99,101,68,97,116,97,98,97,115,101,0,0,0,50,0,0,0,42,0,0,0,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,72,117,109,97,110,82,101,115,111,117,114,99,101,68,97,116,97,98,97,
115,101,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,23,0,0,0,10,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,53,0,0,0,45,0,0,0,109,111,106,111,58,58,116,101,115,116,58,58,118,101,114,115,105,111,110,105,110,103,58,58,72,117,109,97,110,82,101,115,111,117,114,99,101,68,97,116,97,98,97,115,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,4,0,0,0,0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0,40,0,0,0,4,0,0,0,32,0,0,0,0,0,0,0,208,5,0,0,0,0,0,0,120,14,0,0,0,0,0,0,104,21,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,120,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,65,100,100,69,109,112,108,111,121,101,101,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,2,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,27,0,0,0,19,0,0,0,65,100,100,69,109,112,108,111,121,101,101,45,114,101,113,117,101,115,116,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,101,109,112,108,111,121,101,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,23,0,0,0,99,0,0,0,91,0,0,0,
47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,69,109,112,108,111,121,101,101,46,0,0,0,38,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,69,109,112,108,111,121,101,101,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,28,0,0,0,20,0,0,0,65,100,100,69,109,112,108,111,121,101,101,45,114,101,115,112,111,110,115,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,115,117,99,99,101,115,115,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,42,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,136,4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,0,0,0,13,0,0,0,81,117,101,114,121,69,109,112,108,111,121,101,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,26,0,0,0,2,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,
106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,29,0,0,0,21,0,0,0,81,117,101,114,121,69,109,112,108,111,121,101,101,45,114,101,113,117,101,115,116,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,24,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,2,0,0,0,105,100,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,26,0,0,0,23,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,1,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,77,105,110,86,101,114,115,105,111,110,0,0,0,0,0,0,29,0,0,0,21,0,0,0,114,101,116,114,105,101,118,101,95,102,105,110,103,101,114,95,112,114,105,110,116,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,26,0,0,0,47,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,30,0,0,0,22,0,0,0,81,117,101,114,121,69,109,112,108,111,121,101,101,45,114,101,115,112,111,110,115,101,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,120,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,101,109,112,108,111,121,101,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,27,0,0,0,20,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,69,109,112,108,111,121,101,101,46,0,0,0,38,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,69,109,112,108,111,121,101,101,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,2,0,0,0,72,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,1,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,77,105,110,86,101,114,115,105,111,110,0,0,0,0,0,0,20,0,0,0,12,0,0,0,102,105,110,103,101,114,95,112,114,105,110,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,27,0,0,0,59,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,1,0,0,0,255,255,255,255,16,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,72,1,0,0,0,0,0,0,176,4,0,0,0,0,0,0,
2,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,1,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,77,105,110,86,101,114,115,105,111,110,0,0,0,0,0,0,25,0,0,0,17,0,0,0,65,116,116,97,99,104,70,105,110,103,101,114,80,114,105,110,116,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,30,0,0,0,2,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33,0,0,0,25,0,0,0,65,116,116,97,99,104,70,105,110,103,101,114,80,114,105,110,116,45,114,101,113,117,101,115,116,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,24,1,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,2,0,0,0,105,100,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,30,0,0,0,27,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,2,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,20,0,0,0,12,0,0,0,102,105,110,103,101,114,95,112,114,105,110,116,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,30,0,0,0,44,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,16,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,0,0,0,26,0,0,0,65,116,116,97,99,104,70,105,110,103,101,114,80,114,105,110,116,45,114,101,115,112,111,110,115,101,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,7,0,0,0,115,117,99,99,101,115,115,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,31,0,0,0,15,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,40,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,64,1,0,0,0,0,0,0,72,2,0,0,0,0,0,0,3,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,3,0,0,0,2,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,77,105,110,86,101,114,115,105,111,110,0,0,0,0,0,0,23,0,0,0,15,0,0,0,76,105,115,116,69,109,112,108,111,121,101,101,73,100,115,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,34,0,0,0,2,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,
100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,0,0,0,23,0,0,0,76,105,115,116,69,109,112,108,111,121,101,101,73,100,115,45,114,101,113,117,101,115,116,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,8,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,56,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,24,0,0,0,76,105,115,116,69,109,112,108,111,121,101,101,73,100,115,45,114,101,115,112,111,110,115,101,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,1,0,0,0,8,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,2,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,105,100,115,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,34,0,0,0,39,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,1,0,0,0,255,255,255,255,16,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,
48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,80,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,69,109,112,108,111,121,101,101,37,0,0,0,29,0,0,0,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,69,109,112,108,111,121,101,101,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,16,0,0,0,7,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,3,0,0,0,24,0,0,0,0,0,0,0,40,1,0,0,0,0,0,0,64,2,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,19,0,0,0,11,0,0,0,101,109,112,108,111,121,101,101,95,105,100,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,17,0,0,0,9,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,1,0,0,0,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,40,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,4,0,0,0,110,97,109,101,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,18,0,0,0,9,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,16,0,0,0,5,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,48,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,100,101,112,97,114,116,109,101,110,116,0,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,
19,0,0,0,13,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,68,101,112,97,114,116,109,101,110,116,0,0,0,0,0,0,48,0,0,0,40,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,68,101,112,97,114,116,109,101,110,116,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,16,1,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,88,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,10,0,0,0,68,101,112,97,114,116,109,101,110,116,0,0,0,0,0,0,39,0,0,0,31,0,0,0,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,68,101,112,97,114,116,109,101,110,116,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,11,0,0,0,5,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,24,0,0,0,2,0,0,0,16,0,0,0,0,0,0,0,112,1,0,0,0,0,0,0,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,40,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,88,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,13,0,0,0,5,0,0,0,83,65,76,69,83,0,0,0,45,0,0,0,37,0,0,0,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,68,101,112,97,114,116,109,101,110,116,46,83,65,76,69,83,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,12,0,0,0,2,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,48,0,0,0,40,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,68,101,112,97,114,116,109,101,110,116,48,0,0,0,0,0,0,0,40,0,0,0,0,0,0,0,40,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,48,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,88,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,11,0,0,0,3,0,0,0,68,69,86,0,0,0,0,0,43,0,0,0,35,0,0,0,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,68,101,112,97,114,116,109,101,110,116,46,68,69,86,0,0,0,0,0,24,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,13,0,0,0,2,0,0,0,99,0,0,0,91,0,0,0,47,104,111,109,101,47,114,117,100,111,109,105,110,101,114,47,109,111,106,111,47,115,114,99,47,109,111,106,111,47,112,117,98,108,105,99,47,105,110,116,101,114,102,97,99,101,115,47,98,105,110,100,105,110,103,115,47,116,101,115,116,115,47,118,101,114,115,105,111,110,105,110,103,95,116,101,115,116,95,99,108,105,101,110,116,46,109,111,106,111,109,0,0,0,0,0,48,0,0,0,40,0,0,0,84,89,80,69,95,75,69,89,58,109,111,106,111,46,116,101,115,116,46,118,101,114,115,105,111,110,105,110,103,46,68,101,112,97,114,116,109,101,110,116]);

  // Deserialize RuntimeTypeInfo
  var bdata = new ByteData.view(serializedRuntimeTypeInfo.buffer);
  var message = new bindings.Message(bdata, null, serializedRuntimeTypeInfo.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
