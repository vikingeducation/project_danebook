class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:home]
  before_action :require_current_user, only: [:edit, :update, :destroy]

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
