class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

    def require_logged_in_user
      unless current_user
        flash[:notice] = "You must be logged in to perform that action."
        redirect_to referer
      end
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

    def store_referer
      if request && request.referer
        session[:referer] = URI(request.referer).path
      else
        session[:referer] = root_path
      end
    end

    def referer
      session.delete(:referer)
    end

    def require_current_user
      unless current_user == @user
        flash[:notice] = "You cannot perform this action as a different user."
        redirect_to user_posts_path(@user)
      end
    end
end
