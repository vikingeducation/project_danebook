require 'rails_helper'

describe SessionsController do

  let(:user){ create(:user) }

  context "when user is not signed in" do
    it 'GET #new is login page' do
      get :new

      expect(response).to render_template :new
    end

    it 'user submitting valid login credentials is logged in' do
      post :create, email: user.email, password: user.password

      expect(response).to redirect_to root_url
    end

    it 'user submitting invalid login credentials is not logged in' do
      new_email = user.email + "x"
      post :create, email: new_email, password: user.password
      expect(response).to render_template :new
    end
  end

  context "when user is signed in" do
    before do
      request.cookies["auth_token"] = user.auth_token
      @user = user
    end

    it 'GET #new redirects to root url' do
      get :new
      expect(response).to redirect_to user_timeline_path(user)
    end

    it 'DELETE #destroy logouts user' do
      delete :destroy
      expect(response.cookies["auth_token"]).to be_nil
    end
  end

end
