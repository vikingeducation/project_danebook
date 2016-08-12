class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]

  def home
    @user = User.new
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
