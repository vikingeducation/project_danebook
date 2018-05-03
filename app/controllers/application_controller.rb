class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  # before_action :require_login, except: [:new, :create]

private

  def set_user
    @current_user = User.find_by_auth_token(cookies[:auth_token])
  end


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


  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end


  def signed_in_user?
    !!@current_user
  end
  helper_method :signed_in_user?

  def current_user
    @current_user ||=
    User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user


  def require_login
    unless signed_in_user?
      flash[:danger] = "Not Authorized, please sign in!"
      redirect_to root_path
    end
  end


end
