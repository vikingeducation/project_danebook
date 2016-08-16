class LikingsController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    @activity.likes.create(user_id: current_user.id)
    redirect_to request.referer
  end

  def destroy
    @liking = Liking.find(params[:id])
    @activity = @liking.likeable
    @user = @liking.user
    if @user.id == current_user.id
      @liking.destroy
    else
      flash[:alert] = "You're not authorized to do this"
    end
    redirect_to request.referer
  end

end
