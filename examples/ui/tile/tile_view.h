// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_TILE_TILE_VIEW_H_
#define EXAMPLES_UI_TILE_TILE_VIEW_H_

#include <map>
#include <memory>

#include "mojo/services/ui/views/interfaces/view_provider.mojom.h"
#include "mojo/ui/base_view.h"

namespace examples {

class TileView : public mojo::ui::BaseView {
 public:
  TileView(mojo::ApplicationImpl* app_impl_,
           mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
           const std::vector<std::string>& view_urls);

  ~TileView() override;

 private:
  struct ViewData {
    explicit ViewData(const std::string& url, uint32_t key);
    ~ViewData();

    const std::string url;
    const uint32_t key;

    mojo::ui::ViewLayoutParamsPtr layout_params;
    mojo::RectF layout_bounds;
    mojo::ui::ViewInfoPtr view_info;
  };

  // |BaseView|:
  void OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                mojo::Array<uint32_t> children_needing_layout,
                const OnLayoutCallback& callback) override;
  void OnChildAttached(uint32_t child_key,
                       mojo::ui::ViewInfoPtr child_view_info,
                       const OnChildAttachedCallback& callback) override;
  void OnChildUnavailable(uint32_t child_key,
                          const OnChildUnavailableCallback& callback) override;

  void ConnectViews();
  void OnChildLayoutFinished(uint32_t child_key,
                             mojo::ui::ViewLayoutInfoPtr child_layout_info);
  void UpdateScene();

  void OnFrameSubmitted();

  std::vector<std::string> view_urls_;
  std::map<uint32_t, std::unique_ptr<ViewData>> views_;

  mojo::Size size_;

  DISALLOW_COPY_AND_ASSIGN(TileView);
};

}  // namespace examples

#endif  // EXAMPLES_UI_TILE_TILE_VIEW_H_
