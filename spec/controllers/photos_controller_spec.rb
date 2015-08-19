require 'rails_helper'

describe PhotosController do


  describe 'GET#new' do

    let(:current_user) { create(:user) }

    before do
      request.cookies[:auth_token] = current_user.auth_token
    end

    it 'assigns @user' do
      get :new, :user_id => current_user
      expect(assigns(:user)).to eq(current_user)
    end

    it 'assigns @photo as a New Photo' do
      get :new, :user_id => current_user
      expect(assigns(:photo)).to be_a_new(Photo)
    end

  end


  describe 'POST#create' do

    let(:current_user) { create(:user) }
    let(:photo) { build(:photo) }

    before do
      request.cookies[:auth_token] = current_user.auth_token
      photo = create(:photo, :owner => current_user)
    end

    it do
      post :create, :user_id => current_user.id,
                    :photo => photo
      should permit(:photo).for(:create)
    end


  end


  describe 'GET#index' do

    let(:current_user) { create(:user) }

    before do
      request.cookies[:auth_token] = current_user.auth_token
    end


    it 'assigns @user' do
      get :index, :user_id => current_user
      expect(assigns(:user)).to eq(current_user)
    end

    xit 'assigns @photos collection' do
      get :index, :user_id => current_user
      expect(assigns(:photos)).to be_a_new(Photo)
    end

  end

end
