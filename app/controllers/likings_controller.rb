class LikingsController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    @activity.likes.create(user_id: current_user.id)
    redirect_to user_activities_path(@activity.author)
  end

  def destroy
    @liking = Liking.find(params[:id])
    @activity = @liking.likeable
    @liking.destroy
    redirect_to user_activities_path(@activity.author)
  end

end
