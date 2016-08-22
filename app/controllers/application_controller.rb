class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

   
  private

  def both_friends?(user)
    current_user ? current_user.friends.include?(user) && user.friends.include?(current_user) : false
  end

  def set_user
    @user = User.find_by_id(params[:user_id])
    redirect_to root_path, :flash=> {:danger => "Unable to find that user"} unless @user
  end

  def set_user_user_controller
    @user = User.find_by_id(params[:id])
    redirect_to root_path, :flash=> {:danger => "Unable to find that user"} unless @user
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
      flash[:danger] = "You are not logged in. Please login."
      redirect_to new_user_path
    end
  end

  def require_current_user
    unless current_user
      flash[:danger] = "You're not allowed there. Nice try."
      redirect_to "http://nouveller.com/404/"
    end
  end 


end
