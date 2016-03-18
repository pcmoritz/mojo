// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_STUB_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_STUB_H_

#include <memory>
#include <vector>

#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"
#include "services/ui/view_manager/view_layout_request.h"

namespace view_manager {

class ViewRegistry;
class ViewState;
class ViewTreeState;

// Describes a link in the view hierarchy either from a parent view to one
// of its children or from the view tree to its root view.
//
// When this object is created, it is not yet known whether the linked
// view actually exists.  We must wait for a response from the view owner
// to resolve the view's token and associate the stub with its child.
//
// Instances of this object are held by a unique pointer owned by the
// parent view or view tree at the point where the view is being linked.
// Note that the lifetime of the views themselves is managed by the view
// registry.
class ViewStub {
 public:
  // Begins the process of resolving a view.
  // Invokes |ViewRegistry.OnViewResolved| when the token is obtained
  // from the owner or passes nullptr if an error occurs.
  ViewStub(ViewRegistry* registry,
           mojo::InterfaceHandle<mojo::ui::ViewOwner> owner);
  ~ViewStub();

  base::WeakPtr<ViewStub> GetWeakPtr() { return weak_factory_.GetWeakPtr(); }

  // Gets the view state referenced by the stub, or null if the view
  // has not yet been resolved or is unavailable.
  ViewState* state() const { return state_; }

  // Returns true if the view which was intended to be referenced by the
  // stub has become unavailable.
  bool is_unavailable() const { return unavailable_; }

  // Returns true if awaiting resolution of the view.
  bool is_pending() const { return !state_ && !unavailable_; }

  // Returns true if the view is linked into a tree or parent.
  bool is_linked() const { return tree_ || parent_; }

  // Returns true if the view is linked into a tree and has no parent.
  bool is_root_of_tree() const { return tree_ && !parent_; }

  // Gets the view tree to which this view belongs, or null if none.
  ViewTreeState* tree() const { return tree_; }

  // Gets the parent view state, or null if none.
  ViewState* parent() const { return parent_; }

  // Gets the key that this child has in its container, or 0 if none.
  uint32_t key() const { return key_; }

  // Gets the wrapped scene exposed to the container.
  mojo::gfx::composition::Scene* stub_scene() const {
    return stub_scene_.get();
  }
  const mojo::gfx::composition::SceneToken* stub_scene_token() const {
    return stub_scene_token_.get();
  }

  // A pending layout request, held until such time as the view is attached.
  std::unique_ptr<ViewLayoutRequest>& pending_layout_request() {
    return pending_layout_request_;
  }

  // Binds the stub to the specified actual view, which must not be null.
  // Must be called at most once to apply the effects of resolving the
  // view owner.
  void AttachView(ViewState* state,
                  mojo::gfx::composition::ScenePtr stub_scene);

  // Sets the stub scene token, which must not be null.
  // Called after |AttachView| once the scene token is known.
  void SetStubSceneToken(
      mojo::gfx::composition::SceneTokenPtr stub_scene_token);

  // Marks the stub as unavailable.
  // Returns the previous view state, or null if none.
  ViewState* ReleaseView();

  // THESE METHODS SHOULD ONLY BE CALLED BY VIEW STATE OR VIEW TREE STATE

  // Recursively sets the view tree to which this view and all of its
  // descendents belong.  Must not be null.  This method must only be called
  // on root views.
  void SetTree(ViewTreeState* tree, uint32_t key);

  // Sets the parent view state pointer, the child's key in its parent,
  // and set its view tree to that of its parent.  Must not be null.
  void SetParent(ViewState* parent, uint32_t key);

  // Resets the parent view state and tree pointers to null.
  void Unlink();

 private:
  void SetTreeRecursively(ViewTreeState* tree);
  void OnViewResolved(mojo::ui::ViewTokenPtr view_token);

  ViewRegistry* registry_;
  mojo::ui::ViewOwnerPtr owner_;
  ViewState* state_ = nullptr;
  bool unavailable_ = false;
  mojo::gfx::composition::ScenePtr stub_scene_;
  mojo::gfx::composition::SceneTokenPtr stub_scene_token_;
  std::unique_ptr<ViewLayoutRequest> pending_layout_request_;

  ViewTreeState* tree_ = nullptr;
  ViewState* parent_ = nullptr;
  uint32_t key_ = 0u;

  base::WeakPtrFactory<ViewStub> weak_factory_;

  DISALLOW_COPY_AND_ASSIGN(ViewStub);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_STUB_H_
