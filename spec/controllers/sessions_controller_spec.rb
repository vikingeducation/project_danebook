require 'rails_helper'
require 'pry'

describe SessionsController do

    let(:user){create :user}
 
  describe 'POST #create' do

    it 'redirects to user profile' do
      assigns(:user)
      post :create, profile: attributes_for(:profile)
      expect(response).to redirect_to user_profile_path(:user_id => assigns(:user))
    end
  end

  describe 'POST #delete' do

    it 'redirects to sign_up page' do
      post :delete, profile: attributes_for(:profile)
      expect(response).to redirect_to root_path
    end

  end

end