class FriendingsController < ApplicationController

  def create
    current_user.followees << User.find(params[:user_id])
    if current_user.save
      flash[:notice] = "Friend Added"
    else
      flash[:alert] = "Friend could not be added"
    end
    redirect_to user_activities_path(params[:user_id])
  end

  def destroy
    @friending = Friending.find(params[:id])
    user = User.find(@friending.reciever_id)
    @friending.destroy
    flash[:alert] = "Friendship terminated"
    redirect_to user_activities_path(user)
  end

end
