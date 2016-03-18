// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_REGISTRY_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_REGISTRY_H_

#include <string>
#include <unordered_map>

#include "base/macros.h"
#include "mojo/services/gfx/composition/interfaces/compositor.mojom.h"
#include "mojo/services/ui/views/interfaces/view_associates.mojom.h"
#include "mojo/services/ui/views/interfaces/view_trees.mojom.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"
#include "services/ui/view_manager/view_associate_table.h"
#include "services/ui/view_manager/view_layout_request.h"
#include "services/ui/view_manager/view_state.h"
#include "services/ui/view_manager/view_stub.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

// Maintains a registry of the state of all views.
// All ViewState objects are owned by the registry.
class ViewRegistry : public mojo::ui::ViewInspector {
 public:
  using AssociateConnectionErrorCallback =
      ViewAssociateTable::AssociateConnectionErrorCallback;

  explicit ViewRegistry(mojo::gfx::composition::CompositorPtr compositor);
  ~ViewRegistry() override;

  // Begins connecting to the view associates.
  // Invokes |connection_error_callback| if an associate connection fails
  // and provides the associate's url.
  void ConnectAssociates(
      mojo::ApplicationImpl* app_impl,
      const std::vector<std::string>& urls,
      const AssociateConnectionErrorCallback& connection_error_callback);

  // VIEW MANAGER REQUESTS

  // Creates a view and returns its ViewToken.
  void CreateView(
      mojo::InterfaceRequest<mojo::ui::View> view_request,
      mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
      mojo::ui::ViewListenerPtr view_listener,
      const mojo::String& label);

  // Creates a view tree.
  void CreateViewTree(
      mojo::InterfaceRequest<mojo::ui::ViewTree> view_tree_request,
      mojo::ui::ViewTreeListenerPtr view_tree_listener,
      const mojo::String& label);

  // VIEW STUB REQUESTS

  void OnViewResolved(ViewStub* view_stub, mojo::ui::ViewTokenPtr view_token);

  // VIEW REQUESTS

  // Creates a scene for the view, replacing its current scene.
  // Destroys |view_state| if an error occurs.
  void CreateScene(ViewState* view_state,
                   mojo::InterfaceRequest<mojo::gfx::composition::Scene> scene);

  // Requests layout.
  // Destroys |view_state| if an error occurs.
  void RequestLayout(ViewState* view_state);

  // Adds a child, reparenting it if necessary.
  // Destroys |parent_state| if an error occurs.
  void AddChild(ViewState* parent_state,
                uint32_t child_key,
                mojo::InterfaceHandle<mojo::ui::ViewOwner> child_view_owner);

  // Removes a child.
  // Destroys |parent_state| if an error occurs.
  void RemoveChild(ViewState* parent_state,
                   uint32_t child_key,
                   mojo::InterfaceRequest<mojo::ui::ViewOwner>
                       transferred_view_owner_request);

  // Lays out a child and optionally provides its size.
  // Destroys |parent_state| if an error occurs.
  void LayoutChild(ViewState* parent_state,
                   uint32_t child_key,
                   mojo::ui::ViewLayoutParamsPtr child_layout_params,
                   const ViewLayoutCallback& callback);

  // Connects to a view service.
  // Destroys |view_state| if an error occurs.
  void ConnectToViewService(ViewState* view_state,
                            const mojo::String& service_name,
                            mojo::ScopedMessagePipeHandle client_handle);

  // Called when one of the view pipes is closed remotely.
  void OnViewDied(ViewState* view_state, const std::string& reason);

  // VIEW TREE REQUESTS

  // Sets the view tree's renderer.
  // Destroys |tree_state| if an error occurs.
  void SetRenderer(ViewTreeState* tree_state,
                   mojo::gfx::composition::RendererPtr renderer);

  // Requests layout.
  // Destroys |tree_state| if an error occurs.
  void RequestLayout(ViewTreeState* tree_state);

  // Sets the root of the view tree.
  // Destroys |tree_state| if an error occurs.
  void AddChild(ViewTreeState* tree_state,
                uint32_t child_key,
                mojo::InterfaceHandle<mojo::ui::ViewOwner> child_view_owner);

  // Removes the root of the view tree.
  // Destroys |tree_state| if an error occurs.
  void RemoveChild(ViewTreeState* tree_state,
                   uint32_t child_key,
                   mojo::InterfaceRequest<mojo::ui::ViewOwner>
                       transferred_view_owner_request);

  // Lays out a view tree's root and optionally provides its size.
  // Destroys |tree_state| if an error occurs.
  void LayoutChild(ViewTreeState* tree_state,
                   uint32_t child_key,
                   mojo::ui::ViewLayoutParamsPtr child_layout_params,
                   const ViewLayoutCallback& callback);

  // Connects to a view service.
  // Destroys |view_state| if an error occurs.
  void ConnectToViewTreeService(ViewTreeState* tree_state,
                                const mojo::String& service_name,
                                mojo::ScopedMessagePipeHandle client_handle);

  // Called when one of the view tree pipes is closed remotely.
  void OnViewTreeDied(ViewTreeState* tree_state, const std::string& reason);

  // VIEW INSPECTOR REQUESTS

  void GetHitTester(mojo::ui::ViewTreeTokenPtr view_tree_token,
                    mojo::InterfaceRequest<mojo::gfx::composition::HitTester>
                        hit_tester_request,
                    const GetHitTesterCallback& callback) override;

  void ResolveScenes(
      mojo::Array<mojo::gfx::composition::SceneTokenPtr> scene_tokens,
      const ResolveScenesCallback& callback) override;

 private:
  // LIFETIME

  void UnregisterView(ViewState* view_state);
  void UnregisterViewTree(ViewTreeState* tree_state);

  // TREE MANIPULATION

  ViewState* FindView(uint32_t view_token_value);
  ViewTreeState* FindViewTree(uint32_t view_tree_token_value);

  void HijackView(ViewState* view_state);

  void AttachViewStubAndNotify(ViewStub* view_stub, ViewState* view_state);
  void ReleaseViewStubAndNotify(ViewStub* view_stub);
  void TransferOrUnregisterViewStub(std::unique_ptr<ViewStub> view_stub,
                                    mojo::InterfaceRequest<mojo::ui::ViewOwner>
                                        transferred_view_owner_request);
  void UnregisterViewStub(std::unique_ptr<ViewStub> view_stub);

  void OnViewAttached(base::WeakPtr<ViewStub> view_stub_weak,
                      mojo::gfx::composition::SceneTokenPtr scene_token);

  // LAYOUT

  void SetLayout(ViewStub* view_stub,
                 mojo::ui::ViewLayoutParamsPtr layout_params,
                 const ViewLayoutCallback& callback);
  void EnqueueLayoutRequest(ViewState* view_state,
                            mojo::ui::ViewLayoutParamsPtr layout_params);
  void InvalidateLayout(ViewState* view_state);
  void InvalidateLayoutForChild(ViewState* parent_state, uint32_t child_key);
  void InvalidateLayoutForRoot(ViewTreeState* tree_state);

  void IssueNextViewLayoutRequest(ViewState* view_state);
  void IssueNextViewTreeLayoutRequest(ViewTreeState* tree_state);
  void OnViewLayoutResult(base::WeakPtr<ViewState> view_state_weak,
                          mojo::ui::ViewLayoutResultPtr result);
  void OnViewTreeLayoutResult(base::WeakPtr<ViewTreeState> tree_state_weak);

  // SCENE MANAGEMENT

  void OnSceneCreated(base::WeakPtr<ViewState> view_state_weak,
                      mojo::gfx::composition::SceneTokenPtr scene_token);
  void PublishStubScene(ViewState* view_state);

  // RENDERING

  void UpdateViewTreeRootScene(ViewTreeState* view_tree);
  void OnRendererDied(ViewTreeState* view_tree);

  // SIGNALING

  void SendChildAttached(ViewContainerState* container_state,
                         uint32_t child_key,
                         mojo::ui::ViewInfoPtr child_view_info);
  void SendChildUnavailable(ViewContainerState* container_state,
                            uint32_t child_key);
  void SendRendererDied(ViewTreeState* tree_state);

  bool IsViewStateRegisteredDebug(ViewState* view_state) {
    return view_state && FindView(view_state->view_token()->value);
  }

  bool IsViewTreeStateRegisteredDebug(ViewTreeState* tree_state) {
    return tree_state && FindViewTree(tree_state->view_tree_token()->value);
  }

  mojo::gfx::composition::CompositorPtr compositor_;
  ViewAssociateTable associate_table_;

  uint32_t next_view_token_value_ = 1u;
  uint32_t next_view_tree_token_value_ = 1u;
  std::unordered_map<uint32_t, ViewState*> views_by_token_;
  std::unordered_map<uint32_t, ViewState*> views_by_scene_token_;
  std::unordered_map<uint32_t, ViewTreeState*> view_trees_by_token_;

  DISALLOW_COPY_AND_ASSIGN(ViewRegistry);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_REGISTRY_H_
