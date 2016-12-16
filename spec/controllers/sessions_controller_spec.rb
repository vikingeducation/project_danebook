require 'rails_helper'
# spec/controllers/users_controller_spec.rb

describe SessionsController do
  let(:profile){ create(:profile)}
  let(:user){ profile.user }

  before do
    user
  end

  describe 'GET #new' do
    context "has token" do

      before do
        user.regenerate_auth_token
        cookies[:token] = user.token
      end


      it "signs the user in and redirects" do
        process :new

        expect(session[:user_id]).to_not be_nil
        expect(response).to redirect_to(users_path)
      end

    end


    context "authenticated" do

      before do
        create_session(user)
      end


      it "redirects to the user index" do
        process :new
        expect(response).to redirect_to(users_path)
      end

    end
  end

  describe 'POST #create' do

    it "logs in a user with valid credentials" do
      process :create, params: {email: user.email, password: user.password}
      expect(session[:user_id]).to_not be_nil
      assert_response :redirect
    end

    it "does not log in a user with invalid credentials" do
      process :create, params: {email: user.email + "x", password: user.password}
      expect(session[:user_id]).to be_nil
      assert_response :success
    end

    it "flashes a danger method on invalid credentials" do
      process :create, params: {email: user.email + "x", password: user.password}
      expect(flash[:danger]).to_not be_nil
    end

  end

  describe 'POST #destroy' do
    before do
      create_session(user)
    end

    it "logs out a user and redirects to the homepage" do
      process :destroy

      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(signup_path)
    end

    it "flashes a message to inform the user" do
      process :destroy

      expect(flash[:success]).to_not be_nil
    end

  end



end
