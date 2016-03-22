require 'rails_helper'

describe PostsController do

  let(:user) { create(:user) }
  let(:posts) { create(:post, author: user) }

  before :each do
    posts
    cookies[:auth_token] = user.auth_token
  end

  describe "POST #create" do

    it "builds a post for current user" do
      expect { post :create, post_body: posts.body
       }.to change { user.posts.count }.by(1)
    end 

    it "redirects to user timeline" do
      post :create, post_body: posts.body
      expect(response).to redirect_to user_timeline_path user
    end

    it "fails to create post with nil body" do
      expect { post :create, post_body: "" }.to change { user.posts.count }.by(0)
    end

  end

  describe "DELETE #destroy" do

    it "deletes a post from the user" do
      expect { delete :destroy, id: posts.id }.to change { user.posts.count }.by(-1)
    end

    it "redirects to user timeline" do
      delete :destroy, id: posts.id
      expect(response).to redirect_to user_timeline_path user
    end
  end

end