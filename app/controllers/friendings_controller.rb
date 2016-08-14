class FriendingsController < ApplicationController

  def create
    session[:return_to] = request.referer
    if current_user.friended_users.where(id: params[:friend_id]).empty?
      friend = User.find(params[:friend_id])
      current_user.friended_users << friend
      current_user.users_friended_by << friend
      flash[:notice] = "Friended #{friend}"
    else
      flash[:alert] = "already friends!"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    friend = User.find(params[:friend_id])
    if current_user.friended_users.delete(friend)
      current_user.users_friended_by.delete(friend)
      flash[:notice] = "Unfriended"
    else
      flash[:alert] = "Couldn't Unfriend"
    end
    redirect_to session.delete(:return_to)
  end


end
