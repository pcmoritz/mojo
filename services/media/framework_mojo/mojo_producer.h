// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PRODUCER_SINK_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PRODUCER_SINK_H_

#include "mojo/common/binding_set.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"
#include "services/media/framework_mojo/push_producer_base.h"

namespace mojo {
namespace media {

// Implements MediaProducer to forward a stream across mojo.
class MojoProducer : public MediaProducer, public PushProducerBase {
 public:
  using FlushConsumerCallback = mojo::Callback<void()>;

  static std::shared_ptr<MojoProducer> Create() {
    return std::shared_ptr<MojoProducer>(new MojoProducer());
  }

  ~MojoProducer() override;

  // Adds a binding.
  void AddBinding(InterfaceRequest<MediaProducer> producer);

  // Tells the connected consumer to flush.
  void FlushConsumer(const FlushConsumerCallback& callback);

  // MediaProducer implementation.
  void Connect(
      InterfaceHandle<MediaConsumer> consumer,
      const ConnectCallback& callback) override;

  void Disconnect() override;

 protected:
  // PushProducerBase overrrides.
  bool IsConnected() override;

  void PushPacketInternal(Packet* packet_raw_ptr, MediaPacketPtr media_packet)
      override;

 private:
  MojoProducer();

  BindingSet<MediaProducer> bindings_;
  MediaConsumerPtr consumer_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PRODUCER_SINK_H_
