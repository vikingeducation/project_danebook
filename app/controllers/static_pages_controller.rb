class StaticPagesController < ApplicationController

  def home
    if signed_in_user?
      redirect_to action: :timeline
    else
      redirect_to new_user_path
    end
  end

  def timeline
    @user = current_user
  end

  def friends
  end

  def about
  end

  def about_edit
  end

  def photos
  end

end
