class ProfilesController < ApplicationController
  before_action :require_login, :only => [:index, :show, :update]
  before_action :current_user, :only => [:show, :update]

  def index
    @user = User.find(current_user.id)
    @profile = @user.profile
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    if @profile.update(whitelisted_profile_params)
      redirect_to user_profiles_path(current_user)
    else
      render :show
    end
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
                :phone_number,
                :year)
    end
end
