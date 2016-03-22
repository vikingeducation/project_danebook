require 'rails_helper'

describe LikesController do

  let(:user) { create(:user) }
  let(:comment) { create(:comment) }
  let(:posts) { create(:post) }
  let(:comment_like) { create(:comment_like, author: user) }

  before :each do
    cookies[:auth_token] = user.auth_token
    request.env["HTTP_REFERER"] = user_timeline_path(user)
  end

  describe "POST #create" do

    it "likes a parent resource" do
      expect { post :create, likeable: "Post", post_id: posts.id }.to change { posts.likes.count }.by 1
    end

    it "sets likes for current user" do
      post :create, likeable: "Comment", comment_id: comment.id
      expect(user).to eq comment.likes.last.author
    end

    it "redirects back to timeline" do
      post :create, likeable: "Comment", comment_id: comment.id
      expect(response).to redirect_to user_timeline_path user
    end

  end

  describe "DELETE #destroy" do

    before do
      comment_like
    end

    it "unlikes a resource" do
      expect { delete :destroy, id: comment_like.id, comment_id: comment_like.likeable.id }.to change { Like.count }.by -1
    end

  end

end