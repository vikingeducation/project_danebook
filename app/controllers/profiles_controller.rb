class ProfilesController < ApplicationController

  def show
    @user = User.find_by_id(params[:user_id])
  end

  def edit
    @profile = current_user.profile
  end

end
