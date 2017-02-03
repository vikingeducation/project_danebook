require 'rails_helper'

describe SessionsController do
  let(:user){ create(:user) }

  context '#create' do
    it 'sets an auth token cookie' do
      post :create, params: { email: user.email, password: user.password }
      user.reload
      expect(cookies[:auth_token]).to eq(user.auth_token)
    end

    it 'redirects to user timeline when successful' do
      post :create, params: { email: user.email, password: user.password }
      expect(response).to redirect_to user_timeline_path(user)
    end

    it 'redirects to root path when unsuccessful' do
      post :create, params: { email: user.email, password: '' }
      expect(response).to redirect_to root_path
    end
  end

  context '#destroy' do
    before do
      post :create, params: { email: user.email, password: user.password }
      delete :destroy
    end

    it 'redirects to root path when successful' do
      expect(response).to redirect_to root_path
    end

    it 'displays flash' do
      expect(flash[:success]).not_to be_nil
    end

    it 'deletes auth token cookie' do
      user.reload
      puts user.auth_token
      puts cookies[:auth_token]
      expect(request.cookies[:auth_token]).to be_nil
    end
  end




end