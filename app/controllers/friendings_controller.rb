class FriendingsController < ApplicationController

  def index
  end

  def create
    friending_recipient = User.find(params[:id])

    current_user.friended_users << friending_recipient
    redirect_to :back
  end

  def destroy
    unfriended_user = User.find(params[:id])
    current_user.friended_users.delete(unfriended_user)
    redirect_to :back
  end

end
