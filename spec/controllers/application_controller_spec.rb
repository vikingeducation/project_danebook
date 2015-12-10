require 'rails_helper'

describe ApplicationController do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}

  controller do
    before_action :require_login, :only => [:index]
    before_action :require_current_user, :only => [:show]
    before_action :require_logout, :only => [:new]

    def index
      render :text => 'Index'
    end

    def show
      render :text => 'Show'
    end

    def new
      render :text => 'New'
    end
  end

  before do
    controller.send(:sign_in, user)
  end

  describe '#current_user' do
    it 'returns the user currently signed in' do
      expect(controller.send(:current_user)).to eq(user)
    end

    it 'returns nil if there is no user signed in' do
      controller.send(:sign_out)
      expect(controller.send(:current_user)).to be_nil
    end
  end

  describe '#signed_in_user?' do
    it 'returns true when there is a user signed in' do
      expect(controller.send(:signed_in_user?)).to eq(true)
    end

    it 'returns false when there is not a user signed in' do
      controller.send(:sign_out)
      expect(controller.send(:signed_in_user?)).to eq(false)
    end
  end

  describe '#sign_in' do
    it 'signs in the given user' do
      expect(controller.send(:current_user)).to eq(user)
    end

    it 'sets a cookie for the user auth token' do
      expect(cookies[:auth_token]).to eq(user.auth_token)
    end
  end

  describe '#remember_sign_in' do
    it 'signs in the given user' do
      controller.send(:sign_out)
      controller.send(:remember_sign_in, user)
      expect(controller.send(:current_user)).to eq(user)
    end
  end

  describe '#sign_out' do
    before do
      controller.send(:sign_out)
    end

    it 'it signs out the current user' do
      expect(controller.send(:signed_in_user?)).to eq(false)
    end

    it 'deletes the auth token from cookies' do
      expect(cookies[:auth_token]).to be_nil
    end
  end

  describe '#require_login' do
    it 'does nothing if the user is signed in' do
      get :index
      expect(response).to_not redirect_to root_path
    end

    it 'redirects to root path if the user is not signed in' do
      controller.send(:sign_out)
      get :index
      expect(response).to redirect_to root_path
    end
  end

  describe '#require_logout' do
    it 'does nothing if the user is signed out' do
      controller.send(:sign_out)
      get :new
      expect(response).to_not redirect_to root_path
    end

    it 'redirects to the user posts path if the user is signed in' do
      get :new
      expect(response).to redirect_to user_posts_path(user)
    end
  end

  describe '#require_current_user' do
    it 'does nothing if the user is authorized' do
      get :show, :id => user.id
      expect(response).to redirect_to root_path
    end

    it 'redirects to root if the user is not authorized' do
      get :show, :id => '1234'
      expect(response).to redirect_to root_path
    end
  end

  describe '#redirect_to_referer' do
    it 'redirects to the referer when set'
    it 'redirects to root path when there is no referer'
  end
end




