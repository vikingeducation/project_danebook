class FriendsController < ApplicationController

  skip_before_action :correct_user, only: [:index]

  def index
    @user = User.find(params[:id])
    @profile = @user.profile
    @friends = @user.friends.paginate(page: params[:page])
  end

  def create
    @user = User.find(params[:id])
    @user.friends << User.find(friend_params[:user_id])
    flash[:success] = "You've added a friend!"
    redirect_to @user
  end

  private

    def friend_params
      params.require(:friend).permit(:user_id)
    end
end
