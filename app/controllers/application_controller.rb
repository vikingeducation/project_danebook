class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if User.where(:auth_token => cookies[:auth_token]).present?
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def is_current_user?(user)
    user.id == current_user.id
  end
  helper_method :is_current_user?


  protected
  def sign_in(user)
    cookies[:auth_token] = user.create_auth_token
    @current_user = user
    @current_user == user && cookies[:auth_token] == user.auth_token
  end

  def remember_sign_in(user)
    cookies.permanent[:auth_token] = user.create_auth_token
    @current_user = user
    @current_user == user && cookies[:auth_token] == user.auth_token
  end

  def sign_out
    @current_user = nil
    cookies.permanent[:auth_token] = cookies[:auth_token] = nil
    @current_user.nil? && cookies[:auth_token].nil?
  end

  def require_logout
    if signed_in_user?
      flash[:error] = 'Are you trying to signup a new user? Logout first!'
      redirect_to user_posts_path(current_user)
    end
  end

  def require_login
    unless signed_in_user?
      flash[:error] = 'Please sign in to perform that action'
      redirect_to signup_path
    end
  end

  def require_current_user
    user_id = controller_name == 'users' ? params[:id] : params[:user_id]
    unless current_user && user_id.to_i == current_user.id.to_i
      flash[:error] = 'You are unauthorized to perform that action'
      redirect_to root_path
    end
  end

  def redirect_to_referer(options={}, response_status={})
    options = options.empty? ? root_path : options
    redirect_to(
      request.referer ? request.referer : options,
      response_status
    )
  end
end


