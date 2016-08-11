class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

end
