class StaticPagesController < ApplicationController
  def home
    @home = true
    @current_user = true
    @user = User.new
    # redirect_to new_user_path
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
