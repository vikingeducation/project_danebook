class ProfilesController < ApplicationController

  def create
    @profile = Profile.new(whitelisted_user_params)
    if @profile.save
      sign_in(@user)
      flash[:success]="Your account was successfully created!"
      redirect_to edit_user_path(@user)
    else
      flash.now[:error]="We couldn't create your account."
      render :new
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update

  end

  private

  def whitelisted_user_params
    params.require(:profile).permit(:birthdate, :id, :phone, :motto,
                                    :about, :college, :hometown,
                                    :location, :user_id)
  end
end
