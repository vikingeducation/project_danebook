require 'rails_helper'
require 'pry'


describe CommentsController do

  let(:user){create(:user)}

  before :each do
    cookies[:auth_token] = user.auth_token
    user.posts = create_list(:post, 1)
    @post= user.posts.first
    allow(controller).to receive(:store_referer).
                        and_return(session[:referer] = user_posts_path(user.id))
  end

  context 'logged in user' do

    describe 'POST #create' do

      it 'can create a comment with correct parameters' do

        expect do
          post :create, comment: attributes_for(:post_comment,
                        user_id:          user.id,
                        commentable_id:   @post.id,
                        commentable_type: "Post")

        end.to change(Comment, :count).by(1)

      end

      it 'redirects to index/refreshes after comment creation' do
        post :create, comment: attributes_for(:post_comment,
                        user_id:          user.id,
                        commentable_id:   @post.id,
                        commentable_type: "Post")
        expect(response).to redirect_to (user_posts_path(user.id))
      end

      it "can create a comment on another user's timeline" do
        another_user = create(:user)
        expect do
          post :create, comment: attributes_for(:post_comment,
                        user_id:          user.id,
                        commentable_id:   @post.id,
                        commentable_type: "Post")

        end.to change(Comment, :count).by(1)
      end

    end

    describe 'DELETE #destroy' do

      before :each do
        @comment = create(:post_comment, user: user)

        @another_user = create(:user)
        @comment2 = create(:post_comment, user: @another_user,
                        commentable_id:   @post.id,
                        commentable_type: "Post")
      end

      it 'can destroy their own comment' do
        expect do
          delete :destroy, user_id: user.id, id: @comment
        end.to change(Comment, :count).by(-1)
      end

      it "cannot destroy someone else's comment" do
        expect do
          delete :destroy, user_id: @another_user.id, id: @comment
        end.to change(Comment, :count).by(0)
      end

      it "can destroy your comment on someone else's timeline" do
        cookies[:auth_token] = @another_user.auth_token
        expect do
          delete :destroy, user_id: @another_user.id, id: @comment2
        end.to change(Comment, :count).by(-1)
      end
    end

  end
end