require 'rails_helper'


describe SessionsController do


  describe 'POST #create' do

    let(:existing_user) { create(:user) }


    context 'when given valid login' do

      before do
        post :create, :email => existing_user.email, :password => existing_user.password
      end

      it 'assigns @user properly' do
        expect(assigns(:user)).to eq(existing_user)
      end

      it 'flashes success message' do
        expect(flash[:success]).to eq("You've successfully signed in!")
      end

      #it 'redirects to user timeline' do
      #  expect(response).to redirect_to user_posts_path(existing_user)
      #end

      it 'redirects to user newsfeed' do
        expect(response).to redirect_to user_newsfeed_path(existing_user)
      end

    end


    context 'when given invalid login' do

      before do
        post :create, :email => existing_user.email, :password => 'badpassword'
      end

      it 'flashes failure message' do
        expect(flash[:danger]).to eq("Sign in failed.  Please try again.")
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_path
      end

    end


  end


end