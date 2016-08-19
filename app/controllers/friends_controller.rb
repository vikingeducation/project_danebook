class FriendsController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end
end
