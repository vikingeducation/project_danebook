require 'rails_helper'
require 'pry'

describe 'UsersRequests' do

  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}

  before do
    user
    profile
  end

  describe "POST #create" do

    specify "creates a new user" do
      expect{ post users_path, params: { :user => attributes_for(:user),
                                         :profile_attributes => [attributes_for(:profile)] } }.to change(User, :count).by(1)
    end

    specify "redirects to about me page after signup" do
      post users_path, params: { :user => attributes_for(:user),
                                 :profile_attributes => [attributes_for(:profile)] }
      # request.cookies[:auth_token] = user.auth_token
      # post users_path, params: { user: attributes_for(:user), profile: attributes_for(:profile) }
      # expect(response.cookies[:auth_token]).to_not be_nil
      binding.pry
      expect(response).to redirect_to user_path(user)
    end

    specify "sets up auth token" do
      post users_path, params: { :user => attributes_for(:user),
                                 :profile_attributes => [attributes_for(:profile)] }
      expect(response.cookies["auth_token"]).to_not be_nil
    end

  end

end
