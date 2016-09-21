class StaticPagesController < ApplicationController
    skip_before_action :require_login, only: [:home]



  def home
    if signed_in_user?
      redirect_to user_timeline_path(current_user)
    end
  
  end

  def timeline

  end

  def photos

  end

  def about_edit

  end

  def about
    

  end
end
