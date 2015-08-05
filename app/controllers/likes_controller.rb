class LikesController < ApplicationController
  before_action :store_referer
  before_action :require_logged_in_user
  def create
    if Like.create(likable: get_likable, user: current_user)
      flash[:success] = "Successfully liked!"
    else
      flash[:notice] = "ERROR: Unable to like."
    end
    redirect_to referer
  end

  def destroy
    like = Like.find_by(user_id: params[:user_id], likable_id: params[:likable_id], likable_type: params[:likable_type].capitalize)
    if like.destroy
      flash[:success] = "Succesfully unliked!"
    else
      flash[:notice] = "ERROR: Unable to unlike."
    end
    redirect_to referer
  end

  private
    def get_likable
      params[:likable_type].singularize.classify.constantize.find(params[:likable_id])
    end
end
