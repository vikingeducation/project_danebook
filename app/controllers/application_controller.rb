class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in_user?, :require_current_user, :is_authorized?
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
    @current_user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  end

  def signed_in_user?
    !!current_user
  end

  def is_authorized?
    signed_in_user? && params[:user_id] == current_user.id.to_s
  end

  def require_login
    unless signed_in_user?
      flash[:error] = "Sorry, you need to be signed in to view this page"
      redirect_to root_path
    end
  end

  def require_current_user
    if current_user &&  params[:id] != current_user.id.to_s
      flash[:error] = "Sorry! You're not authorized to do that"
      return redirect_to root_path
    end
  end

end
