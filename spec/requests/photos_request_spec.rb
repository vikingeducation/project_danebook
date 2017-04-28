require 'rails_helper'

describe 'PhotosRequests' do
  let(:user){ create(:user, :with_profile)}
  describe 'GET #upload' do

    it 'redirects to photos index if not logged in' do
      get upload_user_photos_path(user)
      expect(response).to redirect_to user_photos_path(user)
    end

    context 'logged in' do
      before do
        login_as(user, scope: :user)
      end

      it 'redirects to photos index if is not current user' do
        friend = create(:user, :with_profile)
        get upload_user_photos_path(friend)
        expect(response).to redirect_to user_photos_path(friend)
      end

      it 'loads if logged in annd is current user' do
        get upload_user_photos_path(user)
        expect(response).to be_success
      end

    end

  end

  describe 'GET #index'
end
