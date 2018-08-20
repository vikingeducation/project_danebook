class LikesController < ApplicationController

  def create
    if Like.create(whitelisted_like_params)
      flash[:success] = "You liked that!"
    else
      flash[:danger] = "Unable to like"
    end
    redirect_back fallback_location: { action: 'index', controller: 'posts', id: whitelisted_like_params[:user_id] }
  end

  def destroy
    @like =  Like.find_by(user_id: whitelisted_like_params[:user_id], likable_id: whitelisted_like_params[:likable_id], likable_type: whitelisted_like_params[:likable_type])
    if @like.destroy
      flash[:success] = "You've 'Unliked' sucessfully"
    else
      flash[:danger] = "Unable to unlike"
    end
    redirect_back fallback_location: { action: 'index', controller: 'posts', id: whitelisted_like_params[:user_id] }
  end

  private

  def whitelisted_like_params
    params.require(:like).permit(:likable_id, :likable_type, :user_id)
  end


end
