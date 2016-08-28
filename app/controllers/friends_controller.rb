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
    if current_user.friends << @user
      flash[:success] = "You've added a friend!"
      redirect_to @user
    else
      flash[:danger] = "Couldn't add this user as a friend."
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(friend_params[:friended_id])
    if @user.friend?(current_user)
      current_user.unfriend(@user)
      flash[:success] = "You've unfriended #{@user.full_name}."
      redirect_to @user.timeline
    end
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
      if friend_params[:friended_id].to_i == current_user.id
        flash[:danger] = "Can't add yourself as a friend."
        redirect_to current_user.timeline
      end
    end
end
