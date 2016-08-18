require 'rails_helper'

describe CommentsController do
let(:new_post){ create(:post) }
let(:user){ create(:user) }
  before do
    request.cookies["auth_token"] = user.auth_token
    new_post
  end

  describe "POST #create" do
    it "creates a new comment" do
      expect{ post :create, params:{ post_id: new_post.id, comment: attributes_for(:comment)} }.to change(Comment, :count).by(1)
    end

    it "redirects to timeline" do
      post :create, params:{ post_id: new_post.id, comment: attributes_for(:comment) }
      expect(response).to redirect_to user_posts_path(new_post.user)
    end
  end

  describe "DELETE #destroy" do
    let(:new_comment){ create(:comment, post: new_post) }
    before do
     new_comment
    end

    it "deletes a comment" do
      expect{ delete :destroy, params:{ id: new_comment.id, post_id: new_post.id } }.to change(Comment, :count).by(-1)
    end

    it "redirects to timeline" do
      delete :destroy, params:{ id: new_comment.id,  post_id: new_post.id }
      expect(response).to redirect_to user_posts_path(new_post.user)
    end
  end

end