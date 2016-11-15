class ActivitiesController < ApplicationController
  before_action :require_login

  def index
    @activities = Activity.feed_for(current_user).take(100)
  end

  def show
    @user = User.find_by_id(params[:user_id])
    if @user
      @activities = Activity.timeline_for(@user)
    else
      redirect_to_referer(
        root_path,
        :flash => {:error => 'Unable to show timeline for that user'}
      )
    end
  end
end
