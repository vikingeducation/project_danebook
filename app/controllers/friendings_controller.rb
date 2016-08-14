class FriendingsController < ApplicationController
  before_action :require_login

  def create
    if signed_in_user?
      session[:return_to] = request.referer
      friending_recipient = User.find(params[:id])
      if current_user.friended_users << friending_recipient
        flash[:success] = "Successfully friended #{friending_recipient.first_name}"
      else
        flash[:error] = "Failed to friend! Uh ohhh"
      end
      redirect_to session.delete(:return_to)
    else
      redirect_to login_path
    end
  end

  def destroy
    if signed_in_user?
      session[:return_to] = request.referer
      unfriended_user = User.find(params[:id])
      if current_user.friended_users.delete(unfriended_user)
        flash[:success] = "Successfully unfriended #{unfriended_user.first_name}"
      else
        flash[:error] = "Failed to unfriend. . . "
      end
      redirect_to session.delete(:return_to)
    else
      redirect_to login_path
    end
  end
end
