require 'rails_helper'

describe SessionsController do
  let(:user){ create(:user) }

  describe "POST #create" do
    it "creates a session cookie" do
      post :create, params: { email: user.email, password: user.password }
      expect(cookies["auth_token"]).to_not be_nil
    end

    it "redirects after logging in" do
      post :create, params: { email: user.email, password: user.password }
      expect(response.status).to eql(302)
    end

    it "won't let you sign in with a bad password" do
      post :create, params: { email: user.email, password: "naughtyPassword" }
      expect(cookies["auth_token"]).to be_nil
    end

    it "returns you home if can't log in" do
      post :create, params: { email: user.email, password: "naughtyPassword" }
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE #destroy" do
    it "removes the auth token cookie" do
      delete :destroy
      expect(cookies["auth_token"]).to be_nil
    end

    it "returns you home after log out" do
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end

end
