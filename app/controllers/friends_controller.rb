class FriendsController < ApplicationController

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
    @friends = @user.friended_users
                    .includes(:friended_users)
                    .includes(:profile)
  end

end
