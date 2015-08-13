class FriendingsController < ApplicationController

  def create
    session[:return_to] ||= request.referer

    friending_recipient = User.find(params[:id])

    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.profile.full_name}"
    else
      flash[:error] = "Failed to friend!  Sad :("
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer

    unfriended_user = User.find(params[:id])

    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Successfully unfriended"
    redirect_to session.delete(:return_to)
  end

end
