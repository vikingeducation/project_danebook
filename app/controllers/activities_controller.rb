class ActivitiesController < ApplicationController
  before_action :required_user_redirect, except: [:index]
  before_action :set_user, :only => [:index]

  def index
    @post = Post.new
    @comment = Comment.new
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
