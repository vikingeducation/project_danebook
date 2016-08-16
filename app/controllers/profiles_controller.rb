class ProfilesController < ApplicationController
  before_action :require_login, :only => [:timeline, :show]

  def index
    @user = User.find(params[:user_id])
    @profile = Profile.find(current_user.profile.id)
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @profile = Profile.find(current_user.profile.id)
    if @profile.update(whitelisted_profile_params)
      redirect_to user_profiles_path(current_user)
    else
      render :show
    end

  end

  def timeline
  end

  def friends
    flash[:notice] = "have yet to implement"
  end

  def photos
    flash[:notice] = "have yet to implement"
  end

  private

    def whitelisted_profile_params
        params.
          require(:profile).
          permit( :college,
                  :home_town,
                  :currently_lives,
                  :phone_number)
      end
end
