class FriendRequestsController < ApplicationController
  before_action :require_current_user
  before_action :set_friend_request, :except => [:create]
  before_action :require_current_user_is_initiator, :only => [:create]
  before_action :require_current_user_is_approver, :only => [:update]
  before_action :require_current_user_is_initiator_or_approver, :only => [:destroy]

  def create
    @friend_request = FriendRequest.new(friend_params)
    if @friend_request.save
      flash[:success] = 'Friend request created'
    else
      flash[:error] = 'Friend request not created'
    end
    redirect_to_referer user_path(@friend_request.approver)
  end

  def update
    if @friend_request.accept
      flash[:success] = 'Friend request accepted'
    else
      flash[:error] = 'Friendship not accepted'
    end
    redirect_to_referer user_path(@friend_request.initiator)
  end

  def destroy
    if @friend_request.destroy
      flash[:success] = "Friend request destroyed"
    else
      flash[:error] = "Friend request not destroyed"
    end
    redirect_to_referer
  end


  private
  def set_friend_request
    @friend_request = FriendRequest.find_by_id(params[:id])
    redirect_to_referer root_path, :flash => {:error => 'Friend request not found'} unless @friend_request
  end

  def friend_params
    params.permit(
      :initiator_id,
      :approver_id,
      :id
    )
  end

  def require_current_user_is_initiator
    unless current_user.id.to_s == params[:initiator_id]
      redirect_to_referer(
        root_path,
        :flash => {:error => 'You cannot send friend requests on behalf of other users'}
      )
    end
  end

  def require_current_user_is_approver
    unless current_user == @friend_request.approver
      redirect_to_referer(
        root_path,
        :flash => {:error => 'You cannot accept friend requests on behalf of other users'}
      )
    end
  end

  def require_current_user_is_initiator_or_approver
    unless [@friend_request.initiator, @friend_request.approver].include?(current_user)
      redirect_to_referer(
        root_path,
        :flash => {:error => 'You cannot reject nor cancel friend requests on behalf of other users'}
      )
    end
  end
end


