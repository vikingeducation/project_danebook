class ActivitiesController < ApplicationController

  def index
    @post = Post.new
    @user = User.find(params[:user_id])
    @activities = @user.activities.order(id: :desc)
  end

  def destroy
    @activity = Activity.find(params[:id])
    @user = current_user
    @activity.destroy
    flash[:notice] = "Post Destroyed"
    redirect_to user_activities_path(@user)
  end

  private


end
