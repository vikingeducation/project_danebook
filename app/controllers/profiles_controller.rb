class ProfilesController < ApplicationController

  before_action :require_current_user, only: [:edit, :update]

  def edit
  	@user = current_user
  	@profile = @user.profile
  end

  def update
    require_current_user
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to user_profile_path
    else
      flash[:error] = "Something has gone awry!"
      render :edit
    end
    # check if the user_id and user.id match/exist. If not, no profile.
  end

  def show
  	@user = User.find(params[:user_id])
  	@profile = @user.profile
  end

  def profile_params
    params.require(:profile).permit(:school,
                                    :hometown,
                                    :current_city,
                                    :life_words,
                                    :description)
  end
end
