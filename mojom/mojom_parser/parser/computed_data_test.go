// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package parser

import (
	"mojom/mojom_parser/mojom"
	"strings"
	"testing"
)

// TestMinVersionErrors test the method MojomStruct.ComputeVersionInfo() which
// is invoked by ComputeFinalData. This phase occurs after resolution
// and type validation. We test that different types of errors related to
// the MinVersion attribute are correctly detected.
func TestMinVersionErrors(t *testing.T) {
	test := singleFileTest{}

	////////////////////////////////////////////////////////////
	// Test Case: Float value for MinVersion
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	  int32 x;
	  int32 y;

	  [MinVersion = 1.1]
	  array<int32>? z;

      [MinVersion = 2]
	  array<int32>? w;
	};`
		test.addTestCase(contents, []string{
			"Invalid MinVersion attribute for field z: 1.1. ",
			"The value must be a non-negative 32-bit integer value."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: string value for MinVersion
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	  int32 x;
	  int32 y;

	  [MinVersion = "1"]
	  array<int32>? z;

      [MinVersion = 2]
	  array<int32>? w;
	};`
		test.addTestCase(contents, []string{
			"Invalid MinVersion attribute for field z: \"1\". ",
			"The value must be a non-negative 32-bit integer value."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: MinVersion  is negative
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	  int32 x;
	  int32 y;

	  [MinVersion = -1]
	  array<int32>? z;

      [MinVersion = 2]
	  array<int32>? w;
	};`
		test.addTestCase(contents, []string{
			"Invalid MinVersion attribute for field z: -1. ",
			"The value must be a non-negative 32-bit integer value."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: MinVersion  is to big for 32 bits
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	  int32 x;
	  int32 y;

	  [MinVersion = 1234567890123]
	  array<int32>? z;

      [MinVersion = 2]
	  array<int32>? w;
	};`
		test.addTestCase(contents, []string{
			"Invalid MinVersion attribute for field z: 1234567890123. ",
			"The value must be a non-negative 32-bit integer value."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Min Versions must be increasing.
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	  int32 x;
	  int32 y;

	  [MinVersion = 2]
	  array<int32>? z;

      [MinVersion = 1]
	  array<int32>? w;
	};`
		test.addTestCase(contents, []string{
			"Invalid MinVersion attribute for field w: 1. ",
			"The MinVersion must be non-decreasing as a function of the ordinal.",
			" This field's MinVersion must be at least 2."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Min Versions must be increasing: ordinals are used.
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	  int32 x;
	  int32 y;

	  [MinVersion = 1]
	  array<int32>? z@3;

      [MinVersion = 2]
	  array<int32>? w@2;
	};`
		test.addTestCase(contents, []string{
			"Invalid MinVersion attribute for field z: 1. ",
			"The MinVersion must be non-decreasing as a function of the ordinal.",
			" This field's MinVersion must be at least 2."})
	}

	////////////////////////////////////////////////////////////
	// Test Case: Non-nullable type used.
	////////////////////////////////////////////////////////////
	{
		contents := `
	struct Foo{
	  int32 x;
	  int32 y;

	  [MinVersion = 1]
	  array<int32> z;

      [MinVersion = 2]
	  array<int32>? w;
	};`
		test.addTestCase(contents, []string{
			"Invalid type for field z: array<int32>.",
			"Non-nullable reference fields are only allowed in version 0 of of a struct.",
			"This field's MinVersion is 1."})
	}

	////////////////////////////////////////////////////////////
	// Execute all of the test cases.
	////////////////////////////////////////////////////////////
	for i, c := range test.cases {
		// Parse anresolve the mojom input.
		descriptor := mojom.NewMojomDescriptor()
		specifiedName := ""
		if c.importedFrom == nil {
			specifiedName = c.fileName
		}
		parser := MakeParser(c.fileName, specifiedName, c.mojomContents, descriptor, c.importedFrom)
		parser.Parse()
		if !parser.OK() {
			t.Errorf("Parsing error for %s: %s", c.fileName, parser.GetError().Error())
			continue
		}
		err := descriptor.Resolve()
		if err != nil {
			t.Errorf("Resolution error for %s: %s", c.fileName, err)
			continue
		}

		err = descriptor.ComputeFinalData()

		if err == nil {
			t.Errorf("Data computation unexpectedly succeeded for test case %d.", i)
			continue
		}

		got := err.Error()
		for _, expected := range c.expectedErrors {
			if !strings.Contains(got, expected) {
				t.Errorf("%s:\n*****expected to contain:\n%s\n****actual\n%s", c.fileName, expected, got)
			}
		}

	}
}
