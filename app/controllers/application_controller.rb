class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in"
      redirect_to request.referrer # halts request cycle
    end
  end

  def sign_in(user)
    user.regenerate_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permenant_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end


  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end

end
