class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:user_id])
  end

  def edit
    @user = current_user
  end

  def update
    unless current_user.profile.update(profile_params)
      flash[:alert] = "Update Failed"
    end
    redirect_to user_profile_path(current_user)
  end

private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :about, :birthday)
  end

end
