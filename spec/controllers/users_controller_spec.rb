require 'rails_helper'

describe UsersController do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }

  context "when visitor is not signed in" do
  
    it "users#create will create a new User" do
      expect do
        post :create, params: {user: attributes_for(:user), profile: attributes_for(:profile, :with_attributes)}
      end.to change(User, :count).by(1)
    end

    it "users#show will not render for visitor" do
      get :show, params: {user_id: user.id}
      expect(response).to_not render_template :show
    end

  end

  context "when user is signed in" do

    before do
      request.cookies[:auth_token] = user.auth_token
    end

    it "renders the :show template" do
      get :show, params: {user_id: user.id}
      expect(response).to render_template :show
    end

    it "sets right variable for users#show" do
      get :show, params: {user_id: user.id}
      expect(assigns(:user)).to eq(user)
    end

  end

end