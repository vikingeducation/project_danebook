require 'rails_helper'

describe PhotosController do
let(:user){ create(:user) }
#let(:photo){ create(:photo, user: user) }

  before do
    request.cookies["auth_token"] = user.auth_token
  end

  describe "POST #create" do
    it "creates a new photo" do
      expect{ post :create, params: { user_id: user.id, photo: attributes_for(:photo)} }.to change(Photo, :count).by(1)
    end

    it "redirects to photos page" do
      post :create, params: { user_id: user.id, photo: attributes_for(:photo)}
      expect(response).to redirect_to user_photos_path(user)
    end
  end

end
