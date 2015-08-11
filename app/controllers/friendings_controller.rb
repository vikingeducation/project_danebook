class FriendingsController < ApplicationController
  def create
    friending_recipient = User.find(params[:id])

    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully sent a friend request to #{friending_recipient.first_name}"
      redirect_to profile_timeline_path(friending_recipient.profile)
    else
      flash[:error] = "Failed to send friend request!"
      redirect_to profile_timeline_path(friending_recipient.profile)
    end
  end

  def destroy
    unfriended_user = User.find(params[:id])
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Successfully unfriended"
    redirect_to profile_timeline_path(current_user.profile)
  end
end
