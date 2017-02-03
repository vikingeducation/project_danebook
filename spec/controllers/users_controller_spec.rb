require 'rails_helper'

describe UsersController do
  let(:existing_user){ create(:user) }
  let(:other_user){ create(:user) }

  context 'new user' do
    it 'about page renders new user form' do
      get :about, { id: existing_user.id }
      expect(response).to redirect_to login_path
    end

    it 'create user object' do
      expect{ 
        post :create, params: { user: attributes_for(:user) }
      }.to change(User, :count).by(1)
    end
  end

  context 'signed in user' do
    before do
      cookies[:auth_token] = existing_user.auth_token
    end

    it 'redirects to user timeline if already signed in' do
      get :new
      expect(response).to redirect_to user_timeline_path(existing_user)
    end

    it 'cannot access edit form if unauthorized' do
      get :edit, { id: other_user.id }
      expect(response).to redirect_to root_path
    end

    it "can access their own edit form" do
      get :edit, { id: existing_user.id }
      expect(response).to be_success
    end

    # blergh
    it 'can update user profile upon submission' do
      # profile = build(:profile, :user => existing_user)
      # put :update, params: { 
      #                 user: { :profile => attributes_for(:profile) } 
      #                      }
    end

  end




end