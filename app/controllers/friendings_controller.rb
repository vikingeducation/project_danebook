class FriendingsController < ApplicationController

  def create
    current_user = User.find(params[:current_user_id])
    friending_recipient = User.find(params[:id])

    if current_user.friended_users << friending_recipient
      flash[:success] = "You have friended #{friending_recipient.name}"
      redirect_to friending_recipient
    else
      flash[:error] = "An error have occurred"
      redirect_to friending_recipient
    end
  end

  def destroy
    current_user = User.find(params[:current_user_id])
    unfriended_user = User.find(params[:id])
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Successfully unfriended"
    redirect_to current_user
  end

end
