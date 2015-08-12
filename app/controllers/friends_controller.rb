class FriendsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end
end
