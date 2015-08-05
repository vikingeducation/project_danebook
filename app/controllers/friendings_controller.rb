class FriendingsController < ApplicationController
  before_filter :store_referer
  def create
    @user = User.find(params[:id])
    Friending.create(user: current_user, friend: @user)
    flash[:success] = "You and #{@user.full_name} are now friends!"
    redirect_to referer
  end

  def destroy
    @user = User.find(params[:id])
    f = Friending.find_by(user: current_user, friend: @user)
    f.destroy
    flash[:success] = "You and #{@user.full_name} are no longer friends."
    redirect_to referer
  end
end
