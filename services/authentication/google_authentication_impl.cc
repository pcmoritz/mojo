// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/authentication/google_authentication_impl.h"

#include "base/json/json_reader.h"
#include "base/json/json_writer.h"
#include "base/message_loop/message_loop.h"
#include "base/strings/string_piece.h"
#include "base/strings/string_split.h"
#include "base/strings/string_tokenizer.h"
#include "base/strings/string_util.h"
#include "base/strings/stringprintf.h"
#include "base/synchronization/waitable_event.h"
#include "base/threading/platform_thread.h"
#include "base/trace_event/trace_event.h"
#include "base/values.h"
#include "mojo/common/binding_set.h"
#include "mojo/data_pipe_utils/data_pipe_drainer.h"
#include "mojo/data_pipe_utils/data_pipe_utils.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/network/interfaces/url_loader.mojom.h"
#include "services/authentication/credentials_impl_db.mojom.h"

namespace authentication {

// Mojo Shell OAuth2 Client configuration.
// TODO: These should be retrieved from a secure storage or a configuration file
// in the future.
char kMojoShellOAuth2ClientId[] =
    "962611923869-3avg0b4vlisgjhin0l98dgp6d8sd634r.apps.googleusercontent.com";
char kMojoShellOAuth2ClientSecret[] = "41IxvPPAt1HyRoYw2hO84dRI";

// Query params used in Google OAuth2 handshake
char kOAuth2ClientIdParamName[] = "client_id";
char kOAuth2ClientSecretParamName[] = "client_secret";
char kOAuth2ScopeParamName[] = "scope";
char kOAuth2GrantTypeParamName[] = "grant_type";
char kOAuth2CodeParamName[] = "code";
char kOAuth2RefreshTokenParamName[] = "refresh_token";
char kOAuth2DeviceFlowGrantType[] = "http://oauth.net/grant_type/device/1.0";
char kOAuth2RefreshTokenGrantType[] = "refresh_token";

// TODO(ukode) : Verify the char list
char kEscapableUrlParamChars[] = ".$[]/";

std::string EncodeParam(std::string param) {
  for (size_t i = 0; i < strlen(kEscapableUrlParamChars); ++i) {
    base::ReplaceSubstringsAfterOffset(
        &param, 0, std::string(1, kEscapableUrlParamChars[i]),
        base::StringPrintf("%%%x", kEscapableUrlParamChars[i]));
  }
  return param;
}

mojo::String BuildUrlQuery(mojo::Map<mojo::String, mojo::String> params) {
  std::string message;
  for (auto it = params.begin(); it != params.end(); ++it) {
    message += EncodeParam(it.GetKey()) + "=" + EncodeParam(it.GetValue());
    message += "&";
  }

  if (!message.empty()) {
    message = message.substr(0, message.size() - 1);  // Trims extra "&".
  }
  return message;
}

static base::DictionaryValue* ParseOAuth2Response(const std::string& response) {
  if (response.empty()) {
    return nullptr;
  }

  scoped_ptr<base::Value> root(base::JSONReader::Read(response));
  if (!root || !root->IsType(base::Value::TYPE_DICTIONARY)) {
    LOG(ERROR) << "Unexpected json response:" << std::endl << response;
    return nullptr;
  }

  return static_cast<base::DictionaryValue*>(root.release());
}

GoogleAuthenticationServiceImpl::GoogleAuthenticationServiceImpl(
    mojo::InterfaceRequest<AuthenticationService> request,
    const mojo::String app_url,
    mojo::NetworkServicePtr& network_service,
    mojo::files::DirectoryPtr& directory)
    : binding_(this, request.Pass()),
      app_url_(app_url),
      network_service_(network_service) {
  accounts_db_manager_ = new AccountsDbManager(directory.Pass());
}

GoogleAuthenticationServiceImpl::~GoogleAuthenticationServiceImpl() {
  delete accounts_db_manager_;
}

void GoogleAuthenticationServiceImpl::GetOAuth2Token(
    const mojo::String& username,
    mojo::Array<mojo::String> scopes,
    const GetOAuth2TokenCallback& callback) {
  if (!accounts_db_manager_->isValid()) {
    callback.Run(nullptr, "Accounts db validation failed.");
    return;
  }

  authentication::CredentialsPtr creds =
      accounts_db_manager_->GetCredentials(username);

  if (!creds->token) {
    callback.Run(nullptr, "User grant not found");
    return;
  }

  // TODO: Scopes are not used with the scoped refresh tokens. When we start
  // supporting full login scoped tokens, then the scopes here gets used for
  // Sidescoping.
  mojo::Map<mojo::String, mojo::String> params;
  params[kOAuth2ClientIdParamName] = kMojoShellOAuth2ClientId;
  params[kOAuth2ClientSecretParamName] = kMojoShellOAuth2ClientSecret;
  params[kOAuth2GrantTypeParamName] = kOAuth2RefreshTokenGrantType;
  params[kOAuth2RefreshTokenParamName] = creds->token;

  Request("https://www.googleapis.com/oauth2/v3/token", "POST",
          BuildUrlQuery(params.Pass()),
          base::Bind(&GoogleAuthenticationServiceImpl::OnGetOAuth2Token,
                     base::Unretained(this), callback));
}

void GoogleAuthenticationServiceImpl::SelectAccount(
    bool returnLastSelected,
    const SelectAccountCallback& callback) {
  if (!accounts_db_manager_->isValid()) {
    callback.Run(nullptr, "Accounts db validation failed.");
    return;
  }

  mojo::String username;
  if (returnLastSelected) {
    username = accounts_db_manager_->GetAuthorizedUserForApp(app_url_);
    if (!username.is_null()) {
      callback.Run(username, nullptr);
      return;
    }
  }

  // TODO(ukode): Select one among the list of accounts using an AccountPicker
  // UI instead of the first account always.
  mojo::Array<mojo::String> users = accounts_db_manager_->GetAllUsers();
  if (!users.size()) {
    callback.Run(nullptr, "No user accounts found.");
    return;
  }

  username = users[0];
  accounts_db_manager_->UpdateAuthorization(app_url_, username);
  callback.Run(username, nullptr);
}

void GoogleAuthenticationServiceImpl::ClearOAuth2Token(
    const mojo::String& token) {}

void GoogleAuthenticationServiceImpl::GetOAuth2DeviceCode(
    mojo::Array<mojo::String> scopes,
    const GetOAuth2DeviceCodeCallback& callback) {
  std::string scopes_str("email");
  for (size_t i = 0; i < scopes.size(); i++) {
    scopes_str += " ";
    scopes_str += std::string(scopes[i].data());
  }

  mojo::Map<mojo::String, mojo::String> params;
  params[kOAuth2ClientIdParamName] = kMojoShellOAuth2ClientId;
  params[kOAuth2ScopeParamName] = scopes_str;

  Request("https://accounts.google.com/o/oauth2/device/code", "POST",
          BuildUrlQuery(params.Pass()),
          base::Bind(&GoogleAuthenticationServiceImpl::OnGetOAuth2DeviceCode,
                     base::Unretained(this), callback));
}

void GoogleAuthenticationServiceImpl::AddAccount(
    const mojo::String& device_code,
    const AddAccountCallback& callback) {
  // Resets the poll count to "1"
  AddAccountInternal(device_code, 1, callback);
}

void GoogleAuthenticationServiceImpl::AddAccountInternal(
    const mojo::String& device_code,
    const uint32_t num_poll_attempts,
    const AddAccountCallback& callback) {
  mojo::Map<mojo::String, mojo::String> params;
  params[kOAuth2ClientIdParamName] = kMojoShellOAuth2ClientId;
  params[kOAuth2ClientSecretParamName] = kMojoShellOAuth2ClientSecret;
  params[kOAuth2GrantTypeParamName] = kOAuth2DeviceFlowGrantType;
  params[kOAuth2CodeParamName] = device_code;

  Request("https://www.googleapis.com/oauth2/v3/token", "POST",
          BuildUrlQuery(params.Pass()),
          base::Bind(&GoogleAuthenticationServiceImpl::OnAddAccount,
                     base::Unretained(this), callback, device_code,
                     num_poll_attempts));
}

void GoogleAuthenticationServiceImpl::OnGetOAuth2Token(
    const GetOAuth2TokenCallback& callback,
    const std::string& response,
    const std::string& error) {
  if (response.empty()) {
    callback.Run(nullptr, "Error from server:" + error);
    return;
  }

  scoped_ptr<base::DictionaryValue> dict(ParseOAuth2Response(response.c_str()));
  if (!dict.get() || dict->HasKey("error")) {
    callback.Run(nullptr, "Error in parsing response:" + response);
    return;
  }

  std::string access_token;
  dict->GetString("access_token", &access_token);

  callback.Run(access_token, nullptr);
}

void GoogleAuthenticationServiceImpl::OnGetOAuth2DeviceCode(
    const GetOAuth2DeviceCodeCallback& callback,
    const std::string& response,
    const std::string& error) {
  if (response.empty()) {
    callback.Run(nullptr, nullptr, nullptr, "Error from server:" + error);
    return;
  }

  scoped_ptr<base::DictionaryValue> dict(ParseOAuth2Response(response.c_str()));
  if (!dict.get() || dict->HasKey("error")) {
    callback.Run(nullptr, nullptr, nullptr,
                 "Error in parsing response:" + response);
    return;
  }

  std::string url;
  std::string device_code;
  std::string user_code;
  dict->GetString("verification_url", &url);
  dict->GetString("device_code", &device_code);
  dict->GetString("user_code", &user_code);

  callback.Run(url, device_code, user_code, nullptr);
}

void GoogleAuthenticationServiceImpl::GetTokenInfo(
    const std::string& access_token) {
  std::string url("https://www.googleapis.com/oauth2/v1/tokeninfo");
  url += "?access_token=" + EncodeParam(access_token);

  Request(url, "GET", "",
          base::Bind(&GoogleAuthenticationServiceImpl::OnGetTokenInfo,
                     base::Unretained(this)));
}

void GoogleAuthenticationServiceImpl::OnGetTokenInfo(
    const std::string& response,
    const std::string& error) {
  if (response.empty()) {
    return;
  }

  scoped_ptr<base::DictionaryValue> dict(ParseOAuth2Response(response.c_str()));
  if (!dict.get() || dict->HasKey("error")) {
    return;
  }

  // This field is only present if the profile scope was present in the
  // request. The value of this field is an immutable identifier for the
  // logged-in user, and may be used when creating and managing user
  // sessions in your application.
  dict->GetString("user_id", &user_id_);
  dict->GetString("email", &email_);
  // The space-delimited set of scopes that the user consented to.
  dict->GetString("scope", &scope_);
  return;
}

void GoogleAuthenticationServiceImpl::GetUserInfo(const std::string& id_token) {
  std::string url("https://www.googleapis.com/oauth2/v1/tokeninfo");
  url += "?id_token=" + EncodeParam(id_token);

  Request(url, "GET", "",
          base::Bind(&GoogleAuthenticationServiceImpl::OnGetUserInfo,
                     base::Unretained(this)));
}

void GoogleAuthenticationServiceImpl::OnGetUserInfo(const std::string& response,
                                                    const std::string& error) {
  if (response.empty()) {
    return;
  }

  scoped_ptr<base::DictionaryValue> dict(ParseOAuth2Response(response.c_str()));
  if (!dict.get() || dict->HasKey("error")) {
    return;
  }

  // This field is only present if the email scope was requested
  dict->GetString("email", &email_);
}

void GoogleAuthenticationServiceImpl::OnAddAccount(
    const AddAccountCallback& callback,
    const mojo::String& device_code,
    const uint32_t num_poll_attempts,
    const std::string& response,
    const std::string& error) {
  if (response.empty()) {
    callback.Run(nullptr, "Error from server:" + error);
    return;
  }

  if (!response.empty() && error.empty()) {
    scoped_ptr<base::Value> root(base::JSONReader::Read(response));
    if (!root || !root->IsType(base::Value::TYPE_DICTIONARY)) {
      callback.Run(response, nullptr);
      return;
    }
  }

  // Parse response and fetch refresh, access and idtokens
  scoped_ptr<base::DictionaryValue> dict(ParseOAuth2Response(response.c_str()));
  std::string error_code;
  if (!dict.get()) {
    callback.Run(nullptr, "Error in parsing response:" + response);
    return;
  } else if (dict->HasKey("error") && dict->GetString("error", &error_code)) {
    if (error_code != "authorization_pending") {
      callback.Run(nullptr, "Server error:" + response);
      return;
    }

    if (num_poll_attempts > 15) {
      callback.Run(nullptr, "Timed out after max number of polling attempts");
      return;
    }

    // Rate limit by waiting 7 seconds before polling for a new grant
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE,
        base::Bind(&GoogleAuthenticationServiceImpl::AddAccountInternal,
                   base::Unretained(this), device_code, num_poll_attempts + 1,
                   callback),
        base::TimeDelta::FromMilliseconds(7000));
    return;
  }

  // Poll success, after detecting user grant.
  std::string access_token;
  dict->GetString("access_token", &access_token);
  GetTokenInfo(access_token);  // gets scope, email and user_id

  if (email_.empty()) {
    std::string id_token;
    dict->GetString("id_token", &id_token);
    GetUserInfo(id_token);  // gets user's email
  }

  // TODO(ukode): Store access token in cache for the duration set in
  // response
  if (!accounts_db_manager_->isValid()) {
    callback.Run(nullptr, "Accounts db validation failed.");
    return;
  }

  std::string refresh_token;
  dict->GetString("refresh_token", &refresh_token);
  authentication::CredentialsPtr creds = authentication::Credentials::New();
  creds->token = refresh_token;
  creds->scopes = scope_;
  creds->auth_provider = AuthProvider::GOOGLE;
  creds->credential_type = CredentialType::DOWNSCOPED_OAUTH_REFRESH_TOKEN;
  std::string username = email_.empty() ? user_id_ : email_;
  accounts_db_manager_->UpdateCredentials(username, creds.Pass());

  callback.Run(username, nullptr);
}

void GoogleAuthenticationServiceImpl::Request(
    const std::string& url,
    const std::string& method,
    const std::string& message,
    const mojo::Callback<void(std::string, std::string)>& callback) {
  Request(url, method, message, callback, nullptr, 0);
}

void GoogleAuthenticationServiceImpl::Request(
    const std::string& url,
    const std::string& method,
    const std::string& message,
    const mojo::Callback<void(std::string, std::string)>& callback,
    const mojo::String& device_code,
    const uint32_t num_poll_attempts) {
  mojo::URLRequestPtr request(mojo::URLRequest::New());
  request->url = url;
  request->method = method;
  request->auto_follow_redirects = true;

  // Add headers
  auto content_type_header = mojo::HttpHeader::New();
  content_type_header->name = "Content-Type";
  content_type_header->value = "application/x-www-form-urlencoded";
  request->headers.push_back(content_type_header.Pass());

  if (!message.empty()) {
    request->body.push_back(
        mojo::common::WriteStringToConsumerHandle(message).Pass());
  }

  mojo::URLLoaderPtr url_loader;
  network_service_->CreateURLLoader(GetProxy(&url_loader));

  url_loader->Start(
      request.Pass(),
      base::Bind(&GoogleAuthenticationServiceImpl::HandleServerResponse,
                 base::Unretained(this), callback, device_code,
                 num_poll_attempts));

  url_loader.WaitForIncomingResponse();
}

void GoogleAuthenticationServiceImpl::HandleServerResponse(
    const mojo::Callback<void(std::string, std::string)>& callback,
    const mojo::String& device_code,
    const uint32_t num_poll_attempts,
    mojo::URLResponsePtr response) {
  if (response.is_null()) {
    LOG(WARNING) << "Something went horribly wrong...exiting!!";
    callback.Run("", "Empty response");
    return;
  }

  if (response->error) {
    LOG(ERROR) << "Got error (" << response->error->code
               << "), reason: " << response->error->description.get().c_str();
    callback.Run("", response->error->description.get().c_str());
    return;
  }

  std::string response_body;
  mojo::common::BlockingCopyToString(response->body.Pass(), &response_body);

  callback.Run(response_body, "");
}

}  // authentication namespace
