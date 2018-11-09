class ProfilesController < ApplicationController

  before_action :set_user
  before_action :require_login

  def show
  end


  def edit
    if params[:user_id].to_i == @current_user.id
      @profile = @current_user.profile
      render :edit
    else
      flash[:danger] = "Sorry - you may not edit another user's profile"
      redirect_to user_profile_path(params[:user_id])
    end
  end


  # def update
  #   @profile = @current_user.profile
  #   if @profile.update(profile_params)
  #     flash[:success] = "Successfully updated profile!"
  #     redirect_to user_profile_path(@current_user)
  #   else
  #     flash[:danger] = "Unable to update Profile"
  #     render action: :edit
  #   end
  # end

private

    def profile_params
      params.require(:profile).permit( :birthday,
                                       :college,
                                       :hometown,
                                       :current_town,
                                       :telephone,
                                       :words_to_live_by,
                                       :about_me,
                                       :cover_photo_id,
                                       :profile_photo_id
                                     )
    end



end
