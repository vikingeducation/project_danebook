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
                        :user_id => user.id,
                        :commentable_id => @post.id,
                        :commentable_type => "Post")

        end.to change(Comment, :count).by(1)

      end

      it 'redirects to index/refreshes after comment creation' do
        post :create, comment: attributes_for(:post_comment,
                        :user_id => user.id,
                        :commentable_id => @post.id,
                        :commentable_type => "Post")
        expect(response).to redirect_to (user_posts_path(user.id))
      end

      it "can create a comment on another user's timeline" do
        another_user = create(:user)
        expect do
          post :create, comment: attributes_for(:post_comment,
                        :user_id => another_user.id,
                        :commentable_id => @post.id,
                        :commentable_type => "Post")

        end.to change(Comment, :count).by(1)
      end

    end

    describe 'DELETE #destroy' do

      before :each do
        @comment = create(:post_comment, user: user)
      end

      it 'can destroy their own post' do
        expect do
          delete :destroy, user_id: user.id, id: @comment
        end.to change(Comment, :count).by(-1)
      end

      it "cannot create a post on another user's timeline" do
        another_user = create(:user)
        expect do
          delete :destroy, user_id: another_user.id, id: @comment
        end.to change(Comment, :count).by(0)
      end
    end

  end #end logged in context block
end