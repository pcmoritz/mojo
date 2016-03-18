// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_TREE_STATE_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_TREE_STATE_H_

#include <memory>
#include <set>
#include <string>
#include <unordered_map>

#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/ui/views/cpp/formatting.h"
#include "mojo/services/ui/views/interfaces/view_trees.mojom.h"
#include "services/ui/view_manager/view_container_state.h"

namespace view_manager {

class ViewRegistry;
class ViewState;
class ViewStub;
class ViewTreeImpl;

// Describes the state of a particular view tree.
// This object is owned by the ViewRegistry that created it.
class ViewTreeState : public ViewContainerState {
 public:
  ViewTreeState(ViewRegistry* registry,
                mojo::ui::ViewTreeTokenPtr view_tree_token,
                mojo::InterfaceRequest<mojo::ui::ViewTree> view_tree_request,
                mojo::ui::ViewTreeListenerPtr view_tree_listener,
                const std::string& label);
  ~ViewTreeState() override;

  base::WeakPtr<ViewTreeState> GetWeakPtr() {
    return weak_factory_.GetWeakPtr();
  }

  // Gets the token used to refer to this view tree globally.
  // Caller does not obtain ownership of the token.
  mojo::ui::ViewTreeToken* view_tree_token() const {
    return view_tree_token_.get();
  }

  // Gets the view tree listener interface, never null.
  // Caller does not obtain ownership of the view tree listener.
  mojo::ui::ViewTreeListener* view_tree_listener() const {
    return view_tree_listener_.get();
  }

  // The view tree's renderer.
  mojo::gfx::composition::Renderer* renderer() const { return renderer_.get(); }
  void SetRenderer(mojo::gfx::composition::RendererPtr renderer);

  // Gets the root of the view tree, or null if there is no root.
  ViewStub* root() const { return root_.get(); }

  // Links the root of the view tree.
  void LinkRoot(uint32_t key, std::unique_ptr<ViewStub> root);

  // Unlinks the root of the view tree and returns it.
  std::unique_ptr<ViewStub> UnlinkRoot();

  // True if there is a pending layout request.
  bool layout_request_pending() const { return layout_request_pending_; }
  void set_layout_request_pending(bool value) {
    layout_request_pending_ = value;
  }

  // True if a layout request has been issued.
  bool layout_request_issued() const { return layout_request_issued_; }
  void set_layout_request_issued(bool value) { layout_request_issued_ = value; }

  // Starts tracking a hit tester request.
  // The request will be satisfied by the current renderer if possible.
  // The callback will be invoked when the renderer changes.
  void RequestHitTester(
      mojo::InterfaceRequest<mojo::gfx::composition::HitTester>
          hit_tester_request,
      const mojo::ui::ViewInspector::GetHitTesterCallback& callback);

  const std::string& label() const { return label_; }
  const std::string& FormattedLabel() const override;

 private:
  void ClearHitTesterCallbacks(bool renderer_changed);

  mojo::ui::ViewTreeTokenPtr view_tree_token_;
  mojo::ui::ViewTreeListenerPtr view_tree_listener_;

  const std::string label_;
  mutable std::string formatted_label_cache_;

  std::unique_ptr<ViewTreeImpl> impl_;
  mojo::Binding<mojo::ui::ViewTree> view_tree_binding_;

  mojo::gfx::composition::RendererPtr renderer_;

  std::unique_ptr<ViewStub> root_;
  bool layout_request_pending_ = false;
  bool layout_request_issued_ = false;

  std::vector<mojo::ui::ViewInspector::GetHitTesterCallback>
      pending_hit_tester_callbacks_;

  base::WeakPtrFactory<ViewTreeState> weak_factory_;  // must be last

  DISALLOW_COPY_AND_ASSIGN(ViewTreeState);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_TREE_STATE_H_
