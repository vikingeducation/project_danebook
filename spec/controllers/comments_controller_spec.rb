require 'rails_helper'

describe CommentsController do
  let(:comment){ create(:comment) }

  describe "POST #create" do
    it "redirects back to the timeline" do
      post :create, :comment => attributes_for(:comment)
      expect(response).to redirect_to timeline_path(assigns(:user))
    end

    it "actually creates the user" do
      expect{
        post :create, user: attributes_for(:user)
      }.to change(User, :count).by(1)
    end
  end
end
