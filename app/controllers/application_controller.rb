class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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

  def signed_in?
     !!current_user
  end

  def require_signed_in
    unless signed_in?
      flash[:error] = "YOU NEED TO SIGN IN OR SIGN UP!"
      redirect_to root_url
    end
  end

  def require_new_user
    redirect_to user_profile_path(current_user) if current_user
  end

  def current_user?
    params[:user_id] == current_user.id.to_s
  end
  helper_method :current_user?

  def require_current_user
    unless current_user?
      flash[:error] = "You're not authorized to view this"
      redirect_to root_url
    end
  end

end
