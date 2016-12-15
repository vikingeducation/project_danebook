require 'rails_helper'

describe UsersController do
  describe "user auth" do
    let(:user) { create :user }
    before :each do
      request.cookies["auth_token"] = user.auth_token
    end
  end

  describe '#create' do
    context "valid data" do
      it "creates a new user record" do
        expect {
          process :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end
      it "redirects to the user page" do
        process :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to edit_user_profile_url(User.last)
      end
    end
    context "invalid data" do
      it "does not create a new user record" do
        user_attrs = build(:user, email: "").attributes
        expect {
          process :create, params: { user: user_attrs }
        }.to change(User, :count).by(0)
      end
      # if data is invalid, the controller will re-render the form. We don't test rendering.
    end
  end
end
