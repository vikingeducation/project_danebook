class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login


  #Cookie-based auth, temporary and permanent, starts here

  def sign_in(user)
    user.regenerate_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  def permanent_sign_in(user)
    user.regenerate_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end


  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end

  # returns nil if no user logged in
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user #auto-included into view helpers

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user? #auto-included into view helpers

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized; please sign in!"
      redirect_to login_path
    end
  end

  def require_current_user
    unless params[:user_id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this."
      redirect_to root_url
    end
  end



#saves referring-page path to session for one-line go-back functionality
  def set_return_path
    session[:return_to] = request.referer
  end

end
