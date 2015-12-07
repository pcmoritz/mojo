// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package mojom

import (
	"fmt"
	"mojom/mojom_parser/lexer"
	"os"
	"path/filepath"
)

// RelPathIfShorter() returns a file path equivalent to |filePath|, relative
// to the current working directory. It attempts to express |filePath| as a
// path relative to the current working diretory and will return that relative
// path if it is shorter than |filePath|. If it is unable to construct such a
// relative file path or if the resulting relative file path is longer, then the
// original |filePath| is returned.
func RelPathIfShorter(filePath string) string {
	if cwd, err := os.Getwd(); err == nil {
		if relPath, err := filepath.Rel(cwd, filePath); err == nil {
			if len(relPath) < len(filePath) {
				filePath = relPath
			}
		}
	}
	return filePath
}

// UserErrorMessage is responsible for formatting user-facing error messages
// in a uniform way.
// file: The MojomFile in which the error occurs
// token: The token most closely associated with the problem.
// message: The base error text. It should not include any location information
// as that will be added by this function.
func UserErrorMessage(file *MojomFile, token lexer.Token, message string) string {
	// TODO(rudominer|azani) Add snippets here.
	filePath := "Unknown file"
	importedFromMessage := ""
	if file != nil {
		filePath = RelPathIfShorter(file.CanonicalFileName)
		importedFromMessage = file.ImportedFromMessage()
	}
	return fmt.Sprintf("\n%s:%s: %s\n%s", filePath, token.ShortLocationString(),
		message, importedFromMessage)
}