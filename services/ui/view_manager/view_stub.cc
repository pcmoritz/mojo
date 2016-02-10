// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_stub.h"

#include "base/bind.h"
#include "base/logging.h"
#include "services/ui/view_manager/view_registry.h"
#include "services/ui/view_manager/view_state.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

ViewStub::ViewStub(ViewRegistry* registry, mojo::ui::ViewOwnerPtr owner)
    : registry_(registry), owner_(owner.Pass()) {
  DCHECK(registry_);
  DCHECK(owner_);

  owner_.set_connection_error_handler(
      base::Bind(&ViewStub::OnViewResolved, base::Unretained(this), nullptr));
  owner_->GetToken(
      base::Bind(&ViewStub::OnViewResolved, base::Unretained(this)));
}

ViewStub::~ViewStub() {
  // Ensure that everything was properly released before this object was
  // destroyed.  The |ViewRegistry| is responsible for maintaining the
  // invariant that all |ViewState| objects are owned so by the time we
  // get here, the view should have found a new owner or been unregistered.
  DCHECK(is_unavailable());
}

void ViewStub::AttachView(ViewState* state) {
  DCHECK(state);
  DCHECK(!state->view_stub());
  DCHECK(is_pending());

  state_ = state;
  state_->set_view_stub(this);
}

ViewState* ViewStub::ReleaseView() {
  if (is_unavailable())
    return nullptr;

  ViewState* state = state_;
  if (state) {
    DCHECK(state->view_stub() == this);
    state->set_view_stub(nullptr);
    state_ = nullptr;
  }
  unavailable_ = true;
  return state;
}

void ViewStub::SetTree(ViewTreeState* tree, uint32_t key) {
  DCHECK(tree);
  DCHECK(!tree_ && !parent_);

  key_ = key;
  SetTreeRecursively(tree);
}

void ViewStub::SetParent(ViewState* parent, uint32_t key) {
  DCHECK(parent);
  DCHECK(!tree_ && !parent_);

  parent_ = parent;
  key_ = key;
  if (parent->view_stub())
    SetTreeRecursively(parent->view_stub()->tree());
}

void ViewStub::Unlink() {
  parent_ = nullptr;
  key_ = 0;
  SetTreeRecursively(nullptr);
}

void ViewStub::SetTreeRecursively(ViewTreeState* tree) {
  if (tree_ == tree)
    return;
  tree_ = tree;
  if (state_) {
    for (const auto& pair : state_->children()) {
      pair.second->SetTreeRecursively(tree);
    }
  }
}

void ViewStub::OnViewResolved(mojo::ui::ViewTokenPtr view_token) {
  DCHECK(owner_);
  owner_.reset();
  registry_->OnViewResolved(this, view_token.Pass());
}

}  // namespace view_manager
