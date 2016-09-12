class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def require_current_user!
    unless current_user == User.find_by_id(params[:id])
      flash[:danger] = "You are not authorized!"
      fail
      redirect_to root_path
    end
  end

  def fallback_location
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,
                                                       :avatar,
                                                       :about_me])
  end

  def after_sign_in_path_for(resource)
    newsfeed_path(current_user)
  end
end
