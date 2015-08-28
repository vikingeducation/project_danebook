class NewsfeedsController < ApplicationController

  #before_action :require_current_user
  before_action :require_login

  def show
    @user = current_user
    @posts = Post.get_newsfeed_posts(@user.friended_user_ids)
    @friends = User.get_recently_active_friends(@posts)
  end




  private


    #def require_current_user
    #  unless params[:user_id] == current_user.id.to_s
    #    flash[:danger] = "You're not authorized to do this!"
    #    redirect_to root_url
    #  end
    #end

end
