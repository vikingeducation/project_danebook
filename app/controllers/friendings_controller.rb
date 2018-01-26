class FriendingsController < ApplicationController

  def create
    friending_recipient = User.find(params[:id])
    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.name}"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Failed to friend!"
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    unfriended_user = User.find(params[:id])
    if current_user.friended_users.include?(unfriended_user)
      current_user.friended_users.delete(unfriended_user)
    elsif current_user.users_friended_by.include?(unfriended_user)
      current_user.users_friended_by.delete(unfriended_user)
    else
    end
    flash[:success] = "Successfully unfriended"
    redirect_to session.delete(:return_to)
  end

end
