// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_FORMATTING_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_FORMATTING_H_

#include "mojo/services/media/common/interfaces/media_common.mojom.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"
#include "mojo/services/media/common/interfaces/media_types.mojom.h"
#include "mojo/services/media/common/interfaces/rate_control.mojom.h"
#include "mojo/services/media/control/interfaces/media_source.mojom.h"
#include "services/media/framework/formatting.h"

namespace mojo {
namespace media {

// See services/media/framework/ostream.h for details.

// Mojo defines versions of operator<< for this that produce only numbers.
const char* StringFromMediaTypeScheme(MediaTypeScheme value);
const char* StringFromLpcmSampleFormat(LpcmSampleFormat value);
const char* StringFromAudioEncoding(AudioEncoding value);
const char* StringFromVideoEncoding(VideoEncoding value);
const char* StringFromMediaState(MediaState value);

// The following overloads add newlines.

template<typename T>
std::ostream& operator<<(std::ostream& os, const InterfacePtr<T>& value);

template<typename T>
std::ostream& operator<<(std::ostream& os, const Array<T>& value) {
  if (!value) {
    return os << "<nullptr>" << std::endl;
  } else if (value.size() == 0) {
      return os << "<empty>" << std::endl;
  } else {
    os << std::endl;
  }

  int index = 0;
  for (T& element : const_cast<Array<T>&>(value)) {
    os << "[" << index++ << "]: " << element;
  }

  return os;
}

std::ostream& operator<<(std::ostream& os, const MediaTypePtr& value);
std::ostream& operator<<(std::ostream& os, const MediaTypeSetPtr& value);
std::ostream& operator<<(std::ostream& os, const MediaTypeDetailsPtr& value);
std::ostream& operator<<(std::ostream& os, const MediaTypeSetDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const MultiplexedMediaTypeDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const MultiplexedMediaTypeSetDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const LpcmMediaTypeDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const LpcmMediaTypeSetDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const CompressedAudioMediaTypeDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const CompressedAudioMediaTypeSetDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const VideoMediaTypeDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const VideoMediaTypeSetDetailsPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const MediaSourceStreamDescriptorPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const TimelineQuadPtr& value);
std::ostream& operator<<(
    std::ostream& os,
    const TimelineTransformPtr& value);

} // namespace media
} // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_FORMATTING_H_
