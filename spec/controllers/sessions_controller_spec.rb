require 'rails_helper'

describe SessionsController do

  let(:user){ create(:user) }

  describe "POST #create" do

    it "assigns in user" do
      post :create, email: user.email, password: user.password
      expect(assigns :user).to eq user
    end

    it "signs in the user" do
      post :create, email: user.email, password: user.password
      expect(controller.send(:signed_in_user?)).to eq true
    end

    it "redirects user to profile" do
      post :create, email: user.email, password: user.password
      expect(response).to redirect_to user_newsfeed_path(user)
    end

    it "doesn't sign in the user" do
      post :create, email: user.email, password: "Wrongpassword"
      expect(controller.send(:signed_in_user?)).to eq false
    end

    it "renders new page on failure" do
      post :create, email: user.email, password: "Wrongpassword"
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE #destroy" do

    before do
      cookies[:auth_token] = user.auth_token
    end

    it "signs user out" do
      delete :destroy
      expect(controller.send(:signed_in_user?)).to be false
    end

    it "redirects to the root path" do
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end
end