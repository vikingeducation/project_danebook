class FriendsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @profile = Profile.find_by_user_id(params[:user_id])
    @friends = @user.friends
  end


end
