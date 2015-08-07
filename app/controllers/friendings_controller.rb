class FriendingsController < ApplicationController

  def create
    current_user.friends.build(:friend_id => params[:friend_id])
    current_user.save
    redirect_to user_posts_path(params[:friend_id])
  end

  def index
    @friends = current_user.friends
    if params[:user_id].nil?
      @profile = current_user.profile
    else
      user = User.find(params[:user_id])
      @profile = user.profile
    end
  end

  def destroy
    friend = Friend.where("user_id = ? AND friend_id = ?", current_user.id, params[:id])
    if friend.destroy_all
      flash[:success] = "Successfully delete friend"
    else
      flash[:error] = "Failed to delete friendship, you were meant to be together"
    end
    redirect_to friendings_path(current_user)
  end

end
