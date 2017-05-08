class FriendsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def create
    @friendee = User.find([params[:user_id]])
    if current_user != @friendee
      current_user.friendee_users << @friendee
      current_user.save
      flash[:success] = 'You have a new friend!'
      redirect_to user_timeline_path(params[:user_id])
    else
      flash[:warning] = @friending.errors.full_messages
      redirect_to user_timeline_path(params[:user_id])
    end
  end

  def destroy
    friend = User.find(params[:user_id])
    if current_user.delete_friendship(friend)
      flash[:success] = 'Unfriended!'
      redirect_to user_timeline_path(friend.id)
    else
      flash[:warning] = 'still friends sorry'
      redirect_to user_timeline_path(friend.id)
    end
  end
end
