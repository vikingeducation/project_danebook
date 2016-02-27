require 'rails_helper'
require 'pry'


describe UsersController do

  let(:user){create(:user)}

  context '#create' do

    it 'should create a new User with proper parameters' do
      expect{post :create, user: attributes_for(:user)}.to change(User, :count).by(1)
    end

    it 'should not create a new User without all parameters' do
      expect{post :create, user: attributes_for(:user, first_name: nil)}.to change(User, :count).by(0)
    end
  end

  context 'logged in user' do
    before :each do
      cookies[:auth_token] = user.auth_token
    end

    it 'signed in user is redirected to post index page' do
      get :new
      expect(response).to redirect_to(user_posts_path(user.id))
    end

    it 'signed in user #show to redirect to timeline' do
      get :show, id: user.id
      expect(response).to redirect_to(user_posts_path(user.id))
    end


  end

end