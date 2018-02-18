require 'rails_helper'

describe 'UsersRequests' do

  describe "POST #create" do

    it "redirects to about me of correct user after signup" do
      post users_path, params: { :user => attributes_for(:user),
                                 :profile_attributes => attributes_for(:profile) }
      user = User.first
      expect(response).to redirect_to user_path(user)
    end

    specify  "creates a new user" do
      expect{ post users_path, params: { :user => attributes_for(:user),
                                 :profile_attributes => attributes_for(:profile) } }.to change(User, :count).by(1)
    end

    specify "sets up auth token" do
      post users_path, params: { :user => attributes_for(:user),
                                 :profile_attributes => [attributes_for(:profile)] }
      expect(response.cookies["auth_token"]).to_not be_nil
    end

  end

end
