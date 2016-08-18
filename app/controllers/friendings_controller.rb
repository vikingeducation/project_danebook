class FriendingsController < ApplicationController

  def create
    current_user.followees << User.find(params[:user_id])
    flash[:notice] = "Friend Added"
    redirect_to user_activities_path(params[:user_id])
  end

  def destroy
    @friending = Friending.find_by_id(params[:id])
    if @friending
      user = User.find(@friending.reciever_id)
      @friending.destroy
      flash[:alert] = "Friendship terminated"
      redirect_to user_activities_path(user)
    else
      flash[:alert] = "We could not find that user"
      redirect_to user_activities_path(current_user)
    end
  end

end
