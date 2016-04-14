require 'rails_helper'



describe SessionsController do

  let(:user) { create(:user) }


  describe 'POST#create' do

    it "sets permanent cookie for remember_me" do
      user
      post :create, email: user.email, password: user.password, remember_me: 1

      expect(cookies.permanent[:auth_token]).to_not be nil
    end

  end


  describe "DELETE#destroy" do

    it 'logs the user out with flash message' do
      user
      post :create, email: user.email, password: user.password

      delete :destroy
      expect(flash["success"]).to_not be nil
      expect(cookies[:auth_token]).to be nil
    end


    it "redirects to root path" do
      user
      post :create, email: user.email, password: user.password

      delete :destroy
      expect(response).to redirect_to root_path
    end

  end

end