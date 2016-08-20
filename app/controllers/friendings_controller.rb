class FriendingsController < ApplicationController

  def index
    @users = User.all
  end

  def create
    curr_user = User.find(current_user.id)
    friending_recipient = User.find(params[:user_id])
    if curr_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.username}"
      redirect_to friending_recipient
    else
      flash[:error] = "Failed to friend!  Sad :("
      redirect_to friending_recipient
    end
  end

  def destroy
    @friending = Friending.find_by_friend_id(params[:id])
    if @friending
      @friending.destroy
      flash[:success] = "HSe's your bitch now"
      redirect_to user_friendings_path(current_user)
    else
      flash[:alert] = "Couldn't unfriend him, try blocking him eh."
      render :index
    end
  end
end
