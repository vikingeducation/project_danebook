class FriendingsController < ApplicationController

  before_action :require_login

  def create
    friending_recipient = User.find(params[:user_id])
    if current_user.friends << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.name}"
      redirect_to friending_recipient # user show page
    else
      flash[:alert] = "You're already friends with this person!"
      redirect_to URI(request.referer).path
    end
  end

  def destroy
    unfriended_user = User.find(params[:user_id])
    current_user.friends.delete(unfriended_user)
    flash[:success] = "Successfully unfriended #{unfriended_user.name}"
    redirect_to URI(request.referer).path
  end

end
