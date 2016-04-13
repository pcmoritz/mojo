#!/usr/bin/env python
# Copyright 2016 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Builds and optionally uploads the mojom generators to Google Cloud Storage.

This script works the same as build_mojom_tool.
"""

import os
import sys

import builder


def main():
  parser = builder.get_arg_parser("Build the mojom generators.")
  args = parser.parse_args()

  generators = [
      'deps',
      ]

  final_result = 0
  for generator in generators:
    generator_builder = builder.get_builder(
        args=args,
        target_dir='generators',
        binary_name=generator,
        src_path=os.path.join('mojom', 'mojom_parser', 'generators', generator))

    if args.upload:
      result = generator_builder.build_and_upload()
    result = generator_builder.build()
    if result != 0:
      final_result = result
      if not args.keep_going:
        return result

    return final_result


if __name__ == '__main__':
  sys.exit(main())
