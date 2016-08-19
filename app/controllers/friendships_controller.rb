class FriendshipsController < ApplicationController
  before_action :set_user

  def index
    @friends = @user.friended_users
  end

  def create
    current_user.friended_users << @user
    @user.friended_users << current_user

    flash[:success] = "Friend added!"

    go_back
  end

  def destroy
    if current_user.initiated_friendships.find_by(friended_id: @user.id).destroy &&
       @user.initiated_friendships.find_by(friended_id: current_user.id).destroy
       flash[:success] = "Friend removed!"
    else
      flash[:danger] = "Unable to remove friend"
    end

    go_back
  end

  private

  def set_user
    id = params[:user_id] || params[:id]
    @user = User.find(id)
  end
end
