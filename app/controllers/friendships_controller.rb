class FriendshipsController < ApplicationController

before_action :require_login
before_action :require_object_owner, only: [:update]

def create
  @initiator = current_user
  @acceptor = User.find(params[:user_id])
  if @initiator.friends_added << @acceptor
    flash[:success] = "Request sent"
  else
    flash[:error] = "Unable to add friend"
  end
  redirect_to :back
end

def update
  friendship = Friendship.find(params[:friendship_id])
  if friendship.update(:status => 'Accepted')
    flash[:success] = "New friendship accepted"
  else
    flash.now[:error] = "Unable to accept friend"
  end
  redirect_to :back
end

def destroy


end

end
