class FriendingsController < ApplicationController

  def create
    if current_user.friended_users.where(params[:friend_id]).empty?
      session[:return_to] = request.referer
      current_user.friended_users << User.find(params[:friend_id])
      current_user.users_friended_by << User.find(params[:friend_id])
    else
      flash[:alert] = "already friends!"
    redirect_to session.delete(:return_to)
  end

  def destroy
    current_user
  end


end
