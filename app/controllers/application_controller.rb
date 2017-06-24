class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  private
  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def sign_out
    @current_user = nil
    session.delete(:user_id)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:danger] = "You do not have permission to do this action."
      redirect_to new_users_path
    end
  end

  def require_current_user
    unless params[:id] == @current_user.id.to_s
      flash[:danger] = "Your are not authorized to do this."
      redirect_to root_url
    end
  end

end
