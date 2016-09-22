require 'rails_helper'

describe UsersController do

  let(:user){ create(:user) }
  let(:micro_post){ create(:post) }
  let(:user2){ create(:user) }




  describe "GET #index" do 
    before do 
      request.cookies["auth_token"] = user.auth_token
    end
    it "returns a number of users from a search query" do 
      get :index, params: {search: ""}
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do 
    it "user#create will create a new User" do
      expect{post :create, params: { user: attributes_for(:user)}}.to change(User, :count).by(1)
      expect(response).to redirect_to user_profiles_path(User.last)
    end

   it "user#create with no attributes will not create a new User" do
      expect{post :create, params: {user: {email: "fail@gmail.com"}} }.to_not change(User, :count)
    end
  end

   describe "GET #edit" do 

      context "for signed in user" do
        before do
          request.cookies["auth_token"] = user.auth_token
        end

        it "authorized user has access to user#edit for own edit" do
          get :edit, params: {id: user.id}
          expect(response).to render_template :edit
        end

        it "authorized user sets right instance variable for edit" do
          get :edit, params: {id: user.id}
          expect(assigns(:user)).to eq(user)
        end
      end
    end
  end