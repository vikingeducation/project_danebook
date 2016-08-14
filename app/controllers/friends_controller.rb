class FriendsController < ApplicationController

  skip_before_action :correct_user

  def index
    @user = User.find(params[:id])
    @profile = @user.profile
    @friends = @user.friends.paginate(page: params[:page])
  end

  def create
    @user = User.find(friend_params[:friended_id])
    current_user.friends << @user
    flash[:success] = "You've added a friend!"
    raise
    redirect_to @user
  end

  private

    def friend_params
      params.require(:friend).permit(:friended_id)
    end
end
