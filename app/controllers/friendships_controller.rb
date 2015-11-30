class FriendshipsController < ApplicationController
  before_action :require_current_user
  before_action :require_current_user_is_friend
  before_action :set_friendship

  def destroy
    if @friendship.destroy
      flash[:success] = "Friendship destroyed"
    else
      flash[:error] = "Friendship not destroyed"
    end
    redirect_to request.referer ? request.referer : root_path
  end


  private
  def set_friendship
    @friendship = Friendship.find_by_id(params[:id])
    redirect_to root_path, :flash => {:error => 'That was not friendly'} unless @friendship
  end

  def friend_params
    params.permit(
      :initiator_id,
      :approver_id,
      :id
    )
  end

  def require_current_user_is_friend
    unless is_friend_current_user?
      redirect_to root_path, :flash => {:error => 'You must be part of a friendship to do that'}
    end
  end

  def is_friend_current_user?
    [params[:initiator_id], params[:approver_id]].include?(current_user.id.to_s)
  end
end
