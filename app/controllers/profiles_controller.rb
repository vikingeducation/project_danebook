class ProfilesController < ApplicationController

  # before_action #check if currentuser = profile.user

  def create
    @profile = Profile.new(whitelisted_user_params)
    if @profile.save
      sign_in(@user)
      flash[:success]="Your account was successfully created!"
      redirect_to user_profile_path(current_user)
    else
      flash.now[:error]="We couldn't create your account."
      render :new
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(whitelisted_user_params)
      flash[:success] = "Successfully updated your profile"
      redirect_to user_profile_path(current_user)
    else
      flash.now[:failure] = "Failed to update your profile"
      render :edit
    end
  end

  private

  def whitelisted_user_params
    params.require(:profile).permit(:id, :phone, :motto,
                                    :about, :college, :hometown,
                                    :location, :user_id, :gender)
  end
end
