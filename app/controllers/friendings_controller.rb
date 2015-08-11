class FriendingsController < ApplicationController
  def create
    friending_ recipient = User.find(params[:id])

    if current_user.freinded_users << freinding_recipient
      flash[:success] = "Successfully sent a friend request to #{friending_recipient.name}"
      redirect_to friending_recipient
    else
      flash[:error] = "Failed to send friend request!"
      redirect_to friending_recipient 
    end
  end

  def destroy
    unfriended_user = User.find(params[:id])
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Successfully unfriended"
    redirect_to current_user
  end
end
