class ActivitiesController < ApplicationController
  before_action :required_user_redirect, except: [:index]
  before_action :set_user, :only => [:index]

  def index
    @post = Post.new
    @comment = Comment.new
    @activities = @user.get_wall_activities
    @friends = @user.followees.limit(6)
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    flash[:notice] = "Post Destroyed"
    redirect_back(fallback_location: root_path)
    
  end


end
