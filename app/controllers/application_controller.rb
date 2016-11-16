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
    @current_user =user
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

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in!"
      redirect_to root_path
    end
  end

  def authorized_user?(user = nil)
    if user
      user.id == current_user.id
    elsif params[:user_id]
      params[:user_id]==current_user.id.to_s
    else
      params[:id]==current_user.id.to_s
    end
  end
  helper_method :authorized_user?

  def can_delete_comment?(comment)
    current_user == comment.user
  end
  helper_method :can_delete_comment?

  def require_authorized_user
    unless authorized_user?
      flash[:error] = "You're not allowed to view that page"
      redirect_to root_path
    end
  end

end
