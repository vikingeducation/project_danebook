class ProfilesController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

end
