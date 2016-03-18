// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_

#include <memory>
#include <set>
#include <string>
#include <unordered_map>

#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/ui/views/cpp/formatting.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"
#include "services/ui/view_manager/view_container_state.h"
#include "services/ui/view_manager/view_layout_request.h"

namespace view_manager {

class ViewRegistry;
class ViewImpl;
class ViewStub;

// Describes the state of a particular view.
// This object is owned by the ViewRegistry that created it.
class ViewState : public ViewContainerState {
 public:
  using ChildrenMap = std::unordered_map<uint32_t, std::unique_ptr<ViewStub>>;

  ViewState(ViewRegistry* registry,
            mojo::ui::ViewTokenPtr view_token,
            mojo::InterfaceRequest<mojo::ui::View> view_request,
            mojo::ui::ViewListenerPtr view_listener,
            const std::string& label);
  ~ViewState() override;

  base::WeakPtr<ViewState> GetWeakPtr() { return weak_factory_.GetWeakPtr(); }

  // Gets the token used to refer to this view globally.
  // Caller does not obtain ownership of the token.
  mojo::ui::ViewToken* view_token() const { return view_token_.get(); }

  // Gets the view listener interface, never null.
  // Caller does not obtain ownership of the view listener.
  mojo::ui::ViewListener* view_listener() const { return view_listener_.get(); }

  // Gets or sets the view stub which links this view into the
  // view hierarchy, or null if the view isn't linked anywhere.
  ViewStub* view_stub() const { return view_stub_; }
  void set_view_stub(ViewStub* view_stub) { view_stub_ = view_stub; }

  // The map of children, indexed by child key.
  // The view stub pointers are never null but some view stubs may
  // have been marked unavailable.
  const ChildrenMap& children() const { return children_; }

  // Links a child into the view tree.
  void LinkChild(uint32_t key, std::unique_ptr<ViewStub> child);

  // Unlinks a child of the view tree.
  std::unique_ptr<ViewStub> UnlinkChild(uint32_t key);

  // Unlinks all children as a single operation.
  std::vector<std::unique_ptr<ViewStub>> UnlinkAllChildren();

  // The set of children needing layout.
  // This set must never contain non-existent or unavailable children.
  std::set<uint32_t>& children_needing_layout() {
    return children_needing_layout_;
  }

  // The list of pending layout requests.
  std::vector<std::unique_ptr<ViewLayoutRequest>>& pending_layout_requests() {
    return pending_layout_requests_;
  }

  // The layout parameters most recently processed by the view,
  // or null if none.  These parameters are preserved across reparenting.
  mojo::ui::ViewLayoutParams* layout_params() { return layout_params_.get(); }
  void set_layout_params(mojo::ui::ViewLayoutParamsPtr layout_params) {
    layout_params_ = layout_params.Pass();
  }

  // The layout result most recently provided by the view in
  // response to the value of |layout_params|, or null if none.  These
  // results are preserved across reparenting.
  mojo::ui::ViewLayoutResult* layout_result() { return layout_result_.get(); }
  void set_layout_result(mojo::ui::ViewLayoutResultPtr layout_result) {
    layout_result_ = layout_result.Pass();
  }

  // The current scene token, or null if none.
  mojo::gfx::composition::SceneToken* scene_token() {
    return scene_token_.get();
  }
  void set_scene_token(mojo::gfx::composition::SceneTokenPtr scene_token) {
    scene_token_ = scene_token.Pass();
  }

  // Creates layout information to return to the parent or tree.
  // Returns null if unavailable.
  mojo::ui::ViewLayoutInfoPtr CreateLayoutInfo();

  // Binds the |ViewOwner| interface to the view which has the effect of
  // tying the view's lifetime to that of the owner's pipe.
  void BindOwner(
      mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request);

  // Unbinds the view from its owner.
  void ReleaseOwner();

  const std::string& label() const { return label_; }
  const std::string& FormattedLabel() const override;

 private:
  mojo::ui::ViewTokenPtr view_token_;
  mojo::ui::ViewListenerPtr view_listener_;

  const std::string label_;
  mutable std::string formatted_label_cache_;

  std::unique_ptr<ViewImpl> impl_;
  mojo::Binding<mojo::ui::View> view_binding_;
  mojo::Binding<mojo::ui::ViewOwner> owner_binding_;

  ViewStub* view_stub_ = nullptr;

  ChildrenMap children_;
  std::set<uint32_t> children_needing_layout_;
  std::vector<std::unique_ptr<ViewLayoutRequest>> pending_layout_requests_;
  mojo::ui::ViewLayoutParamsPtr layout_params_;
  mojo::ui::ViewLayoutResultPtr layout_result_;
  mojo::gfx::composition::SceneTokenPtr scene_token_;

  base::WeakPtrFactory<ViewState> weak_factory_;  // must be last

  DISALLOW_COPY_AND_ASSIGN(ViewState);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_
