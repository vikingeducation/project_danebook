class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_signin
  before_action :require_current_user

  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def sign_out
    cookies.delete(:auth_token) && !(current_user = nil) 
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def current_user=(user)
    @current_user = user
  end

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_signin
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in!"
      redirect_to signin_path
    end
  end

  def require_current_user
    unless params[:user_id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this"
      redirect_to signin_url
    end
  end 
  
end
