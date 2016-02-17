#!/usr/bin/env python
# Copyright 2016 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Builds an SDK (in a specified target directory) from the (current) source
repository (which should not be dirty) and a given "specification" file."""


import argparse
from pylib.errors import FatalError
from pylib.git import Git, IsGitTreeDirty, SanityCheckGit, GitLsFiles
import os
import shutil
import sys


def _CopyFiles(source_path, dest_path, **kwargs):
  """Copies files from the source git repository (the current working directory
  should be the root of this repository) to the destination path. |source_path|
  and the keyword arguments are as for the arguments of |GitLsFiles|.
  |dest_path| should be the "root" destination path. Note that a file such as
  <source_path>/foo/bar/baz.quux is copied to <dest_path>/foo/bar/baz.quux."""

  # Normalize the source path. Note that this strips any trailing '/'.
  source_path = os.path.normpath(source_path)
  source_files = GitLsFiles(source_path, **kwargs)
  for source_file in source_files:
    rel_path = source_file[len(source_path) + 1:]
    dest_file = os.path.join(dest_path, rel_path)
    try:
      os.makedirs(os.path.dirname(dest_file))
    except OSError:
      pass
    shutil.copyfile(source_file, dest_file)


def main():
  parser = argparse.ArgumentParser(
      description="Constructs an SDK from a specification")
  parser.add_argument("--allow-dirty-tree", dest="allow_dirty_tree",
                      action="store_true",
                      help="proceed even if the source tree is dirty")
  parser.add_argument("sdk_spec_file", metavar="sdk_spec_file.sdk",
                      type=argparse.FileType("rb"),
                      help="spec file for the SDK to build")
  parser.add_argument("target_dir",
                      help="target directory (must not already exist)")
  args = parser.parse_args()

  target_dir = os.path.abspath(args.target_dir)

  # CD to the "src" directory (we should currently be in src/sdk_build).
  src_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir))
  os.chdir(src_dir)

  SanityCheckGit()

  if not args.allow_dirty_tree and IsGitTreeDirty():
    FatalError("tree appears to be dirty")

  try:
    os.mkdir(target_dir)
  except OSError:
    FatalError("failed to create target directory %s" % target_dir)

  def CopyFilesToTargetDir(source_path, rel_dest_path, **kwargs):
    return _CopyFiles(source_path, os.path.join(target_dir, rel_dest_path),
                      **kwargs)

  execution_globals = {"CopyFiles": CopyFilesToTargetDir,
                       "FatalError": FatalError,
                       "GitLsFiles": GitLsFiles}
  exec args.sdk_spec_file in execution_globals

  return 0


if __name__ == "__main__":
  sys.exit(main())
