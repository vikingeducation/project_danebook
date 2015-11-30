class FriendsController < ApplicationController
  before_action :require_current_user
  before_action :require_current_user_is_friend
  before_action :set_friendable, :except => [:create]

  def create
    @friend_request = FriendRequest.new(friend_params)
    if @friend_request.save
      flash[:success] = 'Friend request created'
    else
      flash[:error] = 'Friend request not created'
    end
    redirect_to user_path(@friend_request.approver)
  end

  def update
    if @friendable.accept
      flash[:success] = 'Friendship created'
    else
      flash[:error] = 'Friendship not created'
    end
    redirect_to user_path(current_user)
  end

  def destroy
    if @friendable.destroy
      flash[:success] = "#{@friendable.model_name.human} destroyed"
    else
      flash[:error] = "#{@friendable.model_name.human} not destroyed"
    end
    redirect_to request.referer ? request.referer : root_path
  end


  private
  def set_friendable
    @friendable = FriendRequest.find_by_id(params[:id])
    @friendable = Friendship.find_by_id(params[:id]) unless @friendable || action_name == 'update'
    redirect_to root_path, :flash => {:error => 'That was not friendly'} unless @friendable
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
    is_friend = current_user.id.to_s == params[:initiator_id] if action_name == 'create'
    is_friend = current_user.id.to_s == params[:approver_id] if action_name == 'update'
    is_friend = [params[:initiator_id], params[:approver_id]].include?(current_user.id.to_s) if action_name == 'destroy'
    !!is_friend
  end
end

