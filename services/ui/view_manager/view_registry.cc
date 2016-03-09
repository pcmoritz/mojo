// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_registry.h"

#include <algorithm>
#include <utility>

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "mojo/services/ui/views/cpp/formatting.h"
#include "services/ui/view_manager/view_impl.h"
#include "services/ui/view_manager/view_tree_impl.h"

namespace view_manager {
namespace {
bool AreViewLayoutParamsValid(const mojo::ui::ViewLayoutParams* params) {
  return params && params->constraints && params->constraints->min_width >= 0 &&
         params->constraints->max_width >= params->constraints->min_width &&
         params->constraints->min_height >= 0 &&
         params->constraints->max_height >= params->constraints->min_height &&
         params->device_pixel_ratio > 0;
}

bool IsSizeInBounds(mojo::ui::BoxConstraints* constraints, mojo::Size* size) {
  return size && size->width >= constraints->min_width &&
         size->width <= constraints->max_width &&
         size->height >= constraints->min_height &&
         size->height <= constraints->max_height;
}
}  // namespace

ViewRegistry::ViewRegistry(mojo::gfx::composition::CompositorPtr compositor)
    : compositor_(compositor.Pass()) {}

ViewRegistry::~ViewRegistry() {}

void ViewRegistry::ConnectAssociates(
    mojo::ApplicationImpl* app_impl,
    const std::vector<std::string>& urls,
    const AssociateConnectionErrorCallback& connection_error_callback) {
  associate_table_.ConnectAssociates(app_impl, this, urls,
                                     connection_error_callback);
}

void ViewRegistry::CreateView(
    mojo::InterfaceRequest<mojo::ui::View> view_request,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    mojo::ui::ViewListenerPtr view_listener,
    const mojo::String& label) {
  DCHECK(view_request.is_pending());
  DCHECK(view_owner_request.is_pending());
  DCHECK(view_listener);

  auto view_token = mojo::ui::ViewToken::New();
  view_token->value = next_view_token_value_++;
  CHECK(view_token->value);
  CHECK(!FindView(view_token->value));

  // Create the state and bind the interfaces to it.
  std::string sanitized_label =
      label.get().substr(0, mojo::ui::kLabelMaxLength);
  ViewState* view_state =
      new ViewState(this, view_token.Pass(), view_request.Pass(),
                    view_listener.Pass(), sanitized_label);
  view_state->BindOwner(view_owner_request.Pass());

  // Add to registry and return token.
  views_by_token_.insert({view_state->view_token()->value, view_state});
  DVLOG(1) << "CreateView: view=" << view_state;
}

void ViewRegistry::OnViewDied(ViewState* view_state,
                              const std::string& reason) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DVLOG(1) << "OnViewDied: view=" << view_state << ", reason=" << reason;

  UnregisterView(view_state);
}

void ViewRegistry::UnregisterView(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DVLOG(1) << "UnregisterView: view=" << view_state;

  // Remove from parent or roots.
  // This may send a view unavailable message to the view's parent or tree.
  HijackView(view_state);

  // Recursively unregister all children since they will become unowned
  // at this point taking care to unlink each one before its unregistration.
  for (auto& child : view_state->UnlinkAllChildren())
    UnregisterViewStub(std::move(child));

  // Remove from registry.
  views_by_token_.erase(view_state->view_token()->value);
  delete view_state;
}

void ViewRegistry::CreateViewTree(
    mojo::InterfaceRequest<mojo::ui::ViewTree> view_tree_request,
    mojo::ui::ViewTreeListenerPtr view_tree_listener,
    const mojo::String& label) {
  DCHECK(view_tree_request.is_pending());
  DCHECK(view_tree_listener);

  auto view_tree_token = mojo::ui::ViewTreeToken::New();
  view_tree_token->value = next_view_tree_token_value_++;
  CHECK(view_tree_token->value);
  CHECK(!FindViewTree(view_tree_token->value));

  // Create the state and bind the interfaces to it.
  std::string sanitized_label =
      label.get().substr(0, mojo::ui::kLabelMaxLength);
  ViewTreeState* tree_state =
      new ViewTreeState(this, view_tree_token.Pass(), view_tree_request.Pass(),
                        view_tree_listener.Pass(), sanitized_label);

  // Add to registry.
  view_trees_by_token_.insert(
      {tree_state->view_tree_token()->value, tree_state});
  DVLOG(1) << "CreateViewTree: tree=" << tree_state;
}

void ViewRegistry::OnViewTreeDied(ViewTreeState* tree_state,
                                  const std::string& reason) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "OnViewTreeDied: tree=" << tree_state << ", reason=" << reason;

  UnregisterViewTree(tree_state);
}

void ViewRegistry::UnregisterViewTree(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "UnregisterViewTree: tree=" << tree_state;

  // Unlink the root if needed.
  if (tree_state->root())
    UnregisterViewStub(tree_state->UnlinkRoot());

  // Remove from registry.
  view_trees_by_token_.erase(tree_state->view_tree_token()->value);
  delete tree_state;
}

void ViewRegistry::CreateScene(
    ViewState* view_state,
    mojo::InterfaceRequest<mojo::gfx::composition::Scene> scene) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DCHECK(scene.is_pending());
  DVLOG(1) << "CreateScene: view=" << view_state;

  compositor_->CreateScene(
      scene.Pass(), view_state->label(),
      base::Bind(&ViewRegistry::OnSceneCreated, base::Unretained(this),
                 view_state->GetWeakPtr()));
}

void ViewRegistry::OnSceneCreated(
    base::WeakPtr<ViewState> view_state_weak,
    mojo::gfx::composition::SceneTokenPtr scene_token) {
  DCHECK(scene_token);
  ViewState* view_state = view_state_weak.get();
  if (view_state) {
    DVLOG(1) << "OnSceneCreated: scene_token=" << scene_token;

    view_state->set_scene_token(scene_token.Pass());
    view_state->set_scene_changed_since_last_report(true);
    InvalidateLayout(view_state);
  }
}

void ViewRegistry::RequestLayout(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DVLOG(1) << "RequestLayout: view=" << view_state;

  InvalidateLayout(view_state);
}

void ViewRegistry::AddChild(
    ViewState* parent_state,
    uint32_t child_key,
    mojo::InterfaceHandle<mojo::ui::ViewOwner> child_view_owner) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(child_view_owner);
  DVLOG(1) << "AddChild: parent=" << parent_state
           << ", child_key=" << child_key;

  // Ensure there are no other children with the same key.
  if (parent_state->children().find(child_key) !=
      parent_state->children().end()) {
    LOG(ERROR) << "View attempted to add a child with a duplicate key: "
               << "parent=" << parent_state << ", child_key=" << child_key;
    UnregisterView(parent_state);
    return;
  }

  // Add a stub, pending resolution of the view owner.
  parent_state->LinkChild(child_key, std::unique_ptr<ViewStub>(new ViewStub(
                                         this, child_view_owner.Pass())));

  // Schedule layout of the parent on behalf of its newly added child.
  // We don't need to schedule layout of the child until the parent provides
  // new layout parameters.
  InvalidateLayoutForChild(parent_state, child_key);
}

void ViewRegistry::RemoveChild(ViewState* parent_state,
                               uint32_t child_key,
                               mojo::InterfaceRequest<mojo::ui::ViewOwner>
                                   transferred_view_owner_request) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DVLOG(1) << "RemoveChild: parent=" << parent_state
           << ", child_key=" << child_key;

  // Ensure the child key exists in the parent.
  auto child_it = parent_state->children().find(child_key);
  if (child_it == parent_state->children().end()) {
    LOG(ERROR) << "View attempted to remove a child with an invalid key: "
               << "parent=" << parent_state << ", child_key=" << child_key;
    UnregisterView(parent_state);
    return;
  }

  // Unlink the child from its parent.
  TransferOrUnregisterViewStub(parent_state->UnlinkChild(child_key),
                               transferred_view_owner_request.Pass());

  // Schedule layout for the parent now that it has lost its child.
  // We don't need to schedule layout for the child itself since it will
  // retain its old layout parameters until it is reparented.
  InvalidateLayout(parent_state);
}

void ViewRegistry::LayoutChild(
    ViewState* parent_state,
    uint32_t child_key,
    mojo::ui::ViewLayoutParamsPtr child_layout_params,
    const ViewLayoutCallback& callback) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(child_layout_params);
  DCHECK(child_layout_params->constraints);
  DVLOG(1) << "LayoutChild: parent=" << parent_state
           << ", child_key=" << child_key
           << ", child_layout_params=" << child_layout_params;

  // Check whether the layout parameters are well-formed.
  if (!AreViewLayoutParamsValid(child_layout_params.get())) {
    LOG(ERROR) << "View provided invalid child layout parameters: "
               << "parent=" << parent_state << ", child_key=" << child_key
               << ", child_layout_params=" << child_layout_params;
    UnregisterView(parent_state);
    callback.Run(nullptr);
    return;
  }

  // Check whether the child key exists in the parent.
  auto child_it = parent_state->children().find(child_key);
  if (child_it == parent_state->children().end()) {
    LOG(ERROR) << "View attempted to layout a child with an invalid key: "
               << "parent=" << parent_state << ", child_key=" << child_key
               << ", child_layout_params=" << child_layout_params;
    UnregisterView(parent_state);
    callback.Run(nullptr);
    return;
  }

  SetLayout(child_it->second.get(), child_layout_params.Pass(), callback);
}

void ViewRegistry::ConnectToViewService(
    ViewState* view_state,
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  DCHECK(IsViewStateRegisteredDebug(view_state));

  associate_table_.ConnectToViewService(view_state->view_token()->Clone(),
                                        service_name, client_handle.Pass());
}

void ViewRegistry::SetRenderer(ViewTreeState* tree_state,
                               mojo::gfx::composition::RendererPtr renderer) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "SetRenderer";

  if (renderer) {
    renderer.set_connection_error_handler(
        base::Bind(&ViewRegistry::OnRendererDied, base::Unretained(this),
                   base::Unretained(tree_state)));
  }

  tree_state->set_renderer(renderer.Pass());
  UpdateViewTreeRootScene(tree_state);
}

void ViewRegistry::RequestLayout(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "RequestLayout: tree=" << tree_state;

  InvalidateLayoutForRoot(tree_state);
}

void ViewRegistry::SetRoot(
    ViewTreeState* tree_state,
    uint32_t root_key,
    mojo::InterfaceHandle<mojo::ui::ViewOwner> root_view_owner) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DCHECK(root_view_owner);
  DVLOG(1) << "SetRoot: tree=" << tree_state << ", root_key=" << root_key;

  // Ensure there isn't already a root.
  if (tree_state->root()) {
    LOG(ERROR)
        << "View tree attempted to set the root while one is already set: tree="
        << tree_state << ", root_key=" << root_key;
    UnregisterViewTree(tree_state);
    return;
  }

  // Set the root to a stub, pending resolution of the view owner.
  tree_state->LinkRoot(root_key, std::unique_ptr<ViewStub>(new ViewStub(
                                     this, root_view_owner.Pass())));
  UpdateViewTreeRootScene(tree_state);

  // Schedule layout of the tree on behalf of its newly added root.
  // We don't need to schedule layout of the root until the tree provides
  // new layout parameters.
  InvalidateLayoutForRoot(tree_state);
}

void ViewRegistry::ResetRoot(ViewTreeState* tree_state,
                             mojo::InterfaceRequest<mojo::ui::ViewOwner>
                                 transferred_view_owner_request) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "ResetRoot: tree=" << tree_state;

  // Ensure there is a root.
  if (!tree_state->root()) {
    LOG(ERROR)
        << "View tree attempted to reset the root but there is none: tree="
        << tree_state;
    UnregisterViewTree(tree_state);
    return;
  }

  // Unlink the root from its tree.
  TransferOrUnregisterViewStub(tree_state->UnlinkRoot(),
                               transferred_view_owner_request.Pass());
  UpdateViewTreeRootScene(tree_state);

  // Note: We don't need to schedule layout for the root since it will retain
  // its old layout parameters.  And there's no need to tell the tree
  // either since it won't have any work to do.  So we're done.
}

void ViewRegistry::LayoutRoot(ViewTreeState* tree_state,
                              mojo::ui::ViewLayoutParamsPtr root_layout_params,
                              const ViewLayoutCallback& callback) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DCHECK(root_layout_params);
  DCHECK(root_layout_params->constraints);
  DVLOG(1) << "LayoutRoot: tree=" << tree_state
           << ", root_layout_params=" << root_layout_params;

  // Check whether the layout parameters are well-formed.
  if (!AreViewLayoutParamsValid(root_layout_params.get())) {
    LOG(ERROR) << "View tree provided invalid root layout parameters: "
               << "tree=" << tree_state
               << ", root_layout_params=" << root_layout_params;
    UnregisterViewTree(tree_state);
    callback.Run(nullptr);
    return;
  }

  // Check whether the client called LayoutRoot without first having actually
  // set a root.
  if (!tree_state->root()) {
    LOG(ERROR) << "View tree attempted to layout the root without having "
                  "set one first: tree="
               << tree_state << ", root_layout_params=" << root_layout_params;
    UnregisterViewTree(tree_state);
    callback.Run(nullptr);
    return;
  }

  SetLayout(tree_state->root(), root_layout_params.Pass(), callback);
}

void ViewRegistry::ConnectToViewTreeService(
    ViewTreeState* tree_state,
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  associate_table_.ConnectToViewTreeService(
      tree_state->view_tree_token()->Clone(), service_name,
      client_handle.Pass());
}

ViewState* ViewRegistry::FindView(uint32_t view_token_value) {
  auto it = views_by_token_.find(view_token_value);
  return it != views_by_token_.end() ? it->second : nullptr;
}

ViewTreeState* ViewRegistry::FindViewTree(uint32_t view_tree_token_value) {
  auto it = view_trees_by_token_.find(view_tree_token_value);
  return it != view_trees_by_token_.end() ? it->second : nullptr;
}

void ViewRegistry::HijackView(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));

  ViewStub* view_stub = view_state->view_stub();
  if (view_stub)
    ReleaseViewStubAndNotify(view_stub);
}

void ViewRegistry::OnViewResolved(ViewStub* view_stub,
                                  mojo::ui::ViewTokenPtr view_token) {
  DCHECK(view_stub);

  ViewState* view_state = view_token ? FindView(view_token->value) : nullptr;
  if (view_state)
    AttachViewStubAndNotify(view_stub, view_state);
  else
    ReleaseViewStubAndNotify(view_stub);
}

void ViewRegistry::AttachViewStubAndNotify(ViewStub* view_stub,
                                           ViewState* view_state) {
  DCHECK(view_stub);

  view_state->ReleaseOwner();  // don't need the ViewOwner pipe anymore
  view_stub->AttachView(view_state);

  if (view_stub->pending_layout_request()) {
    view_state->pending_layout_requests().push_back(
        std::move(view_stub->pending_layout_request()));
    IssueNextViewLayoutRequest(view_state);
  }
}

void ViewRegistry::ReleaseViewStubAndNotify(ViewStub* view_stub) {
  DCHECK(view_stub);

  view_stub->ReleaseView();

  if (view_stub->parent())
    SendChildUnavailable(view_stub->parent(), view_stub->key());
  else if (view_stub->tree())
    SendRootUnavailable(view_stub->tree(), view_stub->key());

  // Note: We don't need to schedule layout for the previous owner.
  // We can simply wait for it to remove its unavailable child or root in
  // response to the notification at which point layout will occur.
  // We don't need to schedule layout for the child either since it will
  // retain its old layout parameters.
}

void ViewRegistry::TransferOrUnregisterViewStub(
    std::unique_ptr<ViewStub> view_stub,
    mojo::InterfaceRequest<mojo::ui::ViewOwner>
        transferred_view_owner_request) {
  DCHECK(view_stub);

  if (transferred_view_owner_request.is_pending()) {
    if (view_stub->state())
      view_stub->state()->BindOwner(transferred_view_owner_request.Pass());
    else if (view_stub->is_pending())
      CHECK(false);  // TODO(jeffbrown): Handle transfer of pending view
  } else {
    UnregisterViewStub(std::move(view_stub));
  }
}

void ViewRegistry::UnregisterViewStub(std::unique_ptr<ViewStub> view_stub) {
  DCHECK(view_stub);

  ViewState* view_state = view_stub->ReleaseView();
  if (view_state)
    UnregisterView(view_state);
}

void ViewRegistry::SetLayout(ViewStub* view_stub,
                             mojo::ui::ViewLayoutParamsPtr layout_params,
                             const ViewLayoutCallback& callback) {
  DCHECK(view_stub);
  DCHECK(AreViewLayoutParamsValid(layout_params.get()));

  // Immediately discard layout requests on unavailable views.
  if (view_stub->is_unavailable()) {
    callback.Run(nullptr);
    return;
  }

  // For pending views, only remember the most recent distinct layout request.
  if (view_stub->is_pending()) {
    if (!view_stub->pending_layout_request() ||
        !view_stub->pending_layout_request()->layout_params()->Equals(
            *layout_params)) {
      view_stub->pending_layout_request().reset(
          new ViewLayoutRequest(layout_params.Pass()));
    }
    view_stub->pending_layout_request()->AddCallback(callback);
    return;
  }

  // For actual views, maintain a queue of pending layout requests.
  ViewState* view_state = view_stub->state();
  DCHECK(view_state);
  DCHECK(!view_stub->pending_layout_request());

  // Check whether the currently cached layout parameters are the same
  // and we already have a result and we have no pending layout requests.
  if (view_state->pending_layout_requests().empty() &&
      view_state->layout_params() &&
      view_state->layout_params()->Equals(*layout_params)) {
    mojo::ui::ViewLayoutInfoPtr info = view_state->CreateLayoutInfo();
    if (info) {
      DVLOG(2) << "Layout cache hit";
      view_state->set_scene_changed_since_last_report(false);
      callback.Run(info.Pass());
      return;
    }
  }

  // Check whether the layout parameters are different from the most
  // recent pending layout request if we have one.
  if (view_state->pending_layout_requests().empty() ||
      !view_state->pending_layout_requests().back()->layout_params()->Equals(
          *layout_params)) {
    // Enqueue a new request for these parameters.
    EnqueueLayoutRequest(view_state, layout_params.Pass());
  }

  // Enlist ourselves into the callbacks for the pending request.
  view_state->pending_layout_requests().back()->AddCallback(callback);
  IssueNextViewLayoutRequest(view_state);
}

void ViewRegistry::EnqueueLayoutRequest(
    ViewState* view_state,
    mojo::ui::ViewLayoutParamsPtr layout_params) {
  DCHECK(view_state);
  DCHECK(AreViewLayoutParamsValid(layout_params.get()));

  // Drop the previous layout request if it hasn't been issued yet.
  // This may cause callbacks to be invoked will null information.
  if (!view_state->pending_layout_requests().empty() &&
      !view_state->pending_layout_requests().back()->issued())
    view_state->pending_layout_requests().pop_back();

  // Enqueue the new request.
  view_state->pending_layout_requests().emplace_back(
      std::unique_ptr<ViewLayoutRequest>(
          new ViewLayoutRequest(layout_params.Pass())));
}

void ViewRegistry::InvalidateLayout(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));

  // We can consider the layout request to have been satisfied if
  // there is already a pending layout request in the queue that has not
  // yet been issued (this is coalescing).  Otherwise we must manufacture
  // a new one based on the current layout parameters.
  if (view_state->layout_params() &&
      (view_state->pending_layout_requests().empty() ||
       view_state->pending_layout_requests().back()->issued())) {
    EnqueueLayoutRequest(view_state, view_state->layout_params()->Clone());
    IssueNextViewLayoutRequest(view_state);
  }
}

void ViewRegistry::InvalidateLayoutForChild(ViewState* parent_state,
                                            uint32_t child_key) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(parent_state->children().find(child_key) !=
         parent_state->children().end());

  parent_state->children_needing_layout().insert(child_key);
  InvalidateLayout(parent_state);
}

void ViewRegistry::InvalidateLayoutForRoot(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  if (!tree_state->layout_request_pending()) {
    tree_state->set_layout_request_pending(true);
    IssueNextViewTreeLayoutRequest(tree_state);
  }
}

void ViewRegistry::IssueNextViewLayoutRequest(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));

  if (view_state->pending_layout_requests().empty())
    return;

  ViewLayoutRequest* request =
      view_state->pending_layout_requests().front().get();
  if (request->issued())
    return;

  // TODO: Detect ANRs
  DVLOG(1) << "IssueNextViewLayoutRequest: view_state=" << view_state;
  view_state->view_listener()->OnLayout(
      request->layout_params()->Clone(),
      mojo::Array<uint32_t>::From(view_state->children_needing_layout()),
      base::Bind(&ViewRegistry::OnViewLayoutResult, base::Unretained(this),
                 view_state->GetWeakPtr()));
  view_state->children_needing_layout().clear();
  request->set_issued(true);
}

void ViewRegistry::IssueNextViewTreeLayoutRequest(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  if (!tree_state->layout_request_pending() ||
      tree_state->layout_request_issued())
    return;

  // TODO: Detect ANRs
  DVLOG(1) << "SendViewTreeLayoutRequest";
  tree_state->view_tree_listener()->OnLayout(
      base::Bind(&ViewRegistry::OnViewTreeLayoutResult, base::Unretained(this),
                 tree_state->GetWeakPtr()));
  tree_state->set_layout_request_pending(false);
  tree_state->set_layout_request_issued(true);
}

void ViewRegistry::OnViewLayoutResult(base::WeakPtr<ViewState> view_state_weak,
                                      mojo::ui::ViewLayoutResultPtr result) {
  DCHECK(result);

  ViewState* view_state = view_state_weak.get();
  if (!view_state)
    return;

  DCHECK(!view_state->pending_layout_requests().empty());
  DCHECK(view_state->pending_layout_requests().front()->issued());

  std::unique_ptr<ViewLayoutRequest> request(
      std::move(view_state->pending_layout_requests().front()));
  view_state->pending_layout_requests().erase(
      view_state->pending_layout_requests().begin());

  DVLOG(1) << "OnViewLayoutResult: view=" << view_state
           << ", params=" << *request->layout_params() << ", result=" << result;

  // Validate the layout info.
  if (!IsSizeInBounds(request->layout_params()->constraints.get(),
                      result->size.get())) {
    LOG(ERROR) << "View returned invalid size in its layout info: "
               << "view=" << view_state
               << ", params=" << *request->layout_params()
               << ", result=" << result;
    UnregisterView(view_state);
    return;
  }

  // Assume the parent or root will not see the new layout information if
  // there are no callbacks so we need to inform it when things change.
  const bool size_changed =
      !view_state->layout_result() ||
      !view_state->layout_result()->size->Equals(*result->size);
  const bool recurse =
      !request->has_callbacks() &&
      (size_changed || view_state->scene_changed_since_last_report());

  view_state->set_layout_params(request->TakeLayoutParams().Pass());
  view_state->set_layout_result(result.Pass());

  mojo::ui::ViewLayoutInfoPtr info = view_state->CreateLayoutInfo();
  if (info) {
    view_state->set_scene_changed_since_last_report(false);
    request->DispatchLayoutInfo(info.Pass());
  }

  if (recurse && view_state->view_stub()) {
    if (view_state->view_stub()->parent()) {
      InvalidateLayoutForChild(view_state->view_stub()->parent(),
                               view_state->view_stub()->key());
    } else if (view_state->view_stub()->tree()) {
      InvalidateLayoutForRoot(view_state->view_stub()->tree());
    }
  }

  if (view_state->view_stub()->is_root_of_tree() && size_changed)
    UpdateViewTreeRootScene(view_state->view_stub()->tree());

  IssueNextViewLayoutRequest(view_state);
}

void ViewRegistry::OnViewTreeLayoutResult(
    base::WeakPtr<ViewTreeState> tree_state_weak) {
  ViewTreeState* tree_state = tree_state_weak.get();
  if (tree_state) {
    DCHECK(tree_state->layout_request_issued());

    DVLOG(1) << "OnViewTreeLayoutResult";

    tree_state->set_layout_request_issued(false);
    IssueNextViewTreeLayoutRequest(tree_state);
  }
}

void ViewRegistry::UpdateViewTreeRootScene(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "UpdateViewTreeRootScene: tree_state=" << tree_state;

  if (!tree_state->renderer())
    return;

  if (tree_state->root()) {
    ViewState* root_state = tree_state->root()->state();
    if (root_state && root_state->scene_token() &&
        root_state->layout_result()) {
      // TODO(jeffbrown): Take the scene version from the layout parameters
      // once we've figured out that part of the layout protocol.
      mojo::Rect viewport;
      viewport.width = root_state->layout_result()->size->width;
      viewport.height = root_state->layout_result()->size->height;
      tree_state->renderer()->SetRootScene(
          tree_state->root()->state()->scene_token()->Clone(),
          mojo::gfx::composition::kSceneVersionNone, viewport.Clone());
      return;
    }
  }

  tree_state->renderer()->ResetRootScene();
}

void ViewRegistry::OnRendererDied(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "UpdateViewTreeRootScene: tree_state=" << tree_state;

  tree_state->set_renderer(nullptr);
  SendRendererDied(tree_state);
}

void ViewRegistry::SendChildUnavailable(ViewState* parent_state,
                                        uint32_t child_key) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));

  // TODO: Detect ANRs
  DVLOG(1) << "SendChildUnavailable: parent_state=" << parent_state
           << ", child_key=" << child_key;
  parent_state->view_listener()->OnChildUnavailable(
      child_key, base::Bind(&base::DoNothing));
}

void ViewRegistry::SendRootUnavailable(ViewTreeState* tree_state,
                                       uint32_t root_key) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  // TODO: Detect ANRs
  DVLOG(1) << "SendRootUnavailable: tree_state=" << tree_state
           << ", root_key=" << root_key;
  tree_state->view_tree_listener()->OnRootUnavailable(
      root_key, base::Bind(&base::DoNothing));
}

void ViewRegistry::SendRendererDied(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  // TODO: Detect ANRs
  DVLOG(1) << "SendRendererDied: tree_state=" << tree_state;
  tree_state->view_tree_listener()->OnRendererDied(
      base::Bind(&base::DoNothing));
}

}  // namespace view_manager
