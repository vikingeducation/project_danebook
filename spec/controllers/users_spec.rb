require 'rails_helper'

describe UsersController do
  describe 'user access' do
    let(:user){ create(:user) }

    context "No user logged in" do

      it "GET #new works as normal" do
        get :new
        expect(response).to render_template :new
      end

      describe "POST #create" do
        it "redirects to the new user" do
          post :create, :user => attributes_for(:user)
          expect(response).to redirect_to user_path(assigns(:user))
        end

        it "actually creates the user" do
          expect{
            post :create, user: attributes_for(:user)
          }.to change(User, :count).by(1)
        end
      end

    end

    context "User logged in" do
      before :each do
        # request.cookies["auth_token"] = user.auth_token
        session[:user_id] = user.id
      end

      describe "GET #edit" do
        it "for this user works as normal" do
          get :edit, :id => user.id
          expect(assigns(user.id)).to render_template :edit
        end

        it "for another user denies access" do

          # make sure this user actually exists
          another_user = create(:user)
          get :edit, :id => another_user.id

          expect(response).to redirect_to root_url
        end
      end
    end
  end
end