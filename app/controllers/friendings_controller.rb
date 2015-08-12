class FriendingsController < ApplicationController

  def create
    current_user.friends.build(:friend_id => params[:user_id])
    friend = User.find(params[:user_id])
    friend.friends.build(:friend_id => current_user.id)
    friend.save
    current_user.save
    redirect_to user_posts_path(params[:user_id])
  end

  def index
    if params[:user_id].nil?
      @profile = current_user.profile
      @friends = current_user.friends
    else
      user = User.find(params[:user_id])
      @profile = user.profile
      @friends = user.friends
    end
  end

  def destroy
    user_friendship = Friend.where("user_id = ? AND friend_id = ?", current_user.id, params[:user_id])
    friend_friendship = Friend.where("user_id = ? AND friend_id = ?", params[:user_id], current_user.id )

    if user_friendship.destroy_all && friend_friendship.destroy_all
      flash[:success] = "Successfully delete friend"
    else
      flash[:error] = "Failed to delete friendship, you were meant to be together"
    end
    redirect_to user_friendings_path(current_user)
  end

end
