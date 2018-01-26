class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  # locks down everything sitewide, then we'll go to other controllers to permit actions
  before_action :require_login, :set_return_to



  private

  def set_return_to
    session[:return_to] ||= request.referer
  end

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

  def current_user?
    params[:id].to_i == current_user.id || params[:user_id].to_i == current_user.id
  end
  helper_method :current_user?

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in!"
      redirect_to login_path  #< Remember this is a custom route
    end
  end

  def require_current_user
    unless current_user?
      respond_to do |format|
        format.html { redirect_to root_path, notice: "You're not authorized to view this" }
      end
    end
  end

end
