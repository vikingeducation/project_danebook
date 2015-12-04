class FriendshipsController < ApplicationController
  before_action :require_login
  before_action :require_current_user, :except => [:index]
  before_action :require_current_user_is_friend, :except => [:index]
  before_action :set_friendship, :except => [:index]

  def index
    if User.exists?(params[:user_id])
      @user = User.find(params[:user_id])
      @friends = @user.friends
    else
      redirect_to_referer root_path, :flash => {:error => 'A user must exist to have friends, it\'s science'}
    end
  end

  def destroy
    if @friendship.destroy
      flash[:success] = "Friendship destroyed"
    else
      flash[:error] = "Friendship not destroyed"
    end
    redirect_to_referer
  end


  private
  def set_friendship
    @friendship = Friendship.find_by_id(params[:id])
    redirect_to_referer root_path, :flash => {:error => 'That was not friendly'} unless @friendship
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
      redirect_to_referer root_path, :flash => {:error => 'You must be part of a friendship to do that'}
    end
  end

  def is_friend_current_user?
    [params[:initiator_id], params[:approver_id]].include?(current_user.id.to_s)
  end
end
