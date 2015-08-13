class FriendingsController < ApplicationController

  before_action :require_login
#Adds the friended user to the current users friend list
  #parms[:user_id] is the user we are friending
  #we are on their page
#Also adds the current user to the friended user's friend list
  def create
    
    current_user.friends.build(:friend_id => params[:friend_id])
    friend = User.find(params[:friend_id])
    friend.friends.build(:friend_id => current_user.id)
    
    friend.save
    current_user.save
    
    redirect_to user_posts_path(params[:friend_id])
  end

#Lists all the friends of a specified user
#If parameters are passed, means we are on another user's page
#If no parameters are passed, we are on the current_user's page
  def index 
    if params[:user_id].nil?
      @profile = current_user.profile
      @friends = current_user.friends
    else
      user = User.find(params[:user_id])
      @profile = user.profile
      @friends = user.friends
    end
  end

#Finds the current user's friendship with the other user
#Also finds the friended user's friendship with the current user
#Deletes both the friendships
  def destroy
    user_friendship = Friend.where("user_id = ? AND friend_id = ?", current_user.id, params[:user_id])
    friend_friendship = Friend.where("user_id = ? AND friend_id = ?", params[:user_id], current_user.id )

    if user_friendship.destroy_all && friend_friendship.destroy_all
      flash[:success] = "Successfully delete friend"
    else
      flash[:error] = "Failed to delete friendship, you were meant to be together"
    end
    redirect_to user_friendings_path(current_user)
  end

end
