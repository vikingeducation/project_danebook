class StaticPagesController < ApplicationController

  def home
    if signed_in_user?
      redirect_to user_posts_path(current_user)
    else
      redirect_to new_user_path
    end
  end

  def timeline
    @user = current_user
    @post = current_user.posts.build
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
