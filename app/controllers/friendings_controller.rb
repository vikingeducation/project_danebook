class FriendingsController < ApplicationController
  before_action :required_user_redirect, except: [:index, :create]

  def index
    @user = User.find_by_id(params[:user_id])
  end

  def create
    current_user.followees << User.find(params[:user_id])
    flash[:notice] = "Friend Added"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friending = Friending.find_by_id(params[:id])
    if @friending
      @friending.destroy
      flash[:alert] = "Friendship terminated"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "We could not find that user"
      redirect_back(fallback_location: root_path)
    end
  end

end
