class StaticPagesController < ApplicationController
  skip_before_action :require_login, :only => [:home]
  def home
    if signed_in_user?
      redirect_to user_activities_path(current_user)
    else
      @user = User.new
    end
  end

  def timeline
    current_user
  end

  def friends
  end

  def photos
    @user = User.last
  end

end
