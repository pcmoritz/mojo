// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package tests

import (
	"mojo/public/interfaces/bindings/tests/test_enums"
	"testing"
)

func TestEnums(t *testing.T) {
	if test_enums.TestEnum_Foo != IdentityEnum1(test_enums.TestEnum_Foo) {
		t.Errorf("IdentityEnum1 failure.")
	}

	if test_enums.TestEnum2_Foo != IdentityEnum2(test_enums.TestEnum2_Foo) {
		t.Errorf("IdentityEnum1 failure.")
	}
}

func IdentityEnum1(x test_enums.TestEnum) test_enums.TestEnum {
	return x
}

func IdentityEnum2(x test_enums.TestEnum2) test_enums.TestEnum2 {
	return x
}
