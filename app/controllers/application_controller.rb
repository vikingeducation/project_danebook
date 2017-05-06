class ApplicationController < ActionController::Base
  include ApplicationHelper
  # helper_method :current_user, :signed_in_user?, :require_current_user, :is_authorized?
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, profile_attributes: [:first_name, :last_name]])
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      flash[:error] = "You must log in to continue."
      redirect_to new_user_session_path
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  private


  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end







end
