class StaticPagesController < ApplicationController

  def about
    render :about
  end

  def edit
    render :about_edit
  end

  def friends
    render :friends
  end

  def photos
    render :photos
  end

  def timeline
    render :timeline
  end
  
end
