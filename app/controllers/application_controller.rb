class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # before_action :require_login

  helper_method :current_user
  helper_method :signed_in_user?


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
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def signed_in_user?
    !!current_user
  end

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in!"
      redirect_to root_path
    end
  end

  def require_account_owner
    unless signed_in_user? && cookies[:auth_token] == current_user.auth_token
      flash[:error] = "You aren't authorized to perform this action."
      if signed_in_user?
        redirect_to user_timeline_path(curent_user)
      else
        redirect_to root_path
      end
    end
  end

  def page_owner
    @page_owner = User.find(params[:user_id])
  end

  def friendship
    @friendship = Friendship.where("(friender_id = #{current_user.id} AND friended_id = #{@page_owner.id}) OR (friended_id = #{current_user.id} AND friender_id = #{@page_owner.id})").first
  end

  def set_instance_variables
    @user = current_user
    @profile = @user.profile if @user
    page_owner
    friendship
  end
  
end
