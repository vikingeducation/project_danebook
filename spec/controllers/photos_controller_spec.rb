require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  
  let(:user) { create(:user) }
  let(:photo) { create(:photo, user_id: user.id) }
  
    it 'adds a photo' do
      expect{post :create, user_id: user_id, id: photo.id}.to change(Photo, :count).by(1)
    end

    it 'deletes a photo' do
      expect{post :delete, user_id: user_id, id: photo.id}.to change(Photo, :count).by(-1)
    end
  
end
