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
    @act_id = @activity.id
    if @activity.postable_type == "Photo"
      flash[:notice] = "Photo Destroyed"
      @activity.postable.clear_user(current_user)
      @activity.destroy
      redirect_to user_photos_path(current_user)
    else
      @activity.destroy
      flash[:notice] = "Post Destroyed"
      respond_to do |format|
        format.html {redirect_back(fallback_location: root_path)}
        format.js {}
      end
    end
  end


end
