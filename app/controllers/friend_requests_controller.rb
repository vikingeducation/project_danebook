class FriendRequestsController < ApplicationController

  def index
    @user = current_user
    @friend_requesters = current_user.friend_requests
  end

end
