class FriendingsController < ApplicationController

  def create
    session[:return_to] = request.referer
    friend = User.find(params[:friend_id])
    if current_user.friends?(friend)
      flash[:alert] = "already friends!"
    else
      current_user.make_friend(friend)
      flash[:notice] = "Friended #{friend}"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    friend = User.find(params[:friend_id])
    if current_user.unfriend(friend)
      flash[:notice] = "Unfriended"
    else
      flash[:alert] = "Couldn't Unfriend"
    end
    redirect_to session.delete(:return_to)
  end


end
