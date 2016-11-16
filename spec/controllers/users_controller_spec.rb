require 'rails_helper'

describe UsersController do

  describe "POST #create" do
    it "redirects to show page" do
      post :create, :user => attributes_for(:user)
      expect(response).to redirect_to user_path(assigns(:user))
    end

    it "actually creates the user" do
      expect{ post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
    end

    it "renders home page when provided invalid information" do
      post :create, :user => attributes_for(:user, email: "")
      expect(response).to render_template "static_pages/home"
    end
  end

  describe "GET #edit" do
    let(:user){ create(:user) }
    let(:profile){ create(:profile, user: user) }
    before do
      request.cookies["auth_token"] = user.auth_token
    end

    it "collects the user's profile" do
      get :edit, :id => user.id
      expect(assigns(:profile)).to eq(user.profile)
    end

    it "does not work if user is not authorized" do
      another_user = create(:user)
      get :edit, :id => another_user.id
      expect(flash[:error]).to_not be nil
      expect(response).to redirect_to root_path
    end
  end

  describe "PATCH #update" do
    let(:user){ create(:user) }
    let(:profile){ create(:profile, user: user) }
    before do
      request.cookies["auth_token"] = user.auth_token
      profile
    end

    it "updates the user's profile" do
      put :update, :id => user.id, :user => attributes_for(:user).merge(profile_attributes: attributes_for(:profile, college: "Foo University"))
      user.reload
      expect(user.profile.college).to eq("Foo University")
    end

  end
end