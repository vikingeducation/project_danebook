class FriendsController < ApplicationController


  def show
    @user = User.find(params[:user_id])
    @users = User.find(params[:user_id]).friended_users
  end

end
