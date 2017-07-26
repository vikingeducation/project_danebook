class FriendingsController < ApplicationController

  def create
    recipient = User.find(params[:user_id])
    if current_user.friended_users << recipient
      flash[:success] = "You have created new friend"
      redirect_to :back
    else
      flash[:danger] = "Something went wrong! Couldn't make a new friend"
      redirect_to :back
    end
  end

  def destroy
    removed_friend = User.find(params[:user_id])
    if current_user.friended_users.delete(removed_friend)
      flash[:success] = "You have lost a friend successfully!"
      redirect_to :back
    else
      flash.now[:danger] = "Loosing friend didn't work"
      redirect_to :back
    end
  end

end
