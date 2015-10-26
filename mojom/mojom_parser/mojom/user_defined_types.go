// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"errors"
	"fmt"
	"math"
	"strings"
)

/*
This file contains data structures and functions used to describe user-defined,
types (i.e. structs, unions, enums and interfaces) and user-defined values
(i.e. declared constants and enum values.) See the comments at the top of
types.go for a discussion of types vs type references and values vs
value references.
*/

// User-Defined Type Kinds
type UserDefinedTypeKind int

const (
	UserDefinedTypeKindStruct UserDefinedTypeKind = iota
	UserDefinedTypeKindInterface
	UserDefinedTypeKindEnum
	UserDefinedTypeKindUnion
)

func (k UserDefinedTypeKind) String() string {
	switch k {
	case UserDefinedTypeKindStruct:
		return "struct"
	case UserDefinedTypeKindInterface:
		return "interface"
	case UserDefinedTypeKindEnum:
		return "enum"
	case UserDefinedTypeKindUnion:
		return "union"
	default:
		panic(fmt.Sprintf("Unknown UserDefinedTypeKind: %d", k))
	}
}

/////////////////////////////////////////////////////////////
// The UserDefinedType interface. This is implemented by
// MojomStruct, MojomInterface, MojomEnum and MojomUnion
/////////////////////////////////////////////////////////////
type UserDefinedType interface {
	SimpleName() string
	FullyQualifiedName() string
	Kind() UserDefinedTypeKind
	TypeKey() string
	Scope() *Scope
	IsAssignmentCompatibleWith(value LiteralValue) bool
	RegisterInScope(scope *Scope) *DuplicateNameError
}

// This struct is embedded in each of MojomStruct, MojomInterface
// MojomEnum and MojomUnion
type UserDefinedTypeBase struct {
	attributes         *Attributes
	thisType           UserDefinedType
	simpleName         string
	fullyQualifiedName string
	typeKey            string
	scope              *Scope
}

// This method is invoked from the constructors for the containing types:
// NewMojomInterface, NewMojomStruct, NewMojomEnum, NewMojomUnion
func (b *UserDefinedTypeBase) Init(simpleName string, thisType UserDefinedType,
	attributes *Attributes) {
	b.thisType = thisType
	b.simpleName = simpleName
	b.attributes = attributes
}

func (b *UserDefinedTypeBase) TypeKind() TypeKind {
	return TypeKindUserDefined
}

// Generates the fully-qualified name and the type key and registers the
// type in the given |scope| and also with the associated MojomDescriptor.
//
// This method is invoked when a UserDefinedType is added to its container,
// which may be either a file or a different UserDefinedType.
func (b *UserDefinedTypeBase) RegisterInScope(scope *Scope) *DuplicateNameError {
	// Register in the given scope with the given namePrefix.
	if err := scope.RegisterType(b.thisType); err != nil {
		return err
	}
	b.scope = scope

	b.fullyQualifiedName = buildDottedName(scope.fullyQualifiedName, b.simpleName)
	b.typeKey = computeTypeKey(b.fullyQualifiedName)
	scope.descriptor.TypesByKey[b.typeKey] = b.thisType
	return nil
}

func (b UserDefinedTypeBase) String() string {
	attributeString := ""
	if b.attributes != nil {
		attributeString = fmt.Sprintf("%s", b.attributes.List)
	}
	return fmt.Sprintf("(%s)%s%s", b.typeKey, attributeString, b.simpleName)
}

func (b *UserDefinedTypeBase) TypeKey() string {
	return b.typeKey
}

func (b UserDefinedTypeBase) SimpleName() string {
	return b.simpleName
}

func (b UserDefinedTypeBase) FullyQualifiedName() string {
	return b.fullyQualifiedName
}

func (b UserDefinedTypeBase) Scope() *Scope {
	return b.scope
}

// Some user-defined types, namely interfaces and structs, may act as
// namespaced scopes for declarations of constants and enums.
type DeclarationContainer struct {
	containedScope *Scope
	Enums          []*MojomEnum
	Constants      []*UserDefinedConstant
}

// Adds an enum to this type, which must be an interface or struct.
func (c *DeclarationContainer) AddEnum(mojomEnum *MojomEnum) *DuplicateNameError {
	c.Enums = append(c.Enums, mojomEnum)
	return mojomEnum.RegisterInScope(c.containedScope)
}

// Adds a declared constant to this type, which must be an interface or struct.
func (c *DeclarationContainer) AddConstant(declaredConst *UserDefinedConstant) *DuplicateNameError {
	c.Constants = append(c.Constants, declaredConst)
	return declaredConst.RegisterInScope(c.containedScope)
}

/////////////////////////////////////////////////////////////
// Structs
/////////////////////////////////////////////////////////////
type MojomStruct struct {
	UserDefinedTypeBase
	DeclarationContainer

	fields []*StructField
}

func NewMojomStruct(simpleName string, attributes *Attributes) *MojomStruct {
	mojomStruct := new(MojomStruct)
	mojomStruct.fields = make([]*StructField, 0)
	mojomStruct.Init(simpleName, mojomStruct, attributes)
	return mojomStruct
}

func (s *MojomStruct) InitAsScope(parentScope *Scope) *Scope {
	s.containedScope = NewLexicalScope(ScopeStruct, parentScope, s.simpleName, parentScope.file)
	return s.containedScope
}

func (s *MojomStruct) AddField(field *StructField) {
	if field == nil {
		return
	}
	s.fields = append(s.fields, field)
}

func (MojomStruct) Kind() UserDefinedTypeKind {
	return UserDefinedTypeKindStruct
}

func (MojomStruct) IsAssignmentCompatibleWith(value LiteralValue) bool {
	return value.IsDefault()
}

// This should be invoked some time after all of the fields have been added
// to the struct.
func (s *MojomStruct) ComputeFieldOrdinals() {
	// TODO(rudominer) Implement MojomStruct.ComputeFieldOrdinals()
	// Also check that field names are unique.
}

func (m MojomStruct) String() string {
	s := fmt.Sprintf("\n---------struct--------------\n")
	s += fmt.Sprintf("%s\n", m.UserDefinedTypeBase)
	s += "     Fields\n"
	s += "     ------\n"
	for _, field := range m.fields {
		s += fmt.Sprintf("     %s\n", field)
	}
	s += "     Enums\n"
	s += "     ------\n"
	for _, enum := range m.Enums {
		s += fmt.Sprintf(enum.toString(5))
	}
	s += "     Constants\n"
	s += "     --------"
	for _, constant := range m.Constants {
		s += fmt.Sprintf(constant.toString(5))
	}
	return s
}

// A debug string representing this struct in the case that this struct
// is being used to represent the parameters to a method.
func (s MojomStruct) ParameterString() string {
	str := ""
	for i, f := range s.fields {
		if i > 0 {
			str += ", "
		}
		attributesString := ""
		if f.attributes != nil {
			attributesString = fmt.Sprintf("%s", f.attributes)
		}
		ordinalString := ""
		if f.declaredOrdinal >= 0 {
			ordinalString = fmt.Sprintf("@%d", f.declaredOrdinal)
		}
		str += fmt.Sprintf("%s%s %s%s", attributesString, f.fieldType,
			f.simpleName, ordinalString)
	}
	return str
}

type StructField struct {
	VariableDeclarationData

	fieldType    TypeRef
	defaultValue ValueRef
	offset       int32
}

func NewStructField(fieldType TypeRef, name string, ordinal int64, attributes *Attributes, defaultValue ValueRef) *StructField {
	field := StructField{fieldType: fieldType, defaultValue: defaultValue}
	field.InitVariableDeclarationData(name, attributes, ordinal)
	return &field
}

func (f *StructField) ValidateDefaultValue() (ok bool) {
	if f.defaultValue == nil {
		return true
	}
	if literalValue, ok := f.defaultValue.(LiteralValue); ok {
		// The default value is a literal value. It is only this case we have to
		// handle now because if the default value were instead a reference then
		// it was already marked with the field type as it's assignee type and
		// it will be validated after resolution.
		assignment := LiteralAssignment{assignedValue: literalValue,
			variableName: f.SimpleName(), kind: LiteralAssignmentKindDefaultStructField}
		return f.fieldType.MarkTypeCompatible(assignment)
	}
	return true
}

func (f StructField) String() string {
	defaultValueString := ""
	if f.defaultValue != nil {
		defaultValueString = fmt.Sprintf(" = %s", f.defaultValue)
	}
	return fmt.Sprintf("%s %s%s", f.fieldType, f.simpleName, defaultValueString)
}

/////////////////////////////////////////////////////////////
// Interfaces and Methods
/////////////////////////////////////////////////////////////

type MojomInterface struct {
	UserDefinedTypeBase
	DeclarationContainer

	methodsByOrdinal map[uint32]*MojomMethod

	methodsByName map[string]*MojomMethod

	methodsByLexicalOrder []*MojomMethod
}

func NewMojomInterface(simpleName string, attributes *Attributes) *MojomInterface {
	mojomInterface := new(MojomInterface)
	mojomInterface.methodsByOrdinal = make(map[uint32]*MojomMethod)
	mojomInterface.methodsByName = make(map[string]*MojomMethod)
	mojomInterface.Init(simpleName, mojomInterface, attributes)
	return mojomInterface
}

func (i *MojomInterface) InitAsScope(parentScope *Scope) *Scope {
	i.containedScope = NewLexicalScope(ScopeInterface, parentScope,
		i.simpleName, parentScope.file)
	return i.containedScope
}

func (i *MojomInterface) AddMethod(method *MojomMethod) {
	i.methodsByName[method.simpleName] = method
	i.methodsByLexicalOrder = append(i.methodsByLexicalOrder, method)
}

func (MojomInterface) Kind() UserDefinedTypeKind {
	return UserDefinedTypeKindInterface
}

func (MojomInterface) IsAssignmentCompatibleWith(value LiteralValue) bool {
	return false
}

var ErrOrdinalRange = errors.New("ordinal value out of range")
var ErrOrdinalDuplicate = errors.New("duplicate ordinal value")

type MethodOrdinalError struct {
	Ord            int64        // The attemted ordinal
	Method         *MojomMethod // The method with the attempted ordinal
	ExistingMethod *MojomMethod // Used if Err == ErrOrdinalDuplicate
	Err            error        // the type of error (ErrOrdinalRange, ErrOrdinalDuplicate)
}

// Make MethodOrdinalError implement error.
func (e *MethodOrdinalError) Error() string {
	switch e.Err {
	case ErrOrdinalRange:
	case ErrOrdinalDuplicate:
	}
	return ""
}

func (m *MojomInterface) ComputeMethodOrdinals() error {
	nextOrdinal := uint32(0)
	for _, method := range m.methodsByLexicalOrder {
		if method.declaredOrdinal < 0 {
			method.ordinal = nextOrdinal
		} else {
			if method.declaredOrdinal >= math.MaxUint32 {
				return &MethodOrdinalError{Ord: method.declaredOrdinal, Method: method, Err: ErrOrdinalRange}
			}
			method.ordinal = uint32(method.declaredOrdinal)
		}
		if existingMethod, ok := m.methodsByOrdinal[method.ordinal]; ok {
			return &MethodOrdinalError{Ord: int64(method.ordinal), Method: method,
				ExistingMethod: existingMethod, Err: ErrOrdinalDuplicate}
		}
		m.methodsByOrdinal[method.ordinal] = method
		nextOrdinal = method.ordinal + 1
	}
	return nil
}

func (m *MojomInterface) String() string {
	if m == nil {
		return "nil"
	}
	s := fmt.Sprintf("\n---------interface--------------\n")
	s += fmt.Sprintf("%s\n", m.UserDefinedTypeBase)
	s += "     Methods\n"
	s += "     -------\n"
	for _, method := range m.methodsByName {
		s += fmt.Sprintf("     %s\n", method)
	}
	return s
}

type MojomMethod struct {
	VariableDeclarationData

	// The ordinal field differs from the declaredOrdinal field
	// in VariableDeclarationData because every method eventually gets
	// assigned an ordinal whereas the declaredOrdinal is only set
	// if the user explicitly sets it in the .mojom file.
	ordinal uint32

	parameters *MojomStruct

	responseParameters *MojomStruct
}

func NewMojomMethod(name string, ordinalValue int64, params,
	responseParams *MojomStruct) *MojomMethod {
	mojomMethod := new(MojomMethod)
	mojomMethod.InitVariableDeclarationData(name, nil, ordinalValue)
	mojomMethod.parameters = params
	mojomMethod.responseParameters = responseParams
	return mojomMethod
}

func (m *MojomMethod) String() string {
	parameterString := m.parameters.ParameterString()
	responseString := ""
	if m.responseParameters != nil {
		responseString = fmt.Sprintf(" => (%s)", m.responseParameters.ParameterString())
	}
	return fmt.Sprintf("%s(%s)%s", m.simpleName, parameterString, responseString)
}

/////////////////////////////////////////////////////////////
// Unions
/////////////////////////////////////////////////////////////
type MojomUnion struct {
	UserDefinedTypeBase

	fields []UnionField
}

func NewMojomUnion(simpleName string, attributes *Attributes) *MojomUnion {
	mojomUnion := new(MojomUnion)
	mojomUnion.fields = make([]UnionField, 0)
	mojomUnion.Init(simpleName, mojomUnion, attributes)
	return mojomUnion
}

// Adds a UnionField to this Union
func (u *MojomUnion) AddField(fieldType TypeRef, fieldName string,
	tag int64, attributes *Attributes) {
	field := UnionField{fieldType: fieldType}
	field.InitVariableDeclarationData(fieldName, attributes, tag)
	u.fields = append(u.fields, field)
}

// This should be invoked some time after all of the fields have been added
// to the union.
func (u *MojomUnion) ComputeFieldTags() {
	// TODO(rudominer) Implement MojomUnion.ComputeFieldTags()
	// Also check that names are unique.
}

func (MojomUnion) Kind() UserDefinedTypeKind {
	return UserDefinedTypeKindUnion
}

func (MojomUnion) IsAssignmentCompatibleWith(value LiteralValue) bool {
	return value.IsDefault()
}

type UnionField struct {
	VariableDeclarationData

	fieldType TypeRef
}

/////////////////////////////////////////////////////////////
// Enums
/////////////////////////////////////////////////////////////
type MojomEnum struct {
	UserDefinedTypeBase

	values         []*EnumValue
	scopeForValues *Scope
}

func NewMojomEnum(simpleName string, attributes *Attributes) *MojomEnum {
	mojomEnum := new(MojomEnum)
	mojomEnum.values = make([]*EnumValue, 0)
	mojomEnum.Init(simpleName, mojomEnum, attributes)
	return mojomEnum
}

// A MojoEnum is a ConcreteType
func (MojomEnum) ConcreteTypeKind() TypeKind {
	return TypeKindUserDefined
}

func (e MojomEnum) IsAssignmentCompatibleWith(value LiteralValue) bool {
	if value.IsDefault() {
		return true
	}
	t := value.LiteralValueType()
	if t == SimpleTypeInt8 || t == SimpleTypeInt16 || t == SimpleTypeInt32 || t == SimpleTypeInt64 {
		// TODO(rudominer) Finish MojomEnum.IsAssignmentCompatibleWith()
		// We should check that the value is in the range of the enum fields.
		// Do we want to deprecate the ability to assign an integer to an
		// enum varialbe?
		return true
	}
	return false
}

func (MojomEnum) Kind() UserDefinedTypeKind {
	return UserDefinedTypeKindEnum
}

func (e *MojomEnum) InitAsScope(parentScope *Scope) *Scope {
	e.scopeForValues = NewLexicalScope(ScopeEnum, parentScope,
		e.simpleName, parentScope.file)
	return e.scopeForValues
}

// Adds an EnumValue to this enum
func (e *MojomEnum) AddEnumValue(name string, valueRef ValueRef,
	attributes *Attributes) *DuplicateNameError {
	enumValue := new(EnumValue)
	enumValue.Init(name, UserDefinedValueKindEnum, enumValue, valueRef, attributes)
	e.values = append(e.values, enumValue)
	enumValue.enumType = e
	if e.scopeForValues == nil {
		return nil
	}
	return enumValue.RegisterInScope(e.scopeForValues)
}

func (e *MojomEnum) ComputeEnumValues() {
	// TODO(rudominer) Implement MojomEnum.ComputeEnumValues().
}

func (e *MojomEnum) String() string {
	s := fmt.Sprintf("\n---------enum--------------\n")
	s += e.toString(0)
	return s
}

func (e *MojomEnum) toString(indentLevel int) string {
	indent := strings.Repeat(" ", indentLevel)
	s := fmt.Sprintf("%s%s\n", indent, e.UserDefinedTypeBase)
	s += indent + "     Values\n"
	s += indent + "     ------\n"
	for _, value := range e.values {
		s += fmt.Sprintf(indent+"     %s", value)
	}
	return s
}

// An EnumValue is a ConcreteValue and a UserDefinedValue.
type EnumValue struct {
	UserDefinedValueBase

	enumType *MojomEnum
}

// EnumValue implements ConcreteValue
func (ev *EnumValue) ValueType() ConcreteType {
	return ev.enumType
}
func (ev *EnumValue) Value() interface{} {
	return *ev
}

func (ev *EnumValue) String() string {
	return fmt.Sprintf("%s\n", ev.UserDefinedValueBase)
}

/////////////////////////////////////////////////////////////
// Values
/////////////////////////////////////////////////////////////

// User-Defined Value Kinds
type UserDefinedValueKind int

const (
	UserDefinedValueKindEnum UserDefinedValueKind = iota
	UserDefinedValueKindDeclaredConst
	UserDefinedValueKindBuiltInConst
)

func (k UserDefinedValueKind) String() string {
	switch k {
	case UserDefinedValueKindEnum:
		return "enum value"
	case UserDefinedValueKindDeclaredConst:
		return "declared constant"
	case UserDefinedValueKindBuiltInConst:
		return "built-in constant"
	default:
		panic(fmt.Sprintf("Unknown UserDefinedValueKind: %d", k))
	}
}

// A UserDefinedValue is a UserDefinedConstant an EnumValue, or a
// BuiltInConstantValue
type UserDefinedValue interface {
	SimpleName() string
	FullyQualifiedName() string
	Kind() UserDefinedValueKind
	Scope() *Scope
	ValueKey() string
	RegisterInScope(scope *Scope) *DuplicateNameError
}

type UserDefinedValueBase struct {
	attributes         *Attributes
	thisValue          UserDefinedValue
	simpleName         string
	fullyQualifiedName string
	kind               UserDefinedValueKind
	valueKey           string
	// This is the value specified in the right-hand-side of the value
	// declaration. For an enum value it will be an integer literal. For
	// a constant declartion it may be a literal or it may be a reference.
	valueRef ValueRef
	scope    *Scope
}

// This method is invoked from the constructors for the containing types:
// NewMojomInterface, NewMojomStruct, NewMojomEnum, NewMojomUnion
func (b *UserDefinedValueBase) Init(simpleName string,
	kind UserDefinedValueKind, thisValue UserDefinedValue,
	valueRef ValueRef, attributes *Attributes) {
	b.attributes = attributes
	b.thisValue = thisValue
	b.simpleName = simpleName
	b.kind = kind
	b.valueRef = valueRef
}

func (v *UserDefinedValueBase) RegisterInScope(scope *Scope) *DuplicateNameError {
	if err := scope.RegisterValue(v.thisValue); err != nil {
		return err
	}
	v.scope = scope

	if v.thisValue.Kind() == UserDefinedValueKindEnum {
		if scope.kind != ScopeEnum {
			panic("An enum value may only be registered within the scope of an enum.")
		}
		// We register an enum value twice: Once within it's enum as a scope
		// and once within its enum's scope directly. In this way the enum
		// value may be reference either with or without the name of the
		// enum as a prefix.
		// NOTE(rudominer) This behavior was changed in light of
		// https://codereview.chromium.org/1375313006
		//if err := scope.Parent().RegisterValue(v.thisValue); err != nil {
		//	return err
		//}
	}

	v.fullyQualifiedName = buildDottedName(scope.fullyQualifiedName, v.simpleName)
	v.valueKey = computeTypeKey(v.fullyQualifiedName)
	scope.file.Descriptor.valuesByKey[v.valueKey] = v.thisValue
	return nil
}

func (b UserDefinedValueBase) String() string {
	attributeString := ""
	if b.attributes != nil {
		attributeString = fmt.Sprintf("%s", b.attributes.List)
	}
	valueRefString := ""
	if b.valueRef != nil {
		valueRefString = fmt.Sprintf(" = %s", b.valueRef)
	}
	return fmt.Sprintf("(%s)%s%s%s", b.valueKey, attributeString, b.simpleName, valueRefString)
}

func (b *UserDefinedValueBase) Kind() UserDefinedValueKind {
	return b.kind
}

func (b *UserDefinedValueBase) SimpleName() string {
	return b.simpleName
}

func (b *UserDefinedValueBase) FullyQualifiedName() string {
	return b.fullyQualifiedName
}

func (b UserDefinedValueBase) Scope() *Scope {
	return b.scope
}

func (b UserDefinedValueBase) ValueKey() string {
	return b.valueKey
}

/////////////////////////////////////////////////////////////
//Declared Constants
/////////////////////////////////////////////////////////////

// This represents a Mojom constant declaration.
type UserDefinedConstant struct {
	UserDefinedValueBase

	declaredType TypeRef
}

func NewUserDefinedConstant(name string, declaredType TypeRef, value ValueRef,
	attributes *Attributes) *UserDefinedConstant {
	constant := new(UserDefinedConstant)
	constant.Init(name, UserDefinedValueKindDeclaredConst, constant, value, attributes)
	constant.declaredType = declaredType
	return constant
}

func (b *UserDefinedConstant) String() string {
	return b.toString(0)
}

func (b *UserDefinedConstant) toString(indentLevel int) string {
	indent := strings.Repeat(" ", indentLevel)
	return fmt.Sprintf("\n%sconst %s %s", indent, b.declaredType, b.UserDefinedValueBase)
}

func (c *UserDefinedConstant) ValidateValue() (ok bool) {
	if literalValue, ok := c.valueRef.(LiteralValue); ok {
		// The value is a literal value. It is only this case we have to
		// handle now because if the  value were instead a reference then
		// it was already marked with the constants declared type as it's
		// assignee type and it will be validated after resolution.
		assignment := LiteralAssignment{assignedValue: literalValue,
			variableName: c.simpleName, kind: LiteralAssignmentKindConstantDeclaration}
		return c.declaredType.MarkTypeCompatible(assignment)
	}
	return true
}

/////////////////////////////////////////////////////////////
// BuiltIn Types and Values
/////////////////////////////////////////////////////////////

// BuiltInConstantType implements ConcreteType.
type BuiltInConstantType int

const (
	BuiltInConstant BuiltInConstantType = 0
)

func (b BuiltInConstantType) String() string {
	if b == BuiltInConstant {
		return "built-in constant"
	} else {
		panic("BuiltInConstant is the only BuiltInConstantType.")
	}
}

func (b BuiltInConstantType) ConcreteTypeKind() TypeKind {
	return TypeKindUserDefined
}

// BuiltInConstantValue implements ConcreteValue and UserDefinedValue.
type BuiltInConstantValue int

const (
	SimpleTypeFloat_INFINITY BuiltInConstantValue = iota
	SimpleTypeFloat_NEGATIVE_INFINITY
	SimpleTypeFloat_NAN
	SimpleTypeDouble_INFINITY
	SimpleTypeDouble_NEGATIVE_INFINITY
	SimpleTypeDouble_NAN
)

func LookupBuiltInConstantValue(identifier string) (val BuiltInConstantValue, ok bool) {
	val, ok = builtInConstantValues[identifier]
	return
}

var allBuiltInConstantValues = []BuiltInConstantValue{SimpleTypeFloat_INFINITY, SimpleTypeFloat_NEGATIVE_INFINITY,
	SimpleTypeFloat_NAN, SimpleTypeDouble_INFINITY, SimpleTypeDouble_NEGATIVE_INFINITY, SimpleTypeDouble_NAN}

var builtInConstantValues map[string]BuiltInConstantValue

func init() {
	builtInConstantValues = make(map[string]BuiltInConstantValue, len(allBuiltInConstantValues))
	for _, b := range allBuiltInConstantValues {
		builtInConstantValues[b.String()] = b
	}
}

func (b BuiltInConstantValue) String() string {
	switch b {
	case SimpleTypeFloat_INFINITY:
		return "float.INFINITY"
	case SimpleTypeFloat_NEGATIVE_INFINITY:
		return "float.NEGATIVE_INFINITY"
	case SimpleTypeFloat_NAN:
		return "float.NAN"
	case SimpleTypeDouble_INFINITY:
		return "double.INFINITY"
	case SimpleTypeDouble_NEGATIVE_INFINITY:
		return "double.NEGATIVE_INFINITY"
	case SimpleTypeDouble_NAN:
		return "double.NAN"
	default:
		panic(fmt.Sprintf("Unknown BuiltInConstantValue %d", b))
	}
}

// From interface ConcreteValue
func (BuiltInConstantValue) ValueType() ConcreteType {
	return BuiltInConstant
}

func (b BuiltInConstantValue) Value() interface{} {
	return b
}

// From interface UserDefinedValue

func (b BuiltInConstantValue) SimpleName() string {
	return b.String()
}

func (b BuiltInConstantValue) FullyQualifiedName() string {
	return b.String()
}

func (b BuiltInConstantValue) Kind() UserDefinedValueKind {
	return UserDefinedValueKindBuiltInConst
}

func (b BuiltInConstantValue) Scope() *Scope {
	return nil
}

func (b BuiltInConstantValue) ValueKey() string {
	return "built-in-value:" + b.String()
}

func (b BuiltInConstantValue) RegisterInScope(scope *Scope) *DuplicateNameError {
	panic("Do not register a BuiltInConstantValue in a scope.")
}

/////////////////////////////////////////////////////////////
// Declaration Data
/////////////////////////////////////////////////////////////

type VariableDeclarationData struct {
	simpleName string
	attributes *Attributes

	// We use int64 here because valid ordinals are uint32 and we want to
	// be able to represent an unset value as -1.
	declaredOrdinal int64
}

func (v *VariableDeclarationData) InitVariableDeclarationData(simpleName string,
	attributes *Attributes, ordinal int64) {
	v.simpleName = simpleName
	v.attributes = attributes
	v.declaredOrdinal = ordinal
}

func (v *VariableDeclarationData) SimpleName() string {
	return v.simpleName
}

type Attributes struct {
	List []MojomAttribute
}

func (a *Attributes) String() string {
	if a == nil {
		return "nil"
	}
	return fmt.Sprintf("%s", a.List)
}

func NewAttributes() *Attributes {
	attributes := new(Attributes)
	attributes.List = make([]MojomAttribute, 0)
	return attributes
}

type MojomAttribute struct {
	Key   string
	Value ConcreteValue
}

func (ma MojomAttribute) String() string {
	return fmt.Sprintf("%s=%s ", ma.Key, ma.Value)
}
