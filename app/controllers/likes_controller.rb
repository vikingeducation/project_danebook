class LikesController < ApplicationController

  def create
    @user = current_user
    @like = @user.likes.build(likeable_id: param_type_id, likeable_type: params[:likeable])
    if @like.save
      flash.notice = "Like added."
      redirect_back(fallback_location: current_user)
    else
      flash.notice = "Error. You've already liked this post."
      redirect_back(fallback_location: current_user)
    end
  end

  def destroy
    @like = Like.find(param_type_id)
    if @like.destroy
      flash.notice = "Unliked."
      redirect_back(fallback_location: current_user)
    else
      flash.notice = "Error. Still liking post."
      redirect_back(fallback_location: current_user)
    end
  end

  private

  def param_type_id
    params[:post_id] || params[:photo_id]
  end

end
