class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login


  private

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

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:danger] = "Not authorized, please sign in!"
      redirect_to root_path
    end
  end

  def require_current_user
    # don't forget that params is a string!!!
    unless page_user_id == current_user.id
      redirect_to about_user_path(page_user_id)
    end
  end

  def self_profile?
    current_user.id == page_user_id
  end
  helper_method :self_profile?

  def page_user_id
    controller_name == "users" ? params[:id].to_i : params[:user_id].to_i
  end
end
