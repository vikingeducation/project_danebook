require 'rails_helper'

describe "UsersRequests" do

  let(:bob) { create(:user) }
  let(:profile) {build(:profile)}

  before do
    bob.profile = profile
    post login_path, params: { email: bob.email, password: bob.password }
  end

  describe "GET #show" do
    it "works correctly" do
      get user_path(bob)
      expect(response).to be_success
    end
  end

  describe "POST #create" do

    it "redirects after creating the new user" do
      post users_path, params: { user: attributes_for(:user) }
      expect(response).to have_http_status(:redirect)
    end

    context "no user is logged in" do

      before do
        delete logout_path
      end

      it "creates a new user" do
        expect{
          post users_path, params: { user: attributes_for(:user, :diff_user)}
        }.to change(User, :count).by(1)
      end

      it "sets an auth token cookie" do
        post users_path, params: { user: attributes_for(:user, :diff_user) }
        expect(response.cookies["auth_token"]).to_not be_nil
      end

    end

    it "creates a flash message" do
      post users_path, params: { user: attributes_for(:user) }
      expect(flash[:success]).to_not be_nil
    end
  end

  describe "PATCH #update" do

    # 'nudge' to ensure 'bob' is persisted before proceeding... just in case
    before { bob }
    let(:updated_name) { "Stimpy" }

    it "correctly updates the user" do
      put user_path(bob), params: {
        user: attributes_for(:user, first_name: updated_name)
      }
      # reload to ensure 'bob' below is the just-now-updated version
      bob.reload
      expect(bob.first_name).to eq(updated_name)
    end

    it "redirects to the updated user's profile" do
      put user_path(bob), params: {
        user: attributes_for(:user, first_name: updated_name)
      }
      expect(response).to redirect_to user_profile_path(bob)
    end
  end

  describe "DELETE #destroy" do

    before { bob }

    it "destroys the user" do
      expect{
        delete user_path(bob)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the root" do
      delete user_path(bob)
      expect(response).to redirect_to root_url
    end
  end

end