class FriendingsController < ApplicationController

  # before_action :require_current_users

  def create
    current_user = User.find(params[:current_user_id])
    friending_recipient = User.find(params[:id])

    if current_user.friended_users << friending_recipient
      flash[:success] = "You friended #{friending_recipient.name}"
      redirect_to friending_recipient

    else
      flash[:error] = "Friending failure. Try again!"
      redirect_to friending_recipient
    end
  end

end
