// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_PUSH_PRODUCER_BASE_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_PUSH_PRODUCER_BASE_H_

#include "base/single_thread_task_runner.h"
#include "base/synchronization/lock.h"
#include "base/task_runner.h"
#include "mojo/services/media/common/interfaces/media_pipe.mojom.h"
#include "mojo/services/media/common/interfaces/media_state.mojom.h"
#include "services/media/framework/models/active_sink.h"
#include "services/media/framework_mojo/mojo_allocator.h"

namespace mojo {
namespace media {

// Abstract base class for push-mode producers.
// TODO(dalesat): Merge producers once transport definitions are merged.
class PushProducerBase : public ActiveSink {
 public:
  using StatusCallback = std::function<void(MediaState)>;

  PushProducerBase();

  ~PushProducerBase() override;

  // Sets a callback for reporting status updates.
  void SetStatusCallback(const StatusCallback& callback);

  // ActiveSink implementation.
  PayloadAllocator* allocator() override;

  void SetDemandCallback(const DemandCallback& demand_callback) override;

  void Prime() override;

  Demand SupplyPacket(PacketPtr packet) override;

 protected:
  // Overridden in subclasses to verify that the producer is still connected.
  virtual bool IsConnected() = 0;

  // Overridden in subclasses to push a packet to the consumer/pipe.
  // packet_raw_ptr should be wrapped in a PacketPtr for proper lifetime
  // management.
  // TODO(dalesat): Don't use a raw pointer, if possible.
  virtual void PushPacketInternal(
      Packet* packet_raw_ptr,
      MediaPacketPtr media_packet) = 0;

  // Called by subclasses when a push completes.
  void PushCompleted(const PacketPtr& packet);

  // Called by subclasses when the connection to the consumer is lost.
  void OnConnectionLost();

  // Allocates from the shared buffer.
  MojoAllocator mojo_allocator_;

 private:
  // Calls PushPacketInternal
  void PushPacket(
      Packet* packet_raw_ptr,
      MediaPacketPtr media_packet);

  // Sets the current state and calls the registered callback, if there is one.
  void SetState(MediaState state);

  // Creates a MediaPacket from a Packet.
  MediaPacketPtr CreateMediaPacket(const PacketPtr& packet);

  StatusCallback status_callback_;

  mutable base::Lock lock_;
  // THE FIELDS BELOW SHOULD ONLY BE ACCESSED WITH lock_ TAKEN.
  MediaState state_;
  bool end_of_stream_;
  DemandCallback demand_callback_;
  scoped_refptr<base::SingleThreadTaskRunner> task_runner_;
  // TODO(dalesat): Base this logic on presentation time or duration.
  uint32_t max_pushes_outstanding_;
  uint32_t current_pushes_outstanding_;
  // THE FIELDS ABOVE SHOULD ONLY BE ACCESSED WITH lock_ TAKEN.
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_MOJO_PUSH_PRODUCER_BASE_H_
