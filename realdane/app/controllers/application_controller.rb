class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :user_check

#private

  def sign_in(user)
    @current_user = user
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
  end
  
  def user_check
    redirect_to root_url unless get_user
  end
  
  def get_user
    current_user != nil
  end
  helper_method :get_user

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    redirect_to user_path(user)
  end

  def sign_out
    cookies.delete(:auth_token)
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user
  
  def user_signed_in?
    !!current_user
  end
  helper_method :user_signed_in?

end
