class FriendsController < ApplicationController
  def create
    current_user.friends << User.find(friend_params[:user_id])
    flash[:success] = "You've added a friend!"
    redirect_to current_user
  end

  private

    def friend_params
      params.require(:friend).permit(:user_id)
    end
end
