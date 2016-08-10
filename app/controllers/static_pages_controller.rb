class StaticPagesController < ApplicationController

  def home
    @user = User.new
    render layout: "homepage"
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
