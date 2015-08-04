class ProfilesController < ApplicationController
  def edit
    @profile = User.find(params[:user_id]).profile
  end

  def update
    @profile = User.find(params[:user_id]).profile
    if @profile.save
      flash[:success] = "Profile updated"
      redirect_to user_profile_path
    else
      flash[:error] = "Could not save"
      render :edit
    end
  end

  def show
    render :about
  end
end
