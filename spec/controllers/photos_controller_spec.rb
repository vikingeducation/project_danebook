require 'rails_helper'

describe PhotosController do
  # Have to stub out AWS uploading so nothing actually gets uploading in test.
  AWS.stub!
  let(:user) { create(:user) }
  let(:photo) { create(:photo, uploader: user) }
  before do
    allow(controller).to receive(:store_referer) { session[:referer] = root_path }
  end
  context '#destroy' do
    it 'should delete the photo if the current user is correct' do
      allow(controller).to receive(:current_user) { user }
      photo_id = photo.id
      user_id = user.id
      expect do
        post :destroy, user_id: user_id, id: photo_id
      end.to change(Photo, :count).by(-1)
    end

    it 'should not delete the photo if the current_user is not correct' do
      allow(controller).to receive(:current_user) { nil }
      photo_id = photo.id
      user_id = user.id
      expect do
        post :destroy, user_id: user_id, id: photo_id
      end.to change(Photo, :count).by(0)
    end
  end
end
