class StaticPagesController < ApplicationController
  skip_before_action :require_login, :only => [:home]
  def home
    if signed_in_user?
      redirect_to :timeline
    else
      @user = User.new
    end
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
