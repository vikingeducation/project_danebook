require 'rails_helper'

describe 'ProfilesRequests' do

  let(:user){ create(:user) }
  let(:another_user){ create(:user) }

  describe 'User Access' do

    describe 'GET #show' do

      it 'works as normal if signed in' do
        profile = create(:profile, user_id: user.id)
        post session_path, params: { email: user.email, password: user.password }
        get user_profile_path(user)
        expect(response).to be_success
      end

    end

    describe 'GET #edit' do

      before :each do
        profile = create(:profile, user_id: user.id)
        post session_path, params: { email: user.email, password: user.password }
      end

      it 'works as normal when logged in' do
        get edit_user_profile_path(user)
        expect(response).to be_success
      end

      it 'for another user redirects to owns profile to edit' do
        other_user = create(:user)
        get edit_user_profile_path(other_user)
        expect(response).to have_http_status(:redirect)
      end

    end

  end

  describe 'Non-User Access' do

    describe 'GET #show' do

      before :each do
        get user_profile_path(user)
      end

      it 'is not successful' do
        expect(response).to_not be_success
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'creates flash message' do
        expect(flash[:danger]).to_not be_nil
      end
    end

    describe 'GET #edit' do
      before :each do
        get edit_user_profile_path(user)
      end

      it 'is not successful' do
        expect(response).to_not be_success
      end

      it 'redirects to root_path' do
        expect(response).to redirect_to root_path
      end

      it 'creates flash message' do
        expect(flash[:danger]).to_not be_nil
      end
    end
  end

end
