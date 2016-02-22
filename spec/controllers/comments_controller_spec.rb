require 'rails_helper'

describe CommentsController do

  let(:user) { create(:user) }
  let(:posts) { create(:post, author: user) }
  let(:comment) { create(:comment, author: user) }

  before :each do
    comment
    cookies[:auth_token] = user.auth_token
    request.env["HTTP_REFERER"] = user_timeline_path(user)
  end

  describe "POST #create" do

    it "creates a comment for it's parent" do
      expect { post :create, comment_body: "hello", commentable: "Post", post_id: posts.id }.to change { posts.comments.count }.by(1)
    end

    it "sets the current user as the author" do
      post :create, comment_body: "hello", commentable: "Post", post_id: posts.id
      expect(user).to eq posts.comments.last.author
    end

  end

  describe "DELETE #destroy" do

    it "destroys the comment" do
      expect { delete :destroy, id: comment.id }.to change { Comment.count }.by(-1)
    end
  end

end