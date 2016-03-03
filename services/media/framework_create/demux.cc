// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/parts/demux.h"
#include "services/media/framework_ffmpeg/ffmpeg_demux.h"

namespace mojo {
namespace media {

Result Demux::Create(
    std::shared_ptr<Reader> reader,
    std::shared_ptr<Demux>* demux_out) {
  std::shared_ptr<Demux> demux = FfmpegDemux::Create();

  Result result = demux->Init(reader);
  if (result == Result::kOk) {
    *demux_out = demux;
  }

  return result;
}

} // namespace media
} // namespace mojo
