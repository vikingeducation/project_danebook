class FriendsController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @friends = @user.friended_users
  end
end
