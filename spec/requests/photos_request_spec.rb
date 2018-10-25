require 'rails_helper'

describe "PhotosRequests" do

  describe "User Access" do

    let(:user){ create(:user) }
    let(:user_profile){ create(:profile, user_id: user.id) }
    let(:user_photo){ create(:photo, user_id: user.id) }
    let(:comment){ create(:comment, commentable_id: user_photo.id, commentable_type: 'Photo') }
    let(:another_user){ create(:user) }
    let(:another_profile){ create(:profile, user_id: another_user.id) }
    let(:another_photo){ create(:photo, user_id: another_user.id) }

    before :each do
      user
      user_profile
      another_user
      another_profile
      post session_path, params: { email: user.email, password: user.password }
    end

    describe 'GET #index' do

      it 'works as normal' do
        get user_photos_path(user)
        expect(response).to be_success
      end
      it 'for another user works as normal' do
        get user_photos_path(another_user)
        expect(response).to be_success
      end

    end

    describe 'GET #new' do

      it 'works as normal' do
        get new_user_photo_path(user)
        expect(response).to be_success
      end
      it 'it for another user redirects' do
        get new_user_photo_path(another_user)
        expect(response).not_to have_http_status(:redirect)
      end

    end

    describe 'GET #show' do

      it 'works as normal' do
        get user_photo_path(user, user_photo)
        expect(response).to be_success
      end
      it 'to view another users photo works as normal' do
        get user_photo_path(another_user, another_photo)
        expect(response).to be_success
      end

    end

    describe 'POST #create' do

      it 'actually creates a photo' do
        expect{ post user_photos_path(user), params: {
                                              photo: attributes_for(:photo)
                                              } }.to change(Photo, :count).by(1)
      end
      it 'redirects to show page when successful' do
        post user_photos_path(user), params: { photo: attributes_for(:photo) }
        expect(response).to have_http_status(:redirect)
      end

      it 'for another user redirects' do
        post user_photos_path(another_user), params: { photo: attributes_for(:photo) }
        expect(response).to have_http_status(:redirect)
      end

    end

    describe 'DELETE #destroy' do

      it 'actually destroys photo' do
        user_photo
        expect{ delete user_photo_path(user, user_photo) }.to change(Photo, :count).by(-1)
      end
      it 'creates flash message' do
        delete user_photo_path(user, user_photo)
        expect(flash[:success]).not_to be_nil
      end
      it 'redirects when successful' do
        delete user_photo_path(user, user_photo)
        expect(response).to have_http_status(:redirect)
      end

      it 'for another user does not delete photo' do
        another_photo
        expect{ delete user_photo_path(another_user, another_photo) }.to change(Photo, :count).by(0)
      end

      it 'for another user redirects' do
        delete user_photo_path(another_user, another_photo)
        expect(response).to have_http_status(:redirect)
      end
      it 'for another user creates a flash message' do
        delete user_photo_path(another_user, another_photo)
        expect(flash[:danger]).not_to be_nil
      end
    end


  end

end
