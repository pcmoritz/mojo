// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file contains genCmd which parses a set of .mojom files and runs the
// code generators in order to emit generated bindings for the provided files.
//
// The gen command is invoked as follows:
//
//	mojom gen [-I <include_dirs>]
//						[--output-dir <path_to_out>]
//						[--src-root-path <path_to_src_root>]
//						[--generators <generator_list>]
//						[--no-gen-imports]
//						[--gen-arg-<extra_parameter>...]
//						<mojom_file>...
//
// <include_dirs> is the comma-separated list of directory paths to search for mojom imports.
// <path_to_out> is the root directory in which generators should place generated files.
// <path_to_src_root> is the path to the root of the source tree. The generators
//	use this to compute the directory layout of the generated files.
//	<generators> is a comma-separated list of generators to run. Each generator
//	should be the name of an executable that obeys the generator contract.
//	These executables must be found on the *generator path*
//	which is described below.
// <extra_parameter> are passed to the generators. All extra parameters must
//	start with the prefix --gen-arg. If you include --gen-arg-arg=value as a
//	parameter to this command, --arg=value will be passed to the generators. If
//	you include --gen-arg-generate-type-info as a parameter to this command,
//	--generate-type-info will be passed to the generators.
// <mojom_file>... is one or more paths to .mojom files to be parsed.
//
// If --no-gen-imports is specified, it is passed on to the generators. It tells
// the generators that bindings must be generated only for files specified on
// the command line as opposed to files specified on the command lines and their
// imports recursively.
//
// The *generator path* is a list of absolute paths to directories. When looking up
// mojom generators, this command will look in those directories for executables
// matching the generator name. By default, the generator path is
// <directory_containing_mojom_tool>/generators.
// If the MOJOM_GENERATORS environment variable is set, it is assumed to contain
// a semicolon-separated list of absolute paths which are used as the generator
// path.
//
// If there are no errors, the program returns status 0 and writes nothing to
// stderr or stdout. Otherwise, errors found by the parser or the generators
// will be printed to stderr and a non-zero status code will be returned.
package main

import (
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

const (
	extraArgPrefix     = "--gen-arg-"
	mojomGeneratorsEnv = "MOJOM_GENERATORS"
)

// genCmd implements the gen command for the mojom tool.
// The slice of strings |args| is the list of arguments passed on the command
// line starting with the program name and followed by the invoked command.
func genCmd(args []string) {
	flagSet := flag.NewFlagSet("gen", flag.ContinueOnError)
	var importPaths DirectoryList
	flagSet.Var(&importPaths, "I",
		"comma-separated list of directory paths to search for mojom imports")
	outputDir := flagSet.String("output-dir", ".",
		"output directory for generated files.")
	srcRootPath := flagSet.String("src-root-path", ".",
		"relative path to the root of the source tree.")
	noGenImports := flagSet.Bool("no-gen-imports", false,
		"Generate code only for the files that are specified on the command line. "+
			"By default, code is generated for all specified files and their transitive imports.")
	var generatorNames CommaSeparatedList
	flagSet.Var(&generatorNames, "generators", "Comma-separated list of generators")
	flagSet.SetOutput(ioutil.Discard)

	printUsage := func() {
		fmt.Fprintf(os.Stderr, "Usage: %s gen [-I <include_dirs>] "+
			"[--output-dir <path_to_dir>] "+
			"[--src-root-path <path_to_src_root>] "+
			"[--generators <generator_list>] "+
			"[--no-gen-imports] "+
			"<mojom_file>\n\n", filepath.Base(args[0]))
		fmt.Fprintf(os.Stderr, UsageString(flagSet))
		fmt.Fprintf(os.Stderr, "Arguments with the --gen-arg- prefix will be passed "+
			"to every generator. So for instance, to pass --arg=value, you would "+
			"use --gen-arg-arg=value. To pass --arg, you would use --gen-arg-arg.\n")
	}

	// If err is not ErrHelp, the only way to figure out what it was is to look at
	// the message provided for users.
	if err := flagSet.Parse(args[2:]); err != nil && !strings.HasPrefix(err.Error(), "flag provided but not defined") {
		if err != flag.ErrHelp {
			fmt.Fprintln(os.Stderr, err.Error())
		}
		printUsage()
		os.Exit(1)
	}
	generatorPaths := findGeneratorPaths(mojomGenPaths(), generatorNames)

	var fileNames []string
	var extraArgs []string
	for _, arg := range flagSet.Args() {
		// TODO(azani): Implement generator-specific arguments.
		if strings.HasPrefix(arg, extraArgPrefix) {
			extraArgs = append(extraArgs, "--"+arg[len(extraArgPrefix):])
		} else if strings.HasPrefix(arg, "--") {
			// Catch unknown arguments.
			fmt.Fprintf(os.Stderr, "Unrecognized argument %s.\n", arg)
			printUsage()
			os.Exit(1)
		} else {
			fileNames = append(fileNames, arg)
		}
	}

	mojomBytes := parse(fileNames, importPaths, printUsage, false, false)

	for _, generatorPath := range generatorPaths {
		// Consider running the generators in parallel.
		runGenerator(generatorPath, mojomBytes, *noGenImports, *srcRootPath, *outputDir, extraArgs)
	}
}

func runGenerator(generatorPath string, mojomBytes []byte, noGenImports bool, srcRootPath string, outputDir string, extraArgs []string) {
	var args []string
	args = append(args, "--file-graph", "-")
	args = append(args, "--output-dir", outputDir)
	args = append(args, "--src-root-path", srcRootPath)
	args = append(args, extraArgs...)
	if noGenImports {
		args = append(args, "--no-gen-imports")
	}

	cmd := exec.Command(generatorPath, args...)
	// We get pipes for both stdin and stderr before starting the command.
	stdinWriter, err := cmd.StdinPipe()
	if err != nil {
		log.Fatalln(err.Error())
	}
	var stdErrReader io.ReadCloser
	stdErrReader, err = cmd.StderrPipe()
	if err != nil {
		log.Fatalln(err.Error())
	}

	err = cmd.Start()
	if err != nil {
		log.Fatalln(err.Error())
	}

	// We write the serialized mojom to the command's stdin and send an eof on
	// that pipe before anything else.
	_, err = stdinWriter.Write(mojomBytes)
	if err != nil {
		log.Fatalln(err.Error())
	}
	if err := stdinWriter.Close(); err != nil {
		log.Fatalln(err.Error())
	}

	// We collect whatever was written to stderr.
	var stdErr []byte
	stdErr, err = ioutil.ReadAll(stdErrReader)
	if err != nil {
		log.Fatalln(err.Error())
	}
	if err := stdErrReader.Close(); err != nil {
		log.Fatalln(err.Error())
	}

	if err := cmd.Wait(); err != nil {
		// If stderr is empty, we print stderr otherwise, we use the error message.
		if len(stdErr) > 0 {
			log.Fatal(string(stdErr))
		} else {
			log.Fatalln(err.Error())
		}
	}
}

// mojomGenPaths returns a list of absolute paths where generators should be
// located.
//
// If the environment variable MOJOM_GENERATORS is empty, the generators are
// assumed to be located at {path-to-mojom-tool-dir}/generators.
//
// Otherwise, MOJOM_GENERATORS is expected to contain a semi-colon separated
// list of absolute paths.
func mojomGenPaths() []string {
	env := os.Getenv(mojomGeneratorsEnv)
	if env == "" {
		mojomToolPath, _ := filepath.Abs(filepath.Join(os.Args[0]))
		generatorsPath := filepath.Join(filepath.Dir(mojomToolPath), "generators")
		return []string{generatorsPath}
	}

	genPaths := strings.Split(env, ";")
	for _, genPath := range genPaths {
		if !filepath.IsAbs(genPath) {
			log.Fatalf("%s is not an absolute path!", genPath)
		}
	}
	return genPaths
}

// findGeneratorPaths searches through the directories listed in |paths| files
// named after |generator| and returns the path to those files.
func findGeneratorPaths(paths []string, generators []string) (generatorPaths []string) {
	for _, generator := range generators {
		generatorPath := findGeneratorPath(paths, generator)
		if generatorPath != "" {
			generatorPaths = append(generatorPaths, generatorPath)
		}
	}

	return
}

// findGeneratorPath searches through the directories listed in |paths| for a
// file named |generatorName| and returns the path to that file. If no such file
// is found, the empty string is returned.
func findGeneratorPath(paths []string, generatorName string) string {
	for _, path := range paths {
		genPath := filepath.Join(path, generatorName)
		if fileInfo, err := os.Stat(genPath); err == nil && !fileInfo.IsDir() {
			return genPath
		}
	}
	return ""
}
