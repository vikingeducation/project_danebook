class ProfilesController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = "Changes saved!"
      redirect_to current_user
    else
      flash[:error] = "Unable to save changes"
      redirect_to current_user
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:id, :user_id, :college, :hometown, :current_location, :telephone, :about_me, :words_to_live_by)
  end
end
