class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  private

    helper_method :signed_in_user?
    helper_method :current_user
    helper_method :required_user?
    helper_method :created_by_user?
    helper_method :set_user
    helper_method :set_user_id
    helper_method :required_user_redirect

    def sign_in(user)
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
        flash[:alert] = "Not authorized, please sign in!"
        redirect_to login_path
      end
    end

    def require_current_user
      unless params[:id] == current_user.id.to_s
        flash[:alert] = "You're not authorized to do this"
        redirect_to root_path
      end
    end

    def required_user?
      params[:id] == current_user.id.to_s
    end

    def required_user_redirect
      unless params[:user_id] == current_user.id.to_s
        flash[:alert] = "You're not authorized to do this"
        redirect_to root_path
      end
    end

    def created_by_user?
      params[:user_id] == current_user.id.to_s
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
      unless @user
        flash[:alert] = "Unable to find that user"
        redirect_to user_activities_path(current_user)
      end
    end

    def set_user_id
      @user = User.find_by_id(params[:id])
      unless @user
        flash[:alert] = "Unable to find that user"
        redirect_to user_activities_path(current_user)
      end
    end

end
