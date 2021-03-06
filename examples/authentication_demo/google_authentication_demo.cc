// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/logging.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/authentication/interfaces/authentication.mojom.h"

namespace examples {
namespace authentication {

class GoogleAuthApp : public mojo::ApplicationDelegate {
 public:
  GoogleAuthApp() {}

  ~GoogleAuthApp() override {}

  void Initialize(mojo::ApplicationImpl* app) override {
    DLOG(INFO) << "Connecting to authentication service...";
    mojo::ConnectToService(app->shell(), "mojo:authentication",
                           GetProxy(&authentication_service_));

    mojo::Array<mojo::String> scopes;
    scopes.push_back("profile");
    scopes.push_back("email");

    DLOG(INFO) << "Starting the device flow handshake...";
    authentication_service_->GetOAuth2DeviceCode(
        scopes.Pass(),
        base::Bind(&GoogleAuthApp::OnDeviceCode, base::Unretained(this)));
  }

 private:
  void OnDeviceCode(const mojo::String& url,
                    const mojo::String& device_code,
                    const mojo::String& user_code,
                    const mojo::String& error) {
    if (!error.is_null()) {
      DLOG(INFO) << "Error: " << error;
      mojo::RunLoop::current()->Quit();  // All done!
      return;
    }
    // Display the verification url and user code in system UI and ask the
    // user to authorize in a companion device
    DLOG(INFO) << "Verification Url: " << url;
    DLOG(INFO) << "Device Code: " << device_code;
    DLOG(INFO) << "User Code: " << user_code;
    DLOG(INFO) << "Waiting for user autorization on a secondary device...";

    // Poll and exchange the user authorization to a long lived token
    DLOG(INFO) << "...";
    AddAccount(device_code);
  }

  // Exchange device code to a refresh token, and persist the grant.
  void AddAccount(const std::string device_code) {
    authentication_service_->AddAccount(
        device_code,
        base::Bind(&GoogleAuthApp::OnAddAccount, base::Unretained(this)));
  }

  void OnAddAccount(const mojo::String& username, const mojo::String& error) {
    if (!error.is_null() || username.is_null()) {
      DLOG(INFO) << "Missing username or Error: " << error;
      mojo::RunLoop::current()->Quit();  // All done!
      return;
    }

    DLOG(INFO) << "Successfully registered user: " << username;
    DLOG(INFO) << "Fetching access token for user [" << username << "]...";
    FetchOAuth2AccessToken();
  }

  // Fetch a new access token for an existing user grant.
  void FetchOAuth2AccessToken() {
    authentication_service_->SelectAccount(
        true,
        base::Bind(&GoogleAuthApp::OnSelectAccount, base::Unretained(this)));
  }

  // Selects an existing user account for this app based on previous
  // authorization.
  void OnSelectAccount(const mojo::String& username,
                       const mojo::String& error) {
    if (!error.is_null()) {
      DLOG(INFO) << "Error: " << error;
      mojo::RunLoop::current()->Quit();  // All done!
      return;
    }

    DLOG(INFO) << "Selected <user> for this app: " << username;

    mojo::Array<mojo::String> scopes;
    scopes.push_back("profile");

    authentication_service_->GetOAuth2Token(
        username, scopes.Pass(),
        base::Bind(&GoogleAuthApp::OnGetOAuth2Token, base::Unretained(this)));
  }

  void OnGetOAuth2Token(const mojo::String& access_token,
                        const mojo::String& error) {
    if (!error.is_null()) {
      DLOG(INFO) << "Error: " << error;
      mojo::RunLoop::current()->Quit();  // All done!
      return;
    }

    if (access_token.is_null()) {
      DLOG(INFO) << "Unable to fetch access token, exiting!";
    } else {
      DLOG(INFO) << "Access Token: " << access_token;
    }
    mojo::RunLoop::current()->Quit();  // All done!
    return;
  }

  ::authentication::AuthenticationServicePtr authentication_service_;
};

}  // namespace authentication
}  // namespace examples

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<examples::authentication::GoogleAuthApp>(
          new examples::authentication::GoogleAuthApp()));
  return runner.Run(application_request);
}
