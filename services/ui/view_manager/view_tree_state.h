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

namespace view_manager {

class ViewRegistry;
class ViewState;
class ViewStub;
class ViewTreeHostImpl;

// Describes the state of a particular view tree.
// This object is owned by the ViewRegistry that created it.
class ViewTreeState {
 public:
  ViewTreeState(
      ViewRegistry* registry,
      mojo::ui::ViewTreePtr view_tree,
      mojo::ui::ViewTreeTokenPtr view_tree_token,
      mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request,
      const std::string& label);
  ~ViewTreeState();

  base::WeakPtr<ViewTreeState> GetWeakPtr() {
    return weak_factory_.GetWeakPtr();
  }

  // Gets the view tree interface, never null.
  // Caller does not obtain ownership of the view tree.
  mojo::ui::ViewTree* view_tree() const { return view_tree_.get(); }

  // Gets the token used to refer to this view tree globally.
  // Caller does not obtain ownership of the token.
  mojo::ui::ViewTreeToken* view_tree_token() const {
    return view_tree_token_.get();
  }

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

  const std::string& label() const { return label_; }
  const std::string& FormattedLabel() const;

 private:
  mojo::ui::ViewTreePtr view_tree_;
  mojo::ui::ViewTreeTokenPtr view_tree_token_;

  const std::string label_;
  mutable std::string formatted_label_cache_;

  std::unique_ptr<ViewTreeHostImpl> impl_;
  mojo::Binding<mojo::ui::ViewTreeHost> host_binding_;

  std::unique_ptr<mojo::ui::ViewTreeHost> view_tree_host_;
  std::unique_ptr<ViewStub> root_;
  bool layout_request_pending_ = false;
  bool layout_request_issued_ = false;

  base::WeakPtrFactory<ViewTreeState> weak_factory_;  // must be last

  DISALLOW_COPY_AND_ASSIGN(ViewTreeState);
};

std::ostream& operator<<(std::ostream& os, ViewTreeState* view_tree_state);

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_TREE_STATE_H_
