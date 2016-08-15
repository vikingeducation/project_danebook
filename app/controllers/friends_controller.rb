class FriendsController < ApplicationController

  skip_before_action :correct_user
  before_action :existing_user, only: [:create]
  before_action :friend_self, only: [:create]

  def index
    @user = User.find(params[:id])
    @profile = @user.profile
    @friends = @user.friends.paginate(page: params[:page])
  end

  def create
    @user = User.find(friend_params[:friended_id])
    current_user.friends << @user
    flash[:success] = "You've added a friend!"
    redirect_to @user
  end

  private

    def friend_params
      params.require(:friend).permit(:friended_id)
    end

    def existing_user
      return true if User.where(id: friend_params[:friended_id])
      flash[:danger] = "Can't add non-existent user."
      redirect_to request.referer
    end

    def friend_self
      if friend_params[:friended_id] == current_user.id
        flash[:danger] = "Can't add yourself as a friend."
        redirect_to request.referer
      end
    end
end
