class FriendingsController < ApplicationController

  def create
    new_friend = User.find(params[:format])
    if current_user.friendeds << new_friend
      flash.notice = "Successfully friended #{new_friend.profile.name}"
      redirect_back(fallback_location: current_user)
    else
      flash.notice = "Failed to friend!  Sad :("
      redirect_back(fallback_location: current_user)
    end
  end

  def destroy
    unfriend = User.find(params[:id])
    current_user.friendeds.delete(unfriend)
    flash.notice = "Successfully unfriended"
    redirect_back(fallback_location: current_user)
  end

  def show
    @user = User.find(params[:id])
  end

end