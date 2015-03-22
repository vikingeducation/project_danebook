require 'rails_helper'

describe UsersController do

  context 'guest access' do
    describe 'GET #new' do
      it 'assigns a new user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'builds a new profile' do
        get :new
        expect(assigns(:profile)).to be_a_new(Profile)
      end

    end
  end


  context 'user logged in' do
    before(:each) do
      @current_user = FactoryGirl.create(:user)
      session[:auth_token] = @current_user.auth_token
    end


  end





end