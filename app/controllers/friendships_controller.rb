class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.initiated_friendships.where(friendee_id: params[:user_id]).first_or_initialize
    @recipient = User.find(params[:user_id])
    if @friendship.save
      flash[:success] = "Your request to add #{@recipient.full_name} as a friend has been sent"
    else
      flash[:error] = "Sorry, but you can't send a friend invite to #{@recipient.full_name}"
    end
    redirect_to user_profile_path(@recipient)
  end

  def update
    @friender = User.find(params[:id])
    @friendship = current_user.received_friendships.find_by(friender_id: @friender.id)
    case request.path
    when reject_friend_path(@friender)
      @friendship.update(rejected: true, friender_id: @friender.id)
      flash[:notice] = "You have rejected #{@friender.full_name}'s friend request"
    when accept_friend_path(@friender)
      @friendship.update(rejected: false, friender_id: @friender.id)
      flash[:success] = "You are now friends with #{@friender.full_name}"
    when cancel_friend_path(@friender)
      @friendship = current_user.initiated_friendships.find_by(friendee_id: @friender.id)
      if @friendship.destroy
        flash[:success] = "Your friendship request has been cancelled"
      else
        flash[:error] = "We couldn't cancel your friendship request"
      end
    end
    redirect_to user_profile_path(@friender)
  end

  def destroy
    @friend = User.find(params[:id])
    @friendships = current_user.initiated_friendships.find_by(friendee_id: @friend.id)
    if @friendships.destroy
      flash[:success] = "You're no longer friends with #{@friend.full_name}"
    else
      flash[:error] = "You couldn't unfriend #{@friend.full_name}"
    end
    redirect_to user_profile_path(@friend)
  end

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friendees
  end

  def cancel
    @friendee = User.find(params[:id])
    @friendship = current_user.initiated_friendships.find_by(friendee_id: @friendee)
    if @friendship.destroy
      flash[:success] = "Your friendship request has been cancelled"
    else
      flash[:error] = "We couldn't cancel your friendship request"
    end
    redirect_to user_profile_path(@friendee)
  end

  private


  def accepted_params
    params.permit(:status).merge(friender_id: @friender.id)
  end



end
