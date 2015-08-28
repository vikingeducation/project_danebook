class NewsfeedsController < ApplicationController

  before_action :require_current_user

  def show
    @user = current_user
    @posts = Post.get_newsfeed(@user.friended_user_ids)
  end




  private


    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:danger] = "You're not authorized to do this!"
        redirect_to root_url
      end
    end

end
