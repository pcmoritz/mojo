// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_MEDIA_TEST_MEDIA_TEST_H_
#define EXAMPLES_MEDIA_TEST_MEDIA_TEST_H_

#include "base/macros.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/media/common/cpp/linear_transform.h"
#include "mojo/services/media/common/interfaces/rate_control.mojom.h"
#include "mojo/services/media/control/interfaces/media_factory.mojom.h"
#include "mojo/services/media/control/interfaces/media_player.mojom.h"

namespace mojo {
namespace media {
namespace examples {

// Model for media test application.
class MediaTest {
 public:
  using UpdateCallback = std::function<void()>;

  static std::unique_ptr<MediaTest> Create(
      mojo::ApplicationImpl* app,
      const std::string& input_file_name);

  ~MediaTest();

  // Registers a callback signalling that the app should update its view.
  void RegisterUpdateCallback(const UpdateCallback& callback);

  // Starts playback.
  void Play();

  // Pauses playback.
  void Pause();

  // Seeks to the position indicated in nanoseconds from the start of the media.
  void Seek(int64_t position_ns);

  // Returns the current state of the player.
  MediaState state() const;

  // Returns the current presentation time in nanoseconds.
  int64_t position_ns() const;

  // Returns the current media metadata, if there is any.
  const MediaMetadataPtr& metadata() const;

 private:
  MediaTest(mojo::ApplicationImpl* app, const std::string& input_file_name);

  // Handles a status update from the player. When called with the default
  // argument values, initiates status updates.
  void HandleStatusUpdates(
      uint64_t version = MediaPlayer::kInitialStatus,
      MediaPlayerStatusPtr status = nullptr);

  MediaPlayerPtr media_player_;
  MediaState state_;
  LinearTransform transform_ = LinearTransform(0, 0, 1, 0);
  MediaMetadataPtr metadata_;
  UpdateCallback update_callback_;

  DISALLOW_COPY_AND_ASSIGN(MediaTest);
};

}  // namespace examples
}  // namespace media
}  // namespace mojo

#endif  // EXAMPLES_MEDIA_TEST_MEDIA_TEST_H_
