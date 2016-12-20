class FriendingsController < ApplicationController
  

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friended_users + @user.users_friended_by
  end

  def create
    friending_recipient = User.find(params[:id])
    current_user.friended_users << friending_recipient
    flash[:success] = "You're now friends with #{friending_recipient.profile.first_name}"
    redirect_to :back
  end

  def destroy
    unfriended_user = User.find(params[:id])
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "You're now no longer friends with #{unfriended_user.profile.first_name}"
    redirect_to :back
  end

end
