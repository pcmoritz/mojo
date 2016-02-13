// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package formatter

import (
	"strings"
	"testing"
)

func TestFormatMojom(t *testing.T) {
	original := `// Top line comment.
/* left comment */ module hello.world; // Right comment

// First block line 1
// First block line 2

// Second block line 1
// Second block line 2
import "foo1.mojom";
import "foo2.mojom";

struct FooStruct { // FooStruct comment.
  // Field 1 comment.
  int8 field1; // Field 1 comment.
  int16 field2 = 10;
  // Field3 comment.
	// Field3 other comment.
  int32 field3@10 = 10;
};

struct FooUnion {
	int8 field1;
	int16 field2@5;
};

enum FooEnum {
	VALUE1,
	VALUE2 = 10,
};

// constant comment.
const int8 foo_constant = 10; // constant comment.

// Interface Comment.
interface InterfaceFoo { // Interface comment.
	const int8 const_in_interface = 20;

	// Method 1 comment.
	method1(int8 hello);
	// Method 2 comment.
	method2(int8 hello) => (Foo bar);
	method3();
	method4() => (Foo bar);
	method5(int8 p1 /* p1 comment */, int16 p2); // method comment
};

// Final comments.
`

	// TODO(azani): Remove this and just fix the tabs.
	original = strings.Replace(original, "\t", "  ", -1)

	actual, err := FormatMojom("test.mojom", original)
	if err != nil {
		t.Fatalf("Parser was not supposed to fail: %s", err.Error())
	}

	if original != actual {
		t.Fatalf("\nExpected:\n%v\n\n*****\n\nActual:\n%v", original, actual)
	}
}
