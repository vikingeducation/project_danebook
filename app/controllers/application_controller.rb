class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in_user?, :require_current_user, :is_authorized?
  protect_from_forgery with: :exception
  before_action :authenticate_user!


  private



  def permanent_sign_in(user)
    user.regenerate_auth_token
    cookies.permanent[:auth_token] = user.auth_token
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.delete(:auth_token)
  end



  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # def is_authorized?
  #   signed_in_user? && params[:user_id] == current_user.id.to_s
  # end

  # def require_login
  #   unless signed_in_user?
  #     flash[:error] = "Sorry, you need to be signed in to view this page"
  #     redirect_to root_path
  #   end
  # end

  # def require_current_user
  #   if current_user &&  params[:id] != current_user.id.to_s
  #     flash[:error] = "Sorry! You're not authorized to do that"
  #     return redirect_to root_path
  #   end
  # end

end
