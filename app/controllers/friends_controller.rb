class FriendsController < ApplicationController

  def create
    @friend = Friend.new(friendee_id: params[:id], friender_id: current_user.id)
    if @friend == current_user
      flash[:danger] = "You cannot friend yourself"
      redirect_back(fallback_location: root_path)
    elsif @friend.save
      flash[:success] = "Request sent"
      redirect_back(fallback_location: root_path)
    else 
      flash[:danger] = "Error! Contact an admin!"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friend = Friend.where(friender_id: current_user.id, friendee_id: params[:id])
    if @friend.first.destroy
      flash[:success] = "Request revoked"
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friended_users
  end
end
