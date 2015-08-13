require 'rails_helper'

include ActionDispatch::TestProcess
include UserAuth

RSpec.describe PhotosController, type: :controller do

  AWS.stub!
  let(:user) { create(:user) }
  let(:photo) { create(:photo, user: user) }
  before do
    sign_me_in(user)
  end

  describe "GET #index" do

    it "renders a page for a signed in visitor" do
      get :index, user_id: user.id
      expect(response).to render_template :index
    end

    it "redirects a visitor to login page" do
      sign_me_out
      get :index, user_id: user.id
      expect(response).to redirect_to(login_path)
    end

    it "returns a list of all photos" do
      photo_list = create_list(:photo, 20, user: user)
      get :index, user_id: user.id
      expect(assigns(:photos)).to match_array(photo_list)
    end

  end

  describe "GET #show" do

    it "renders a page for a signed in visitor" do
      get :show, id: photo.id
      expect(response).to render_template :show
    end

    it "redirects a visitor to login page" do
      sign_me_out
      get :show, id: photo.id
      expect(response).to redirect_to(login_path)
    end

    it "allows for new comments to be created" do
      get :show, id: photo.id
      expect(assigns(:comment)).to_not be nil
    end

  end

  describe 'DELETE #destroy' do

    it 'should delete a photo if the user owns the photo' do
      allow(controller).to receive(:current_user) { user }
      photo #lazy let
      expect do
        delete :destroy, id: photo.id
      end.to change(Photo, :count).by(-1)
    end

    it "shouldn't delete another user's photos" do
      allow(controller).to receive(:current_user) { nil }
      photo #lazy let
      expect do
        delete :destroy, id: photo.id
      end.to change(Photo, :count).by(0)
    end
  end
end
