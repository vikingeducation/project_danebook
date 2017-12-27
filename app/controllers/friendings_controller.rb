class FriendingsController < ApplicationController
  before_action :require_current_user => [:create, :destroy, :show]

  def show
    @friends = current_user.users_friended_by
  end

  def create
    @new_friending = Friending.new(friending_params)
    if @new_friending.save
      flash[:success] = "Added a friend!"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Failed to add a friend"
      redirect_to user_path(current_user)
    end
  end

  def destroy
    @friending = Friending.find(params[:id])

    if @friending.destroy
      redirect_to user_path(current_user)
      flash[:success] = "Removed friend successfully."
    else
      redirect_to user_path(current_user)
      flash[:error] = "Failed to remove friend"
    end
  end
  
  private
  def friending_params
    params.require(:friending).permit(:friend_id, :friender_id)
  end
end
