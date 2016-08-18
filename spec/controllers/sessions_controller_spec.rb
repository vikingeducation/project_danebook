require 'rails_helper'
require 'pry'

describe SessionsController do 

  let(:user){ create(:user) }


  describe "POST #create" do 

    describe "sad path" do 
      before do 
        post :create, email: "", password: "" 
      end

      specify "no email fails login" do 
        expect(response).to redirect_to root_path
      end    

      specify "failing to sign in produces a flash error message" do 
        assert_equal flash[:error], "We couldn't sign you in" 
      end   
    end   

    describe "happy path" do 

      before do 
        user
        post :create, email: user.email, password: user.password 
      end

      specify "a user with an account can log in" do 
        expect(response).to redirect_to(user_timeline_path(user))
      end   

      specify "signing in produces a flash message" do 
        assert_equal flash[:success], "You've successfully signed in" 
      end      


      specify "the user's auth token is stored in a cookie upon sign in" do 
        expect(cookies[:auth_token]).not_to be_nil
      end

      specify "the current user instance variable is set upon sign in" do 

      end
    end

    specify "upon sign in, a user's auth token is regenerated" do 
      original_auth = user.auth_token
      post :create, email: user.email, password: user.password 
      expect(user.reload.auth_token).not_to eq(original_auth)
    end
  end


  describe "DELETE #destroy" do 

    before do # sign in user
      user
      post :create, email: user.email, password: user.password 
    end

    it "signs the user out" do
      delete :destroy, email: user.email, password: user.password
      expect(cookies[:auth_token]).to be_nil
    end

    it "produces a flash success message that says 'You've been signed out'" do 
      delete :destroy, email: user.email, password: user.password
      assert_equal flash[:success], "You've been signed out."
    end
  end
end


