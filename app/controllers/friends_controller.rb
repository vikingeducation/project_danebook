class FriendsController < ApplicationController

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @friends = @user.friends
  end

end
