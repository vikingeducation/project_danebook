class FriendsController < ApplicationController

  before_action :require_login, :except => [:index]


  def index
    @user = User.find(params[:user_id])
    @friends = @user.friended_users
  end


  def create
    recipient = User.find(params[:recipient_id])
    if current_user.initiated_friendings.create(friend_id: recipient.id)
      flash[:success] = "Added #{recipient.profile.full_name} as a Friend!"
    else
      flash[:error] = "Friend not added. Please verify you're not already friends and try again."
    end

    redirect_back_or_to(user_path(recipient))
  end


  def destroy
    recipient = User.find(params[:id])
    if current_user.friended_users.delete(recipient)
      flash[:warning] = "Unfriended #{recipient.profile.full_name}."
    else
      flash[:error] = "An error occurred.  Please try again."
    end
    redirect_back_or_to(user_path(current_user))
  end

end
