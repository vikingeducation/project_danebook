class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :likeable_set_up, only: [:create, :destroy]

  def create
    @like = current_user.likes.build(likeable_id: @id, likeable_type: params[:likeable])
    if @like.save
      flash[:success] = 'Post liked'
    else
      flash[:error] = "You've already liked that post"
    end
    redirect_to @redirect_path
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, likeable_id: @id, likeable_type: params[:likeable])
    if @like.destroy
      flash[:success] = "Unliked"
    else
      flash[:error] = "Couldn't unlike"
    end
    redirect_to @redirect_path
  end

  private

  def likeable_set_up
    if params[:likeable] == 'Post'
      @id = params[:post_id]
      @poster = Post.find(@id).user
      @redirect_path = user_profile_path(@poster)
    elsif params[:likeable] == 'Photo'
      @id = params[:photo_id]
      @post = Photo.find(@id)
      @redirect_path = photo_path(@post)
    end
  end

end
