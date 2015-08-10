class FriendsController < ApplicationController

  before_action :require_login

  def index
    @user = User.includes(:friends).find(params[:user_id])
    @friends = @user.friends
  end

end
