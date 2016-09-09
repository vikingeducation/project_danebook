class FriendingsController < ApplicationController
  def create
    @friending = Friending.new(friend_params)
    @user = User.find(@friending.friend_id)
    if @friending.save
      flash[:notice] = "Friending successfully created"
      redirect_to :back
    else
      flash[:notice] = "Friending has failed"

      redirect_to :back
    end
  end

  def destroy
    @friending = Friending.find(params[:id])
    @user = User.find(@friending.friend_id)
    if @friending.destroy
      flash[:success] = "Your Friending has been deleted!"
    else
      flash[:error] = "Error! The Friending lives on!"
    end

    redirect_to :back

  end

  def friend_params
    params.permit(:friender_id, :friend_id)
  end
end
