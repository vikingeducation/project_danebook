# Profiles Controller
class ProfilesController < ApplicationController
  before_action :current_profile, except: [:show, :edit]

  def show
    @user = User.find(params[:user_id])
  end

  def edit
    @user = current_user
  end

  def update
    unless @current_profile.update(profile_params)
      flash[:alert] = 'Update Failed'
    end
    redirect_to user_profile_path(current_user)
  end

  def set_picture
    session[:return_to] = request.referer
    if @current_profile.update_attribute(:picture_id,
                                         params[:picture_id]) &&
       Photo.exists?(params[:picture_id])
      flash[:success] = 'Updated Profile Picture'
    else
      flash[:error] = 'Could Not Set Profile Picture'
    end
    redirect_to session.delete(:return_to)
  end

  def set_cover
    session[:return_to] = request.referer
    if @current_profile.update_attribute(:cover_id,
                                         params[:picture_id]) &&
       Photo.exists?(params[:picture_id])
      flash[:success] = 'Updated Cover Photo'
    else
      flash[:error] = 'Could Not Set Cover Photo'
    end
    redirect_to session.delete(:return_to)
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name,
                                    :last_name,
                                    :about,
                                    :birthday,
                                    :picture_id,
                                    :profile_id)
  end

  def current_profile
    @current_profile = current_user.profile
  end
end
