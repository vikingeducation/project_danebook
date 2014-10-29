class FriendingsController < ApplicationController


  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end

  def create
    @user = User.find(params[:user_id])
    current_user.friends << @user

    if current_user.save
      flash[:success] = "Added new friend!"
      redirect_to @user
    else
      flash[:error] = "You can't add that person right now."
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.friends.delete(@user)

    if current_user.save
      flash[:success] = "Unfriended!"
      redirect_to @user
    else
      flash[:error] = "You can't let that person go just yet."
      redirect_to @user
    end
  end
end