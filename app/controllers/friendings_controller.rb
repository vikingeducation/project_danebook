class FriendingsController < ApplicationController
  before_action :store_referer
  before_action :require_logged_in_user
  before_action :find_user


  def create
    if Friending.create(user: current_user, friend: @user)
      flash[:success] = "You and #{@user.full_name} are now friends!"
    else
      flash[:notice] = "Unable to friend user #{@user.full_name}."
    end
    redirect_to referer
  end

  def destroy
    f = Friending.find_by(user: current_user, friend: @user)
    if f.destroy
      flash[:success] = "You and #{@user.full_name} are no longer friends."
    else
      flash[:notice] = "Unable to unfriend user #{@user.full_name}."
    end
    redirect_to referer
  end

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to referer unless @user
  end
end
