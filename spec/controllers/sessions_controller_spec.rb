require 'rails_helper'

describe SessionsController do

  let(:user) { create(:user) }

  describe 'Users can sign in' do

    describe 'sessions/create' do
      it 'redirects to users timeline page if provided correct attributes' do
        post :create, email: user.email, password: 'password'
        expect(response).to redirect_to user_timeline_path(user)
      end

      it 'redirects to root_url if provided invalid attributes' do
        post :create, email: user.email, password: 'badpass'
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'users can sign out' do
    describe 'sessions/destroy' do
      it 'redirects to root url' do
        request.cookies[:auth_token] = user.auth_token
        post :destroy
        expect(response).to redirect_to root_url
      end

      it 'flashes success' do
        request.cookies[:auth_token] = user.auth_token
        post :destroy
        expect(flash[:success]).to_not be_nil
      end
    end
  end
end
