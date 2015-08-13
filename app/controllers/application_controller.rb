class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_valid_user

  private

  #the session-length cookie, not used right now
  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  #default option
  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  #delete the cookie
  def sign_out
    @current_user = nil
    cookies.delete(:auth_token) if cookies[:auth_token]
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
    # binding.pry
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in!"
      redirect_to login_path
    end
  end

  def require_current_user
    unless params[:user_id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this"
      redirect_to root_path
    end
  end

  def store_referer
    session[:referer] = URI(request.referer).path
  end

  def referer
    session.delete(:referer)
  end

  def object_owner?(thing)
    current_user.id == thing.user_id
  end
  helper_method :object_owner?

  def require_valid_user
    unless User.user_exists?(params[:user_id])
      flash[:error] = "This page doesn't exist"
      redirect_to user_posts_path(current_user.id)
    end
  end

end
