require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:google_params) do
    { email: "admin@example.com", full_name: "Test Admin", uid: "123456", avatar_url: "https://example.com/avatar.png" }
  end

  describe ".from_google" do
    it "creates an admin from Google's account details" do
      admin = Admin.from_google(**google_params)
      expect(admin).to be_persisted
      expect(admin).to have_attributes(google_params)
    end

    it "finds the existing admin instead of creating a duplicate" do
      existing = Admin.from_google(**google_params)
      expect { Admin.from_google(**google_params) }.not_to change(Admin, :count)
      expect(Admin.from_google(**google_params)).to eq(existing)
    end
  end
end
