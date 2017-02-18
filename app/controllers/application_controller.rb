class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def go_back
    redirect_to URI(request.referer).path
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
      flash[:warning] = "Our apes have determined that you need a registered account with proper authorization to perform that action. They are hooting at you with mild menace."
      redirect_to new_user_path
    end
  end

  def require_current_user
    # the params are a string
    unless params[:id] == current_user.id.to_s
      flash[:error] == "You're not authorized to do that, pal."
      redirect_to root_url
    end
  end

  def require_logged_out
    redirect_to posts_path if signed_in_user?
  end

end
