class LikesController < ApplicationController

  def create
    #if its for a post
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @user = @post.user
      @like = @post.likes.build(:user_id => current_user.id)
    #if its for a comment
    elsif params[:comment_id]
      @comment = Comment.find(params[:comment_id])
      @like = @comment.likes.build(:user_id => current_user.id)
      #if its for a photo
    else
      @photo = Photo.find(params[:photo_id])
      @user = @photo.user
      @like = @photo.likes.build(:user_id => current_user.id)
    end
    @like.save
    if params[:post_id]
      redirect_to user_posts_path(@user)
    elsif params[:comment_id] && @comment.commentable_type == "Post"
      @user = @comment.commentable.user
      redirect_to user_posts_path(@user)
    elsif params[:comment_id] && @comment.commentable_type == "Photo"
      @photo = @comment.commentable
      redirect_to photo_path(@photo)
    else
      redirect_to photo_path(@photo)
    end
  end

  def destroy
    #if its for a post
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @user = @post.user
    #if its for a comment
    elsif params[:comment_id]
      @comment = Comment.find(params[:comment_id])
    #if its for a photo
    else
      @photo = Photo.find(params[:photo_id])
      @user = @photo.user
    end
    @like = Like.find(params[:id])
    @like.destroy
    if params[:post_id] 
      redirect_to user_posts_path(@user)
    elsif params[:comment_id] && @comment.commentable_type == "Post"
       @user = @comment.commentable.user
       redirect_to user_posts_path(@user)
    elsif params[:comment_id] && @comment.commentable_type == "Photo"
      @photo = @comment.commentable
      redirect_to photo_path(@photo)
    else
      redirect_to photo_path(@photo)
    end
  end

end
