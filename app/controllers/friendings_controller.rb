class FriendingsController < ApplicationController

  def create
    friending_recipient = User.find(params[:id])
    if current_user.friended_users << friending_recipient
      flash[:success] = "You friended #{friending_recipient.name}!"
      redirect_to friending_recipient
    else
      flash[:error] = "APES!!! IT DIDN'T WORK!!! WHY DIDN'T IT WORK???"
      redirect_to friending_recipient
    end
  end

  def destroy
  end

end
