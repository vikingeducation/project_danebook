class FriendingsController < ApplicationController

  before_action :require_login

  def index
    @user = User.find(params[:user_id])
  end
    def show
    @user = User.find(params[:user_id]) 
  end 

  #sending friend requests
  def create
    @user = User.find(params[:id])

    Friending.request_friend(current_user, @user)

     mailer = UserMailer.friend_request(
      :user => current_user,
      :friend => @user,
      :user_url => user_posts_path(@user),
      :accept_url => url_for(controller: 'friendings', action: 'accept', id: @user.id),
      :decline_url => url_for(controller: 'friendings', action: 'decline', id: @user.id)
      )
     mailer.deliver!
      flash[:success] = "Friend request sent"
      redirect_to @user
  end

  def accept
    Friendship.accept(current_user)
  end     

  def decline
  end
  # def destroy
  #   current_user = User.find(params[:current_user_id])
  #   unfriended_user = User.find(params[:id])
  #   current_user.friended_users.delete(unfriended_user)
  #   flash[:success] = "Successfully unfriended"
  #   redirect_to current_user
  # end

end
