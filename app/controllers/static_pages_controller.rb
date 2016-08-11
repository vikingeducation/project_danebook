class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]

  def home
    @user = User.new
    redirect_to timeline_path if signed_in_user?
  end

  def timeline
  end

  def friends
  end

  def about
  end

  def photos
  end
end
