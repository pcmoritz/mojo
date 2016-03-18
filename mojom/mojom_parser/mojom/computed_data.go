// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"fmt"
)

// ComputeFinalData() should be invoked after Resolve() has completed
// successfully. It computes the field packing and version data that will
// be used by the code generators.
func (d *MojomDescriptor) ComputeFinalData() error {
	for _, userDefinedType := range d.TypesByKey {
		if err := userDefinedType.ComputeFinalData(); err != nil {
			return err
		}
	}
	return nil
}

func (e *MojomEnum) ComputeFinalData() error {
	return e.ComputeEnumValueIntegers()
}

func (e *MojomStruct) ComputeFinalData() error {
	if err := e.ComputeVersionInfo(); err != nil {
		return err
	}
	if err := e.ComputeFieldOffsets(); err != nil {
		return err
	}
	return nil
}

func (i *MojomInterface) ComputeFinalData() error {
	for _, method := range i.MethodsByOrdinal {
		if method.Parameters != nil {
			if err := (*method.Parameters).ComputeVersionInfo(); err != nil {
				return err
			}
			if err := (*method.Parameters).ComputeFieldOffsets(); err != nil {
				return err
			}
		}
		if method.ResponseParameters != nil {
			if err := (*method.ResponseParameters).ComputeVersionInfo(); err != nil {
				return err
			}
			if err := (*method.ResponseParameters).ComputeFieldOffsets(); err != nil {
				return err
			}
		}
	}
	return nil
}

func (u *MojomUnion) ComputeFinalData() error {
	return nil
}

// ComputeEnumValueIntegers() computes the |ComputedIntValue| field of all
// the values in |enum|.
func (enum *MojomEnum) ComputeEnumValueIntegers() error {
	previousValue := int32(-1)
	for _, enumValue := range enum.Values {
		if enumValue.ValueRef() == nil {
			previousValue++
		} else {
			value, err := int32EnumValueFromValue(enum, enumValue.ValueRef())
			if err != nil {
				return err
			}
			previousValue = value
		}
		enumValue.ComputedIntValue = previousValue
		enumValue.IntValueComputed = true
	}
	return nil
}

// int32EnumValueFromValue() extracts an int32 value from |valueRef| to be used to set
// the |ComputedIntValue| field of an EnumValue from |enum|. It is assumed
// that |valueRef| is of one of three types:
// (i) A LiteralValue that contains an integer value that can be represented as an int32
// (ii) A UserValueRef whose resolved concrete value is as in (i)
// (iii) A UserValueRef whose resolved concrete value is an EnumValue
//   (*) in which |IntValueComputed| is true.
//
// It is the responsibility of the parsing and resolution phases to ensure that all EnumValues
// satisfy (i), (ii) or (iii) (excluding (*)). This function will panic otherwise.
// In case (iii)(*) is not true this function will not panic but will return a
// non-nil error.
//
// Because of case (ii) an EnumValue is allowed to be initialized to a user defined constant
// of integer type.
//
// Because of case (iii) an EnumValue is allowed to be initialized to a different EnumValue
// but because of (iii)(*) that EnumValue must have had its |ComputedIntValue| computed
// prior to the current attempt. In practice this means it is safe for an EnumValue
// to be initialized in terms of an earlier EnumValue from the same Enum. Future enhancements
// may allow more general patterns.
func int32EnumValueFromValue(enum *MojomEnum, valueRef ValueRef) (int32, error) {
	var int32EnumValue int32
	switch specifiedValue := valueRef.(type) {
	case LiteralValue:
		value, ok := int32Value(specifiedValue)
		if !ok {
			// Panic because this was supposed to be caught by an earlier layer.
			panic(fmt.Sprintf("Illegal literal value '%v' in initializer for enum %v",
				specifiedValue.Value(), enum))
		}
		int32EnumValue = value
	case *UserValueRef:
		if specifiedValue.resolvedConcreteValue == nil {
			// Panic because this was supposed to be caught by an earlier layer.
			panic(fmt.Sprintf("Unresolved value reference %v in initializer for enum %v",
				specifiedValue, enum))
		}
		switch resolvedConcreteValue := specifiedValue.resolvedConcreteValue.(type) {
		case LiteralValue:
			value, ok := int32Value(resolvedConcreteValue)
			if !ok {
				// Panic because this was supposed to be caught by an earlier layer.
				panic(fmt.Sprintf("Illegal literal value '%v' as concrete value of %v in initializer for enum %v",
					resolvedConcreteValue, specifiedValue, enum))
			}
			int32EnumValue = value
		case *EnumValue:
			if resolvedConcreteValue.IntValueComputed {
				int32EnumValue = resolvedConcreteValue.ComputedIntValue
			} else {
				// TODO(rudominer) Allow enum values to be initialized to other enum values as long
				// as the assignment chain is well-founded.
				message := fmt.Sprintf("The reference %s is being used as an enum value initializer but it has resolved to a "+
					"different enum value that itself does not yet have an integer value.", specifiedValue.identifier)
				message = UserErrorMessage(specifiedValue.scope.file, specifiedValue.token, message)
				return 0, fmt.Errorf(message)

			}
		default:
			panic(fmt.Sprintf("Unexpected resolvedConcreteValue type %T", resolvedConcreteValue))
		}

	default:
		panic(fmt.Sprintf("Unexpected ValueRef type %T", specifiedValue))
	}
	return int32EnumValue, nil
}
