class FriendingsController < ApplicationController

  def create
    session[:return_to] = request.referer
    current_user.friended_users << User.find(params[:friend_id])
    current_user.users_friended_by << User.find(params[:friend_id])
    redirect_to session.delete(:return_to)
  end

  def destroy
    current_user
  end


end
