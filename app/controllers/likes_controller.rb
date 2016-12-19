class LikesController < ApplicationController

  def create
    @post = Post.find_by_id(params[:post_id])
    @comment = Comment.find_by_id(params[:comment_id])
    @photo = Photo.find_by_id(params[:photo_id])
    if @post
      @user = @post.author
      @like = @post.likes.build(liker_id: current_user.id)
    elsif @comment
      @user = @comment.post.author
      @like = @comment.likes.build(liker_id: current_user.id)
    elsif @photo
      @user = @photo.owner
      @like = @photo.likes.build(liker_id: current_user.id)
    end
    if @like.save
      flash[:success] = "Likin' it!"
      redirect_to @user unless @photo
      redirect_to @photo if @photo
    else
      flash.now[:error] = "Dagnabbit! Something dun goofed."
      redirect_to @user unless @photo
      redirect_to @photo if @photo
    end
  end

  def destroy
    @post = Post.find_by_id(params[:post_id])
    @comment = Comment.find_by_id(params[:comment_id])
    @photo = Photo.find_by_id(params[:photo_id])
    if @post
      @user = @post.author
    elsif @comment
      @user = @comment.post.author
    elsif @photo
      @user = @photo.owner
    end
    @like = Like.find_by_id(params[:id])
    if @like.destroy
      flash[:success] = "Unlikin' it!"
      redirect_to @user unless @photo
      redirect_to @photo if @photo
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      redirect_to @user unless @photo
      redirect_to @photo if @photo
    end
  end

  private

  def likable_type
    request.path.split('/')[1].singularize.classify.constantize
  end

  def likable_id
    request.path.split('/')[2]
  end

end