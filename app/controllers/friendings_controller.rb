class FriendingsController < ApplicationController
  def create
    friending_recipient = User.find_by_id(params[:user_id])
    if friending_recipient && current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.username}"
    else
      flash[:error] = "Failed to friend!  Sad :("
    end
    redirect_back(fallback_location: fallback_location)
  end

  def destroy
    unfriended_user = User.find_by_id(params[:id])
    if unfriended_user && current_user.friended_users.delete(unfriended_user)
      flash[:success] = "Successfully unfriended"
      redirect_back(fallback_location: fallback_location)
    end
  end

end
