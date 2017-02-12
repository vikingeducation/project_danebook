class LikesController < ApplicationController

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = Comment.find_by_id(params[:comment_id])
    @photo = Photo.find_by_id(params[:photo_id])
    if @post
      @user = @post.author
      @like = @post.likes.build(liker_id: current_user.id)
    elsif @comment
      commentable_thing = @comment.commentable
      if commentable_thing.is_a?(Post)
        @user = commentable_thing.author
      elsif commentable_thing.is_a?(Photo)
        @user = commentable_thing.owner
        @photo = commentable_thing
      end
      @like = @comment.likes.build(liker_id: current_user.id)
    elsif @photo
      @user = @photo.owner
      @like = @photo.likes.build(liker_id: current_user.id)
    end
    if @like.save
      flash[:success] = "Likin' it!"
      go_back
    else
      flash.now[:error] = "Dagnabbit! Something dun goofed."
      go_back
    end
  end

  def destroy
    @post = Post.find_by_id(params[:post_id])
    @comment = Comment.find_by_id(params[:comment_id])
    @photo = Photo.find_by_id(params[:photo_id])
    if @post
      @user = @post.author
    elsif @comment
      commentable_thing = @comment.commentable
      if commentable_thing.is_a?(Post)
        @user = commentable_thing.author
      elsif commentable_thing.is_a?(Photo)
        @user = commentable_thing.owner
        @photo = commentable_thing
      end
    elsif @photo
      @user = @photo.owner
    end
    @like = Like.find_by_id(params[:id])
    if @like.destroy
      flash[:success] = "Unlikin' it!"
      go_back
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      go_back
    end
  end

end