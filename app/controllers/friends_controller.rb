class FriendsController < ApplicationController

  include UserCheck
  before_action :set_user_basic_profile

  def show
    @friends = @user.friends
  end

  def create
    check_friendship
    if @user.requested_friend_ids.include?(current_user.id)
      FriendRequest.where(user_id: @user.id, request_id: current_user.id).destroy_all
      FriendRequest.where(user_id: current_user.id, request_id: @user.id).destroy_all
      @user.friends << current_user
      current_user.friends << @user
      flash[:success] = ["Friend Request Accepted!"]
    else
      @user.friend_request_ids << current_user.id
      @request = FriendRequest.new(user_id: @user.id, request_id: current_user.id)
      if @request.save
        flash[:success] = ["Friend Request Sent!"]
      else
        flash[:danger] = ["Friend Request Already Sent. Stop buggin them!"]
      end
    end
    redirect_to user_profile_path(@user.profile)
  end

  def destroy
    FriendsUser.where(user_id: @user.id, friend_id: current_user.id).destroy_all
    FriendsUser.where(user_id: current_user.id, friend_id: @user.id).destroy_all
    redirect_to root_path
  end

  private
    def check_friendship
      if current_user.friend_ids.include?(@user.id)
        flash[:danger] = ["You're Already Friends!"]
        redirect_to user_profile_path(@user.profile)
      end
    end

end
