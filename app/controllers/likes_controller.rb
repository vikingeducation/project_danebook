class LikesController < ApplicationController

  def create
    #if its for a post
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @user = @post.user
      @like = @post.likes.build(:user_id => current_user.id)
    #if its for a comment
    else
      @comment = Comment.find(params[:comment_id])
      @user = @comment.post.user
      @like = @comment.likes.build(:user_id => current_user.id)
    end
    @like.save
    redirect_to user_posts_path(@user)
  end

  def destroy
    #if its for a post
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @user = @post.user
    #if its for a comment
    else
      @comment = Comment.find(params[:comment_id])
      @user = @comment.post.user
    end
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to user_posts_path(@user)
  end

end
