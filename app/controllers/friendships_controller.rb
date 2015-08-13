class FriendshipsController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:success] = "Added friend."
      redirect_to URI(request.referer).path
    else
      flash[:error] = "Unable to add friend."
      redirect_to URI(request.referer).path
    end
  end

  def destroy
    @friendship = current_user.friendships.where(:friend_id => params[:id]).first
    @friendship = current_user.friendships.where(:friend_id => params[:friend_id]).first if @friendship.nil?
    @friendship.destroy
    flash[:success] = "Removed friendship."
    redirect_to URI(request.referer).path
  end
end
