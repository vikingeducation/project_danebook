class ProfilesController < ApplicationController

  before_action :set_user


  def create
  end


  def show
  end


  def edit
    @profile = @current_user.profile
  end


  def update
    @profile = @current_user.profile
    if @profile.update!(profile_params)
      flash[:success] = "'About Me' successfully updated!"
      redirect_to user_profile_path
    else
      flash[:danger] = "Unable to update 'About Me'"
      render :edit
    end
  end


  def destroy
  end

private

    def profile_params
      params.require(:profile).permit( :college,
                                       :hometown,
                                       :current_town,
                                       :telephone,
                                       :words_to_live_by,
                                       :about_me )
    end



end
