class ApplicationController < ActionController::Base
  # helper_method :current_user, :signed_in_user?, :require_current_user, :is_authorized?
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :is_self?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, profile_attributes: [:first_name, :last_name]])
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_path, :error => "Sorry, you need to be logged in to do that"
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  private
  def is_self?
    user_signed_in? && @user.id == current_user.id
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    user_profile_path(current_user)
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end



  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # def is_authorized?
  #   signed_in_user? && params[:user_id] == current_user.id.to_s
  # end

  # def require_login
  #   unless signed_in_user?
  #     flash[:error] = "Sorry, you need to be signed in to view this page"
  #     redirect_to root_path
  #   end
  # end

  # def require_current_user
  #   if current_user &&  params[:id] != current_user.id.to_s
  #     flash[:error] = "Sorry! You're not authorized to do that"
  #     return redirect_to root_path
  #   end
  # end

end
