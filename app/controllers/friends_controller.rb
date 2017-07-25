class FriendsController < ApplicationController


  def show
    @users = User.all
  end
end
