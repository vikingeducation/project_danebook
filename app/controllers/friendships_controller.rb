class FriendshipsController < ApplicationController
  before_action :require_login
  before_action :set_friendship, :except => [:index]
  before_action :require_current_user, :except => [:index]
  before_action :require_current_user_is_initiator_or_approver, :except => [:index]

  def index
     @user = User.find_by_id(params[:user_id])
    if @user
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

  def require_current_user_is_initiator_or_approver
    unless [@friendship.initiator, @friendship.approver].include?(current_user)
      redirect_to_referer root_path, :flash => {:error => 'You must be a part of a friendship to destroy it'}
    end
  end
end
