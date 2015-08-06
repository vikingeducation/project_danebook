class FriendsController < ApplicationController

  def index
    @user = User.includes(:friended_users).find(params[:user_id])
    @friends = @user.friended_users
  end

end
