class StaticPagesController < ApplicationController
  before_action :require_login, :except => [:home]
  def home
    @user = User.new
    redirect_to user_path(current_user.id) if signed_in_user?
  end

  def timeline
  end

  def friends
  end

  def about
  end

  def photos
  end

  def about_edit
  end
end
