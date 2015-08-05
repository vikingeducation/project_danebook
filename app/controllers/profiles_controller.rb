class ProfilesController < ApplicationController

  #before_action :set_user, only: [:new, :edit]

  def new
    if current_user.profile
      flash[:notice] = "No need to create a new profile. You can edit your existing one."
      redirect_to edit_profile_path
    else
      @profile = Profile.new
    end
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      flash[:success] = "Profile Updated!"
      redirect_to current_user
    else
      flash.now[:error] = @profile.errors.full_messages.first
      render :new
    end
  end

  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to current_user
    else
      flash.now[:error] = @profile.errors.full_messages.first
      render :edit
    end

  end

  private

  def profile_params
    params.require(:profile).permit(:college,
                                    :hometown,
                                    :current_home,
                                    :mobile,
                                    :summary,
                                    :about,
                                    :user_id)
  end

  # def set_user
  #   @user = current_user
  # end

end
