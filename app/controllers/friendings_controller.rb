class FriendingsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @users = @user.friends
  end

  def create
    @user = User.find(params[:id])
    @friending = Friending.new(friendee_id: @user.id, friender_id: current_user.id )
    if @friending.save
      flash[:success] = "#{@user.first_name} added to your friends!"
      redirect_back( fallback_location: proc { user_path(@user) } )
    else
      flash[:error] = "Unable to friend #{@user.first_name}"
      redirect_back( fallback_location: proc { user_path(@user) } )
    end
  end

  def destroy
    @user = User.find(params[:id])
    @friending = Friending.where(friendee_id: @user.id, friender_id: current_user.id).first
    if @friending.destroy
      flash[:success] = "#{@user.first_name} is no longer your friend"
      redirect_back( fallback_location: proc { user_path(@user) } )
    else
      flash[:error] = "Could not unfriend #{@user.first_name}"
      redirect_back( fallback_location: proc { user_path(@user) } )
    end

  end

end
