class ApplicationController < ActionController::Base

  include ApplicationHelper
  include ProfilesHelper

  protect_from_forgery with: :exception

  before_action :require_login

  private
  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    # session[:user_id] = user.id
    @current_user = user
  end

  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def signed_in_user?
    !!current_user
  end
  helper_method :current_user

  def sign_out
    @current_user = nil
    # session.delete(:user_id)
    cookies.delete(:auth_token)
  end

  def require_login
    unless signed_in_user?
      flash[:danger] = "You do not have permission to do this action."
      redirect_to new_user_path
    end
  end

  def require_current_user
    unless params[:id] == current_user.id.to_s || params[:user_id] == current_user.id.to_s #remove the second part, and use another method for checking comment creator etc.
      flash[:danger] = "Your are not authorized to do this."
      redirect_to root_url
    end
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  # def permanent_sign_in(user)
  #   user.regenerate_auth_token
  #   cookies.permanent[:auth_token] = user.auth_token
  #   @current_user = user
  # end

  def url_with_image?(url)
    url.match('\.(png|jpg|gif)$')
  end

end
