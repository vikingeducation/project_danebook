class FriendshipsController < ApplicationController

  def create
    new_friendship = Friendship.new(friendship_params)
    if new_friendship.save
      flash[:success] = "Friend was successfully added as a friend"
    else
      flash[:danger] = "Friend was not added"
    end
    redirect_to timeline_user_path(current_user)
  end

  def destroy
    @friendship = Friendship.find_by(initiator: current_user.id, recipient: params[:id])
    if @friendship.destroy!
      flash[:success] = "Unfriended"
    else
      flash[:danger] = "Unable to unfriend"
    end
    redirect_to timeline_user_path(current_user)
  end

  private
  def friendship_params
      params.require(:friendship).permit(:initiator, :recipient)
  end

end
