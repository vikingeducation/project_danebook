class FriendshipsController < ApplicationController

  def create
    friendship_recipient = User.find(params[:user_id])

    if current_user.friended_users << friendship_recipient 
      flash[:success] = "You successfully befriended #{friendship_recipient.name}!"
    else
      flash[:error] = "You failed to befriended #{friendship_recipient.name}. We're working to solve this problem as soon as we can."
    end
    redirect_to friendship_recipient
  end

  def destroy
    unfriended_user = User.find(params[:user_id])
    current_user.friended_users.dlete(unfriended_user)
    redirect_to unfriended_user
  end

end
