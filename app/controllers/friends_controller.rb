class FriendsController < ApplicationController

  def create
    @friend = Friend.new(friendee_id: params[:id], friender_id: current_user.id)
    if @friend.save
      flash[:success] = "Request sent"
      redirect_to :back
    else 
      flash[:danger] = "Error! Contact an admin!"
      redirect_to :back 
    end
  end

  def destroy
    @friend = Friend.where(friender_id: current_user.id, friendee_id: params[:id])
    if @friend.first.destroy
      flash[:success] = "Request revoked"
      redirect_to :back
    end

  end
end
