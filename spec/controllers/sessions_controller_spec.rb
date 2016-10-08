require 'rails_helper'

describe SessionsController do

  let(:user) { create(:user) }
  let(:post_create_session) do
    post :create,
        :email => user.email,
        :password => user.password
  end

  before do
    user
  end

  context "when user is not signed in" do
    it 'GET #new is login page' do
      get :new

      expect(response).to render_template :new
    end

    it 'user submitting valid login credentials is logged in' do
      post_create_session
      expect(response).to redirect_to root_url
    end

    it 'sets the #current_user to the signed in user' do
      post_create_session
      expect(controller.send(:current_user)).to eq(user)
    end

    it 'user submitting invalid login credentials is not logged in' do
      new_email = user.email + "x"
      post :create, email: new_email, password: user.password
      expect(response).to render_template "sessions/new"
    end
  end

  context "when user is signed in" do
    before do
      request.cookies["auth_token"] = user.auth_token
      @user = user
    end

    it 'GET #new redirects to root url' do
      get :new
      expect(response).to redirect_to root_url
    end

    it 'signs the user out when the user was signed in' do
      delete :destroy
      expect(controller.send(:current_user)).to be_nil
    end
  end
end
