class FriendsController < ApplicationController

  include UserCheck
  before_action :set_user_basic_profile

  def show
    @friends = @user.friends
  end

  def create
    status, msg = Friendify.friendship(current_user, @user)
    flash[status] = msg
    redirect_to user_profile_path(@user.profile)
  end

  def destroy
    FriendsUser.
      where(user_id: @user.id, friend_id: current_user.id).
      or(
        FriendsUser.
          where(user_id: current_user.id, friend_id: @user.id)
        ).
      destroy_all

    redirect_to root_path
  end

end
