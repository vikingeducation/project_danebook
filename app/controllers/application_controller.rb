class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user =user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:user_id)
  end
end
