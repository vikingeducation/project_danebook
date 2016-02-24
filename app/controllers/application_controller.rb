class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def sign_in(user)
      user.regenerate_auth_token
      cookies[:auth_token] = user.auth_token
      @current_user = user
      @current_user == user && cookies[:auth_token] == user.auth_token
    end

    def permanent_sign_in(user)
      user.regenerate_auth_token
      cookies.permanent[:auth_token] = user.auth_token
      @current_user = user
    end

    def sign_out
      @current_user = nil
      cookies.delete(:auth_token)
      @current_user.nil? && cookies[:auth_token].nil?
    end

    def current_user
      @current_user ||= User.find_by_auth_token(cookies[:auth_token])
    end
    helper_method :current_user

    def signed_in_user?
      !!current_user
    end
    helper_method :signed_in_user?

    def current_user?
      params[:user_id] ||= params[:id]
      params[:user_id] == current_user.id.to_s unless current_user.nil?
    end
    helper_method :current_user?
    
    def require_login
      unless signed_in_user?
        flash[:error] = "Not authorized, please sign in!"
        redirect_to new_user_path
      end
    end

    def require_logout
      if signed_in_user?
        redirect_to user_path(@current_user)
      end
    end

    def require_current_user
      params[:id] ||= params[:user_id]
      unless params[:id] == current_user.id.to_s
        flash[:error] = "You're not authorized to view this"
        redirect_to current_user
      end
    end
end
