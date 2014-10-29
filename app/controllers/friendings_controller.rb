class FriendingsController < ApplicationController

  before_action :set_return_path, only: [:create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end

  def create
    @user = User.find(params[:user_id])
    current_user.friends << @user

    if current_user.save
      flash[:success] = "Added new friend!"
    else
      flash[:error] = "You can't add that person right now."
    end

    redirect_to session.delete(:return_to)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.friends.delete(@user)

    if current_user.save
      flash[:success] = "Unfriended!"
    else
      flash[:error] = "You can't let that person go just yet."
    end

    redirect_to session.delete(:return_to)
  end
end