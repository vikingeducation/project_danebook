class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:likeable] == 'Post'
      @like = current_user.likes.build(likeable_id: params[:post_id], likeable_type: params[:likeable])
      @poster = Post.find(params[:post_id]).user
      if @like.save
        flash[:success] = "Post liked"
      else
        flash[:error] = "You've already liked that post'"
      end
      redirect_to user_profile_path(@poster)
    elsif params[:likeable] == 'Photo'
      @photo = Photo.find(params[:photo_id])
      @like = current_user.likes.build(likeable_id: params[:photo_id], likeable_type: params[:likeable])
      @poster = Photo.find(params[:photo_id]).user
      if @like.save
        flash[:success] = "Photo liked"
      else
        flash[:error] = "You've already liked that photo"
      end
      redirect_to photo_path(@photo)
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, likeable_id: params[:post_id], likeable_type: params[:likeable])
    @poster = Post.find(params[:post_id]).user
    if @like.destroy
      flash[:success] = "Unliked"
    else
      flash[:error] = "Couldn't unlike"
    end
    redirect_to user_profile_path(@poster)
  end

  private

end
