class FriendsController < ApplicationController


  def show
    @user = User.find(params[:user_id])
    @users = User.find(params[:user_id]).friended_users
  end

  def index
    # @users = User.find_by_search
  end

end
