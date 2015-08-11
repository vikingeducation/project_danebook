class FriendshipsController < ApplicationController

before_action :require_login
before_action :require_object_owner, only: [:update]

def index
  @friendships = object_owner.all_friendships
  @friends = object_owner.friends
end

def create
  @friender = current_user
  @friend = User.find(params[:user_id])
  if !@friender.friends_added.include?(@friend)
      if @friender.friends_added << @friend
        flash[:success] = "Request sent"
      else
        flash[:error] = "Unable to add friend"
      end
  else
    flash[:error] = "Friend request already sent"
  end
  redirect_to :back
end

def update
  friendship = Friendship.find(params[:id])
  if friendship.update(:status => 'Accepted')
    flash[:success] = "New friendship accepted"
  else
    flash.now[:error] = "Unable to accept friend"
  end
  redirect_to :back
end

def destroy
  friendship = Friendship.find(params[:id])
  if friendship.destroy
    flash[:success] = "Friendship terminated"
  else
    flash[:error] = "Unable to terminate friendship"
  end
  redirect_to :back
end

end
