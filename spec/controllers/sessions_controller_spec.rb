require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    let(:profile){ create(:profile) }
    let(:user){ profile.user }
    let(:post){ create(:post) }
    it 'creates a new session' do
      process :create, method: :post, params: {:email => user.email, :password => user.password}
      expect(response).to redirect_to about_user_path(assigns(:user))
      expect(session[:flash]["flashes"]["success"]).to eq("You've successfully signed in")
    end

    it "create fails with wrong params" do
      process :create, method: :post, params: {:email => user.email, :password => "random"}
      expect(response).to redirect_to root_path
      expect(session[:flash]["flashes"]["danger"]).to eq("We couldn't sign you in")
    end
  end
  describe 'destroy' do
    let(:profile){ create(:profile) }
    let(:user){ profile.user }
    it "logout after login" do
      process :create, method: :post, params: {:email => user.email, :password => user.password}
      expect(response).to redirect_to about_user_path(assigns(:user))
      process :destroy, method: :delete
      expect(response).to redirect_to root_path
      expect(session[:flash]["flashes"]["success"]).to eq("You've successfully signed out")
    end

    it "logout without login" do
      process :destroy, method: :delete
      expect(response).to redirect_to root_path
      expect(session[:flash]["flashes"]["success"]).not_to eq("You've successfully signed out")
    end
  end
end
