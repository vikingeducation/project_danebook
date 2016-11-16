class StaticPagesController < ApplicationController
  skip_before_action :require_login, :only => [:home]
  def home
    @user = User.new
    redirect_to user_path(current_user.id) if signed_in_user?
  end

  def timeline
    @profile = false
  end

  def friends
    @profile = false
  end

  def about
    @profile = false
  end

  def photos
    @profile= false
  end

  def about_edit
    @profile = false
  end
end
