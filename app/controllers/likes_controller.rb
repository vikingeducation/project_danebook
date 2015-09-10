class LikesController < ApplicationController
  before_action :store_referer
  before_action :require_logged_in_user
  def create
    @likable_type = params[:likable_type].downcase
    @likable_id = params[:likable_id].to_i

    respond_to do |format|
      like = Like.create(likable_id: params[:likable_id], likable_type: params[:likable_type].capitalize, user: current_user)
      if like.errors.any?
        flash[:notice] = "ERROR: Unable to like."
      else
        flash[:success] = "Successfully liked!"
        @likable = like.likable
        @user = current_user
        format.js { }
      end
      format.html { redirect_to referer }
    end
  end

  def destroy
    like = Like.find_by(user_id: params[:user_id], likable_id: params[:likable_id], likable_type: params[:likable_type].capitalize)
    respond_to do |format|
      if like
        @likable = like.likable
        @likable_type = params[:likable_type].downcase
        @likable_id = params[:likable_id].to_i
        @user = current_user
        if like.destroy
          flash[:success] = "Succesfully unliked!"
          format.js { }

        else
          flash[:notice] = "ERROR: Unable to unlike."
        end
      else
        flash[:notice] = "Could not unlike user, probably already unliked."
      end
      format.html { redirect_to referer }
    end
  end
end
