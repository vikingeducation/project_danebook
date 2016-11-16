class FriendsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
end
