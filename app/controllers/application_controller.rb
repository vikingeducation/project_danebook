class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

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
      flash[:error] = "Not authorized, please sign in!"
      redirect_to root_path
    end
  end

  def require_current_user
    unless params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized for that action!"
      redirect_to root_path
    end
  end


  private

end
