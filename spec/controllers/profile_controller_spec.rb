require 'rails_helper'
require 'pry'


describe ProfilesController do

  let(:user){create(:user)}

  context 'logged in user' do
    before :each do
      cookies[:auth_token] = user.auth_token
    end

    describe 'GET #edit' do

      it 'signed in user can view their own edit page' do
        get :edit, { user_id: user.id}

        expect(response).to render_template :edit
      end

      it 'signed in user cannot view edit page of another user' do
        other_user = create(:user)
        get :edit, user_id: other_user.id

        expect(response).to redirect_to root_path
      end

      it 'should redirect to root path if user does not exist' do
        expect(get :edit, user_id: user.id + 1).to redirect_to root_path
      end
    end

    describe 'POST #update' do

      it 'should update profile with valid attributes' do
        profile = user.profile
        new_motto = "enjoy the journey"

        post :update, user_id: user.id,
                profile: attributes_for(:profile, motto: new_motto)

        profile.reload
        expect(profile.motto).to eq(new_motto)
      end

      it 'does not update a profile belonging to someone else' do
        another_user = create(:user)
        profile = another_user.profile
        new_motto = "don't touch this"

        post :update, user_id: another_user.id,
                profile: attributes_for(:profile, motto: new_motto)

        another_user.profile.reload
        expect(profile.motto).to_not eq(new_motto)
      end

    end
  end
end