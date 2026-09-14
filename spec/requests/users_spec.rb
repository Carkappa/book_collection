require 'rails_helper'

RSpec.describe "/users", type: :request do
  let(:valid_attributes) { { username: "alice" } }

  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get edit_user_url(user)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "creates a new User" do
      expect {
        post users_url, params: { user: valid_attributes }
      }.to change(User, :count).by(1)
    end

    it "redirects to the created user" do
      post users_url, params: { user: valid_attributes }
      expect(response).to redirect_to(user_url(User.last))
    end
  end

  describe "PATCH /update" do
    it "updates the requested user" do
      user = User.create! valid_attributes
      patch user_url(user), params: { user: { username: "bob" } }
      expect(user.reload.username).to eq("bob")
    end

    it "redirects to the user" do
      user = User.create! valid_attributes
      patch user_url(user), params: { user: { username: "bob" } }
      expect(response).to redirect_to(user_url(user))
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
