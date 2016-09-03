class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login, :except => [:new, :create]

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
    helper_method :current_user

    def signed_in_user?
      !!current_user
    end
    helper_method :signed_in_user?

    def require_login
      unless signed_in_user?
        flash[:danger] = ["Not authorized, please sign in!"]
        redirect_to signup_path
      end
    end

    def require_current_user
      unless params[:id] == current_user.id.to_s
        flash[:danger] = ["You're not authorized to view this"]
        redirect_to signup_path
      end
    end

    def store_referer
      session[:referer] = request.referer
    end

    def referer
      session.delete(:referer)
    end

    def active_class(link_path)
      "active" if request.fullpath == link_path
    end
    helper_method :active_class
end
