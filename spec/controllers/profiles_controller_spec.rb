require 'rails_helper.rb'

describe ProfilesController do

  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }

  before do
    user
    profile
  end

  describe "Visitor" do

    context "tries to visit a user's profile page" do
      it "GET #show for existing user" do
        get :show, id: profile.id
        expect(response).to render_template :show
      end
      it "GET #show for nonexistent user" do
        get :show, id: 0
        expect(response).to redirect_to signup_path
      end
    end

  end

  describe "Logged In User" do

    let(:user_2) { create(:user) }
    let(:profile_2) { create(:profile, user: user_2) }

    before do
      user_2
      profile_2
      create_session(user)
    end

    it "GET #show for nonexistent user" do
      get :show, id: 0
      expect(response).to redirect_to user_path(user)
    end

    context "tries to edit/update profile" do
      it "GET #edit for user's own profile" do
        get :edit, id: user.id
        expect(response).to render_template :edit
      end

      it "GET #edit for another user's profile" do
        get :edit, id: user_2.id
        expect(response).to redirect_to user_path(user)
      end

      it "PATCH #update for user's own profile" do
        patch :update, id: profile.id, profile: attributes_for(:profile, college: "Hogwarts")
        expect(response).to redirect_to profile_path(profile.id)
      end

      it "PATCH #update for another user's profile" do
        patch :update, id: profile_2.id, profile: attributes_for(:profile, college: "Hogwarts")
        expect(response).to redirect_to user_path(user)
      end
    end

  end

end
