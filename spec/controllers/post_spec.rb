require 'rails_helper'

describe PostsController do
  describe 'POST #create' do
    it "creates a new post" do
      user = create(:user)
      user.regenerate_auth_token
      cookies["auth_token"] = user.auth_token
      post_attributes = attributes_for(:post)
      expect {
        post :create, params: { post: post_attributes, user_id: user.id }
      }.to change(Post, :count).by(1)
    end
  end
end
