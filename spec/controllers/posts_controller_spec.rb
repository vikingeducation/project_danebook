require 'rails_helper'

describe PostsController do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }

  context "when visitor is not signed in" do

    it "posts#create will not create a new Post" do
      expect{post :create, params: {user_id: user.id, post: attributes_for(:post)}}.to change(Post, :count).by(0)
    end

  end

  context "when user is signed in" do

    before do
      request.cookies[:auth_token] = user.auth_token
    end

    it "posts#create will create a new Post" do
      expect{post :create, params: {user_id: user.id, post: attributes_for(:post)}}.to change(Post, :count).by(1)
    end

  end

end