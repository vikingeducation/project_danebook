class FriendingsController < ApplicationController

  before_action :require_login, only: [:create, :destroy]

  def create
    friending_recipient = User.find_by_id(params[:id])
    @friending = Friending.new(friender: current_user, friended: friending_recipient)
    if @friending.save
      flash[:success] = "Successfully friended #{friending_recipient.name}"
      redirect_to friending_recipient
    else
      flash[:danger] = "Failed to friend!"
      redirect_to friending_recipient
    end
  end

  def destroy
    friending_recipient = User.find_by_id(params[:id])
    @friending = Friending.find_by_friender_id_and_friended_id(current_user.id, friending_recipient.id)
    if @friending && @friending.destroy
      flash[:success] = "Successfully unfriended"
      redirect_to :back
    else
      flash[:danger] = "Failed to unfriend"
      redirect_to current_user
    end
  end

  def show
    @user = User.find(params[:id])
    @friendeds = @user.friendeds
    @profile = @user.profile
  end
end
