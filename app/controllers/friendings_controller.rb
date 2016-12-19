class FriendingsController < ApplicationController

  before_action :require_current_user, except: [:index]

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friended_users + @user.users_friended_by
  end

  def create
    friending_recipient = User.find(params[:id])

    current_user.friended_users << friending_recipient
    redirect_to :back
  end

  def destroy
    unfriended_user = User.find(params[:id])
    current_user.friended_users.delete(unfriended_user)
    redirect_to :back
  end

end
