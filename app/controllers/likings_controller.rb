class LikingsController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    @activity.likes.create(user_id: current_user.id)
    redirect_to user_activities_path(@activity.author)
  end

  def destroy
    @liking = Liking.find(params[:id])
    @activity = @liking.likeable
    @user = @liking.user
    if @user.id == current_user.id
      @liking.destroy
      redirect_to user_activities_path(@activity.author)
    else
      flash[:alert] = "You're not authorized to do this"
      redirect_to user_activities_path(@activity.author)
    end
  end

end
