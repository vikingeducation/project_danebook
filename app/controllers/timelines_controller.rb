class TimelinesController < ApplicationController

  def index
    @user = current_user
    @friends = @user.friended_users
  end
end

