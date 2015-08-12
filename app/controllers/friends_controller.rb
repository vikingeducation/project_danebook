class FriendsController < ApplicationController
  before_action :require_friends
  def index
    @profile = current_user.profile
  end

  def require_friends
    @user = (User.find(params[:user_id]))
    unless current_user.friends_with?(@user) || @user == current_user
      flash[:error] = "You must be friends with someone to see their friends"
      redirect_to user_friends_path(current_user)
    end
  end
end
