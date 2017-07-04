class FriendRequestsController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]
  before_action :set_friend_request, only: [:update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end

  def create
    friend = User.find(params[:user_id])
    status = Status.find_by(message: "Pending")
    friend_request = FriendRequest.new(
      user_one_id: current_user.id,
      user_two_id: friend.id,
      status_id: status.id
    )
    if friend_request.save
      flash[:success] = "Friend request sent successfully"
    else
      flash[:danger] = "Failed to create friend request"
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @friend_request.status = Status.find_by(message: "Accepted")
    if @friend_request.save
      flash[:success] = "Friend added successfully"
    else
      flash[:danger] = "Failed to add friend"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    title = @friend_request.status.message == "Accepted" ? "friend" : "friend request"
    if @friend_request.delete
      flash[:success] = "#{title.capitalize} deleted successfully"
    else
      flash[:danger] = "Failed to delete #{title}"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

end
