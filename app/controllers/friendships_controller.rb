class FriendshipsController < ApplicationController

  before_action :set_user

  def create
    new_friendship = Friendship.new(friendship_params)
    if new_friendship.save
      flash[:success] = "You are now Friends!"
    else
      flash[:danger] = "Unable to Friend"
    end
    redirect_back fallback_location: user_timeline_url(@current_user)
  end

  def destroy
    @friendship =  Friendship.find_by(friender_id: friendship_params[:friender_id], friendee_id: friendship_params[:friendee_id])
    if @friendship.destroy
      flash[:success] = "You are no longer Friends"
    else
      flash[:danger] = "Unable to unfriend"
    end
    redirect_back fallback_location: user_timeline_url(@current_user)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friender_id, :friendee_id)
  end

end
