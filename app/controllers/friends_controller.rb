class FriendsController < ApplicationController

  before_action :require_login


  def create
    recipient = User.find(params[:recipient_id])
    if current_user.friended_users << recipient
      flash[:success] = "Added #{recipient.profile.full_name} as a Friend!"
    else
      flash[:error] = "Friend not added. Please verify you're not already friends and try again."
    end
    redirect_to :back
  end


  def destroy
    recipient = User.find(params[:id])
    if current_user.friended_users.delete(recipient)
      flash[:warning] = "Unfriended #{recipient.profile.full_name}."
    else
      flash[:error] = "Error!"
    end
    redirect_to :back
  end

end
