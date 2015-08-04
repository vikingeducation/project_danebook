class ProfilesController < ApplicationController

  before_action :find_profile

  def edit
  end

  def update
    if @profile && @profile.update(whitelisted_profile_params)
      flash[:success] = "Your profile is successfully updated!"
      redirect_to @profile
    else
      flash[:error] = "Something went wrong. Try again."
      render :edit
    end
  end

  def show
  end

  private

  def find_profile
    @profile = Profile.find(params[:id])
  end

  def whitelisted_profile_params
    params.require(:profile).permit(:college,
                                    :hometown,
                                    :current_lives,
                                    :telephone,
                                    :words_to_live_by,
                                    :about_me)
  end
end
