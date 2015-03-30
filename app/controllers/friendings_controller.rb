class FriendingsController < ApplicationController
  # For actual 2-way friendships, not 1-way requests

  before_action :set_return_path, only: [:create, :destroy]
  before_action :check_friend_requests, only: [:create]

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

  private

  def check_friend_requests
    @user = User.find(params[:user_id])

    unless current_user.friend_requesters.include?(@user)
      flash[:error] = "This person hasn't actually requested you be friends."
      redirect_to session.delete(:return_to)
    end
  end
end