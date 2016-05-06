// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/bindings/synchronous_interface_ptr.h"
#include "services/js/test/echo_service.mojom-sync.h"
#include "services/js/test/js_application_test_base.h"

using mojo::String;

namespace js {
namespace {

class JSEchoTest : public test::JSApplicationTestBase {
 public:
  JSEchoTest() : JSApplicationTestBase() {}
  ~JSEchoTest() override {}

 protected:
  // ApplicationTestBase:
  void SetUp() override {
    ApplicationTestBase::SetUp();
    const std::string& url = JSAppURL("echo.js");
    mojo::ConnectToService(application_impl()->shell(), url,
                           GetSynchronousProxy(&echo_service_));
  }

  mojo::SynchronousInterfacePtr<mojo::EchoService> echo_service_;

 private:
  MOJO_DISALLOW_COPY_AND_ASSIGN(JSEchoTest);
};

class JSServiceProviderEchoTest : public test::JSApplicationTestBase {
 public:
  JSServiceProviderEchoTest() : JSApplicationTestBase() {}
  ~JSServiceProviderEchoTest() override {}

 protected:
  // ApplicationTestBase:
  void SetUp() override {
    ApplicationTestBase::SetUp();
    const std::string& url = JSAppURL("echo.js");
    application_impl()->shell()->ConnectToApplication(
        url, GetProxy(&echo_service_provider_), nullptr);
  }

  mojo::ServiceProviderPtr echo_service_provider_;

 private:
  MOJO_DISALLOW_COPY_AND_ASSIGN(JSServiceProviderEchoTest);
};

TEST_F(JSEchoTest, EchoString) {
  String foo;
  EXPECT_TRUE(echo_service_->EchoString("foo", &foo));
  EXPECT_EQ("foo", foo);
  echo_service_->Quit();
}

TEST_F(JSEchoTest, EchoEmptyString) {
  String empty;
  EXPECT_TRUE(echo_service_->EchoString("", &empty));
  EXPECT_EQ("", empty);
  echo_service_->Quit();
}

TEST_F(JSEchoTest, EchoNullString) {
  String null;
  EXPECT_TRUE(echo_service_->EchoString(nullptr, &null));
  EXPECT_TRUE(null.is_null());
  echo_service_->Quit();
}

// Verify that a JS app's ServiceProvider can request and provide services.
// This test exercises the same code paths as examples/js/share_echo.js.
TEST_F(JSEchoTest, ShareEchoService) {
  bool returned_value = false;
  EXPECT_TRUE(echo_service_->ShareEchoService(&returned_value));
  EXPECT_TRUE(returned_value);
  echo_service_->Quit();
}

} // namespace
} // namespace js
