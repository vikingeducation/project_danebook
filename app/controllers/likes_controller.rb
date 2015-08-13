class LikesController < ApplicationController
  before_action :store_referer
  before_action :require_logged_in_user
  def create
    if Like.create(likable_id: params[:likable_id], likable_type: params[:likable_type].capitalize, user: current_user).errors.any?
      flash[:notice] = "ERROR: Unable to like."
    else
      flash[:success] = "Successfully liked!"
    end
    redirect_to referer
  end

  def destroy
    like = Like.find_by(user_id: params[:user_id], likable_id: params[:likable_id], likable_type: params[:likable_type].capitalize)
    if like
      if like.destroy
        flash[:success] = "Succesfully unliked!"
      else
        flash[:notice] = "ERROR: Unable to unlike."
      end
    else
      flash[:notice] = "Could not unlike user, probably already unliked."
    end
    redirect_to referer
  end
end
