class ProfilesController < ApplicationController
  before_action :require_current_user, only: [:edit, :update]

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = current_user
    @profile = current_user.profile
  end

  def update
    @user = current_user
    @profile = current_user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(@user)
    else
      flash[:error] = "Something went wrong when saving your profile"
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:school,
                                    :hometown,
                                    :current_town,
                                    :phone_number,
                                    :quotes,
                                    :about)
  end
end
