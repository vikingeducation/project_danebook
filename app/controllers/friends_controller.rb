class FriendsController < ApplicationController

  before_action :require_login

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends.includes(:profile_pic)
  end

end
