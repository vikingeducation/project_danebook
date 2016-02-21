require 'rails_helper.rb'

describe CommentsController do

  describe "Logged In User" do

    let(:user) { create(:user) }
    let(:profile) { create(:profile, user: user) }
    let(:new_post) { create(:post, user: user) }
    let(:new_comment) { create(:post_comment, commentable: new_post, user: user) }
    let(:user_2) { create(:user) }
    let(:profile_2) { create(:profile, user: user_2) }
    let(:new_post_2) { create(:post, user: user_2) }
    let(:new_comment_2) { create(:post_comment, commentable: new_post_2, user: user_2) }

    before do
      user
      profile
      new_post
      new_comment
      user_2
      profile_2
      new_post_2
      new_comment_2
      create_session(user)
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it "POST #create for current user" do
      post :create, {
        comment: attributes_for(
        :post_comment,
        commentable: new_post,
        user: user),
        commentable: "Post",
        post_id: new_post.id
      }
      expect(response).to redirect_to "where_i_came_from"
    end

    it "POST #create fails to create comment" do
      post :create, {
        comment: attributes_for(
        :post_comment,
        body: "",
        commentable: new_post,
        user: user),
        commentable: "Post",
        post_id: new_post.id
      }
      expect(response).to render_template "users/show"
    end

    it "DELETE #destroy for current user's comment" do
      delete :destroy, {
        commentable: "Post",
        post_id: new_post.id,
        id: new_comment.id
      }
      expect(flash[:success]).to eq "Comment deleted!"
      expect(response).to redirect_to "where_i_came_from"
    end

    it "DELETE #destroy for another user's comment" do
      delete :destroy, {
        commentable: "Post",
        post_id: new_post_2.id,
        id: new_comment_2.id
      }
      expect(flash[:danger]).to eq "Not authorized! This isn't your Comment!"
      expect(response).to redirect_to user_path(user)
    end

  end

end
