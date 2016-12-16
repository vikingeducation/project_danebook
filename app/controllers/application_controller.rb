class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private
  # Simply store our ID in the session
  # and set the current user instance var
  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  # reverse the sign in...
  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end

  # cookies!
  def current_user
    @current_user ||= User.includes(:profile).find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]

  end
  helper_method :current_user

  # Will turn the current_user into a boolean
  # e.g. `nil` becomes false and anything else true.
  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:danger] = "Not authorized, please sign in!"
      redirect_to root_path  #< Remember this is a custom route
    end
  end
  helper_method :require_login

  def current_user_page
    signed_in_user? && params[:id] && params[:id].to_i == current_user.id
  end
  helper_method :current_user_page
end
