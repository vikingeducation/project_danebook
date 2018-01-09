class FriendingsController < ApplicationController

  def create
    friending_recipient = User.find(params[:id])
    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.name}"
      redirect_to user_timelines_path(friending_recipient)
    else
      flash[:error] = "Failed to friend!"
      redirect_to user_timelines_path(friending_recipient)
    end
  end

  def destroy
    unfriended_user = User.find(params[:id])

    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Successfully unfriended"
    redirect_to user_timelines_path(unfriended_user)

  end

end
