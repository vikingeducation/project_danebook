require 'rails_helper'

RSpec.describe ProfilePhotosController, type: :controller do

  describe 'PATCH #update' do

    let(:new_photo) { create(:photo) }

    before do
      request.cookies[:auth_token] = new_photo.owner.auth_token
      patch :update, :photo_id => new_photo.id, :user_id => new_photo.owner
    end


    it 'assigns @user' do
      expect(assigns(:user)).to eq(new_photo.owner)
    end

    it 'assigns @photo' do
      expect(assigns(:photo)).to eq(new_photo)
    end

    it 'saves the new photo ID as profile_photo_id' do
      new_photo.reload
      expect(new_photo.owner.profile_photo).to eq(new_photo)
    end

    it 'redirects to user show page' do
      expect(response).to redirect_to(user_path(new_photo.owner))
    end


  end

end
