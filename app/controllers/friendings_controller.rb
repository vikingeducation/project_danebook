class FriendingsController < ApplicationController
  before_action :require_login, :except => [:index]

  def index
    @user = User.find(params[:user_id])
  end

  def create
    if signed_in_user?
      if @friend = get_instance(params[:id], User)
        if current_user.friended_users << @friend
          flash[:success] = "Successfully friended #{@friend.first_name}"
        else
          flash[:danger] = "Failed to friend! Uh ohhh"
        end
      else
        flash[:danger] = "error locating this friend"
      end
      redirect_to :back
    else
      flash[:danger] = "Please sign in to complete this action"
      redirect_to login_path
    end
  end

  def destroy
    if signed_in_user?
      # unfriended_user = User.find(params[:id])
      if unfriended_user = get_instance(params[:id], User)
        if current_user.friended_users.delete(unfriended_user)
          flash[:success] = "Successfully unfriended #{unfriended_user.first_name}"
        else
          flash[:danger] = "Failed to unfriend. . . "
        end
      else
        flash[:danger] = "trouble finding your friend"
      end
      redirect_to :back
    else
      redirect_to login_path
    end
  end
end
