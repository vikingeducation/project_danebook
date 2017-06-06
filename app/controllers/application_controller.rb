class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def sign_in(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def sign_out
    @current_user = nil
    session.delete(:user_id)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_current_user
    unless params[:id].to_i == current_user.id
      flash[:warning] = "Unauthorized action"
      redirect_to root_path
    end
  end

  def signed_in_user?
    !!current_user
  end

  helper_method :current_user
  helper_method :signed_in_user?


end
