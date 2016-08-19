require 'rails_helper'

describe ProfilesController do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }

  context "when visitor is not signed in" do
  
    it "profiles#show will not render for visitor" do
      get :show, params: {user_id: user.id}
      expect(response).to_not render_template :show
    end

    it "profiles#edit will not render for visitor" do
      get :edit, params: {user_id: user.id}
      expect(response).to_not render_template :edit
    end

    it "will not update the profile" do
      put :update, params: {user: attributes_for(:user), profile: attributes_for(:profile, hometown: "Tokyo")}
      profile.reload
      expect(profile.hometown).to_not eq("Tokyo")
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

    it "sets right variable for profiles#show" do
      get :show, params: {user_id: user.id}
      expect(assigns(:user)).to eq(user)
    end

    it "renders the :edit template" do
      get :edit, params: {user: user}
      expect(response).to render_template :edit
    end

    it "sets right variable for profiles#edit" do
      get :edit, params: {user: user}
      expect(assigns(:profile)).to eq(user.profile)
    end

    it "can successfully update the profile" do
      put :update, params: {user: attributes_for(:user), profile: attributes_for(:profile, hometown: "Tokyo")}
      profile.reload
      expect(profile.hometown).to eq("Tokyo")
    end

  end

end