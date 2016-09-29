class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private
  # Simply store our ID in the session
  # and set the current user instance var
  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  # reverse the sign in...
  def sign_out
    @current_user = nil
    session.delete(:user_id)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
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
      redirect_to login_path  #< Remember this is a custom route
    end
  end
  helper_method :require_login
end
