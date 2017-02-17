require 'rails_helper'

describe "CommentsRequests" do

  let(:bob) { create(:user) }
  let(:profile) { build(:profile) }
  let(:a_post) { create(:post, author: bob) }
  let(:a_comment) { build(:comment) }

  before do
    bob.profile = profile
    post login_path, params: { email: bob.email, password: bob.password }
  end

  describe "POST #create" do

    context "valid params" do

      it "creates a new comment on a post" do
        # headers ensure "go_back" has request.referer
        expect{
          post comments_path, params: { post: a_post.id, comment: attributes_for(:comment) }, headers: { "HTTP_REFERER" => root_url }
        }.to change(Comment, :count).by(1)
      end

    end

    context "invalid params" do

      it "doesn't create a new comment on a post" do
        expect{
          post comments_path, params: { post: a_post.id, comment: attributes_for(:profile) }, headers: { "HTTP_REFERER" => root_url }
        }.to change(Comment, :count).by(0)
      end

    end

    it "creates a flash message" do
      post comments_path, params: { post: a_post.id, comment: attributes_for(:comment) }, headers: { "HTTP_REFERER" => root_url }
      expect(flash[:success]).to_not be_nil
    end

  end

  describe "DELETE #destroy" do

    before do
      a_comment.author = bob
      a_post.comments << a_comment
    end

    it "deletes a comment" do
      expect{
        delete comment_path(a_comment), headers: { "HTTP_REFERER" => root_url }
      }.to change(Comment, :count).by(-1)
    end

  end

end