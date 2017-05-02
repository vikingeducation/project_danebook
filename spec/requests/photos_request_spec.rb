require 'rails_helper'

describe 'PhotosRequests' do
  let(:user){ create(:user, :with_profile)}
  let(:friend){ create(:user, :with_profile)}
  let(:image){ fixture_file_upload(Rails.root.join('spec/requests/medium_missing.png'), 'image/png')}
  let(:photo_upload){ post user_photos_path(user), params: { photo: { image: image}} }
  let(:friend_photo){ create(:photo, user: friend)}
  let(:photo){ create(:photo, user: user)}
  describe 'GET #new' do
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

      it 'loads if is current user' do
        get upload_user_photos_path(user)
        expect(response).to be_success
      end
    end
  end

  describe 'POST #create' do
    it 'redirects user if not logged in' do
      expect{ post user_photos_path(user) }.not_to change(Photo, :count)
      expect(response).to redirect_to user_photos_path(user)
    end
    context 'logged in' do
      before do
        login_as(user, scope: :user)
      end
      it 'creates a new photo' do
        expect{ photo_upload }.to change(Photo, :count).by(1)
      end
      it 'redirects user to all their photos' do
        photo_upload
        expect(response).to redirect_to user_photos_path(user)
      end
      it 'redirects to upload path if upload fails' do
        post user_photos_path(user)
        expect(response).to redirect_to upload_user_photos_path(user)
        expect(flash[:error]).not_to be_nil
      end

    end
  end

  describe 'GET #show' do
    it 'loads for logged out user' do
      create(:photo, user: user)
      get photo_path(Photo.first)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do

    it 'requires current user' do
      friend_photo
      expect{ delete photo_path(friend_photo) }.not_to change(Photo, :count)
      expect(response).to redirect_to new_user_path
    end

    context 'logged in' do
      before do
        login_as(user, scope: :user)
      end
      it 'destroys a user\'s photo' do
        photo
        expect{ delete photo_path(photo) }.to change(Photo, :count).by(-1)
      end
      it 'cannot destroy a friend\'s photo' do
        friend_photo
        expect{ delete photo_path(friend_photo)}.not_to change(Photo, :count)
        expect(response).to redirect_to photo_path(friend_photo)
      end
      it 'redirects user upon successful deletion' do
        delete photo_path(photo)
        expect(response).to redirect_to user_photos_path(user)
      end
    end
  end



end
