class ActivitiesController < ApplicationController

  def index
    @post = Post.new
    @comment = Comment.new
    @user = User.find(params[:user_id])
    @activities = @user.get_wall_activities
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
