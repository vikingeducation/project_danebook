class LikesController < ApplicationController

  def create
    #if its for a post
    if params[:post_id]
      @likeable = Post.find(params[:post_id])
      @user = @likeable.user
      @like = @likeable.likes.build(:user_id => current_user.id)
    #if its for a comment
    elsif params[:comment_id]
      @likeable = Comment.find(params[:comment_id])
      @like = @likeable.likes.build(:user_id => current_user.id)
      #if its for a photo
    else
      @likeable = Photo.find(params[:photo_id])
      @user = @likeable.user
      @like = @likeable.likes.build(:user_id => current_user.id)
    end
    @like.save
    respond_to do |format|
      format.js{}
      format.html do
        if params[:post_id]
          redirect_to user_posts_path(@user)
        elsif params[:comment_id] && @likeable.commentable_type == "Post"
          @user = @likeable.commentable.user
          redirect_to user_posts_path(@user)
        elsif params[:comment_id] && @likeable.commentable_type == "Photo"
          @photo = @likeable.commentable
          redirect_to photo_path(@likeable)
        else
          redirect_to photo_path(@likeable)
        end
      end
    end
  end

  def destroy
    #if its for a post
    if params[:post_id]
      @likeable = Post.find(params[:post_id])
      @user = @likeable.user
    #if its for a comment
    elsif params[:comment_id]
      @likeable = Comment.find(params[:comment_id])
    #if its for a photo
    else
      @likeable = Photo.find(params[:photo_id])
      @user = @likeable.user
    end
    @like = Like.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.js{}
      format.html do
        if params[:post_id] 
          redirect_to user_posts_path(@user)
        elsif params[:comment_id] && @likeable.commentable_type == "Post"
           @user = @likeable.commentable.user
           redirect_to user_posts_path(@user)
        elsif params[:comment_id] && @likeable.commentable_type == "Photo"
          @photo = @likeable.commentable
          redirect_to photo_path(@likeable)
        else
          redirect_to photo_path(@likeable)
        end 
      end
    end
  end

end