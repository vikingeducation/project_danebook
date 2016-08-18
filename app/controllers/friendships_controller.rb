class FriendshipsController < ApplicationController

  def create
    friendship_recipient = User.find(params[:user_id])

    if current_user.friended_users << friendship_recipient 
      flash[:success] = "You successfully befriended #{friendship_recipient.name}!"
    else
      flash[:error] = "You failed to befriended #{friendship_recipient.name}. We're working to solve this problem as soon as we can."
    end
    redirect_to user_timeline_path(friendship_recipient)
  end

  def destroy
    unfriended_user = User.find(params[:user_id])
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "You are no longer friends with #{unfriended_user.name}."
    redirect_to user_timeline_path(unfriended_user)
  end

end
