class FriendRequestsController < ApplicationController


  before_action :set_return_path, only: [:create, :destroy]

  def create
    @user = User.find(params[:user_id])
    current_user.friends_requested << @user

    if current_user.save
      flash[:success] = "Friend request sent!"
    else
      flash[:error] = "You can't add that person right now."
    end

    redirect_to session.delete(:return_to)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.friends_requested.delete(@user)

    if current_user.save
      flash[:success] = "Request deleted!"
    else
      flash[:error] = "You can't let that person go just yet."
    end

    redirect_to session.delete(:return_to)
  end

end
