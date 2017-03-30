class FriendingsController < ApplicationController

  before_action :require_login, except: [ :index ]

  def index
    @user = User.find(params[:user_id])
    @friended_users = User.find(params[:user_id]).friended_users
    @users_friended_by = User.find(params[:user_id]).users_friended_by
  end

  def create
    # this is current_user from params, need to get it from authentication system <--- CHANGE THIS
    friending_recipient = User.find(params[:user_id])

    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.name}"
      redirect_to :back
    else
      flash[:error] = "Failed to friend!"
      redirect_to :back
    end
  end

  def destroy
    # again, pulling user from params instead of authentication <--- CHANGE THIS

    unfriended_user = User.find(params[:id])

    # only look within current users's friendships, don't want to destroy other's friendships!
    if current_user.friended_users.delete(unfriended_user)
      flash[:success] = "Successfully unfriended."
      redirect_to :back
    else
      flash[:error] = "Failed to unfriend."
      redirect_to :back
    end
  end

end
