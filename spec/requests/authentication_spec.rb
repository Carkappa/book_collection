require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  describe "a visitor who is not signed in", :signed_out do
    it "is redirected from the home page to the login page" do
      get root_path
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "is redirected from the books page to the login page" do
      get books_path
      expect(response).to redirect_to(new_admin_session_path)
    end

    it "sees the login page with a Google button" do
      get new_admin_session_path
      expect(response).to be_successful
      expect(response.body).to include("You're Logged out! Log in to the Dashboard!!")
      expect(response.body).to include(%(action="#{admin_google_oauth2_omniauth_authorize_path}"))
    end
  end

  describe "signing in with Google", :signed_out do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        provider: "google_oauth2",
        uid: "123456",
        info: { email: "admin@example.com", name: "Test Admin", image: "https://example.com/avatar.png" }
      )
    end

    after do
      OmniAuth.config.mock_auth[:google_oauth2] = nil
      OmniAuth.config.test_mode = false
    end

    it "creates the admin and lands on the home page with a success message" do
      expect {
        get admin_google_oauth2_omniauth_callback_path
      }.to change(Admin, :count).by(1)
      expect(response).to redirect_to(root_path)

      follow_redirect!
      expect(response.body).to include("Successfully authenticated from Google account.")
    end

    it "returns to the login page when Google login fails" do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      get admin_google_oauth2_omniauth_callback_path
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  describe "a signed-in admin" do
    it "can see the home page with a Sign Out link" do
      get root_path
      expect(response).to be_successful
      expect(response.body).to include("You're logged in! Welcome to the Dashboard!")
      expect(response.body).to include(%(href="#{destroy_admin_session_path}"))
    end

    it "is sent to the login page after signing out" do
      get destroy_admin_session_path
      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
