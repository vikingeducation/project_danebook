class FriendingsController < ApplicationController

  def create
    friend_recipient = User.find(params[:user_id])
    if current_user.friended_users << friend_recipient
      flash[:success] = "Successfully friended #{friend_recipient.first_name}"
      redirect_to friend_recipient
    else
      flash.now[:error] = "It failed to friend, Forever alone.."
      redirect_to friend_recipient
    end
  end

  def destroy
    friend = User.find(params[:id])
    if current_user.friended_users.destroy(friend)
      flash[:success] = "Successfully unfriended #{friend.first_name}"
      redirect_to friend
    else
      flash.now[:error] = "It failed to unfriend.."
      redirect_to friend
    end
  end
end
