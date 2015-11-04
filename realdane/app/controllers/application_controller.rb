class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#private

  def sign_in(user)
    @user = user
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    session[:user_id] = user.id
  end

  def get_user
    return true if @current_user != nil
    return false
  end
  helper_method :get_user

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    session.permanent[:user_id] = user.id
    redirect_to user_path(user)
  end

  def sign_out
    session[:user_id] = nil
    cookies.delete(:auth_token)
  end

  def current_user
    User.find[session[:user_id]] ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

end
