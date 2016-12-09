class ApplicationController < ActionController::Base
  before_action :authenticate
  protect_from_forgery with: :exception

  private
    def crypt
      @crypt ||= ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    end

    def decrypt(msg)
      crypt.decrypt_and_verify(msg)
    end

    def encrypt(msg)
      crypt.encrypt_and_sign(msg)
    end

    def authenticate
      unless signed_in_user?
        flash[:danger] = ["Please sign in"]
        redirect_to login_path
      else
        incomplete_profile
      end
    end

    def create_session
      user = User.find_by_token(cookies[:token]) if cookies[:token]
      sign_in(user) if user
    end

    def current_user
      create_session unless session[:user_id]
      @current_user ||= User.includes(:profile).find_by_id(decrypt(session[:user_id])) if session[:user_id]
    end
    helper_method :current_user

    def incomplete_profile
      unless current_user.profile.edited
        flash.now[:info] = ["You have not completed your profile.", view_context.link_to("Please fill out your info here", edit_user_profile_path(current_user))]
      end
    end

    def sign_in(user, remember = false)
      reset_session
      if remember
        set_token(user)
      end
      session[:user_id] = encrypt(user.id)
      @current_user = user
    end

    def set_token(user)
      user.regenerate_auth_token
      cookies[:token] = user.token
    end

    def sign_out
      current_user.destroy_token
      @current_user = nil
      session.delete(:user_id)
      cookies.delete(:token)
      reset_session
    end


    def signed_in_user?
      !!current_user
    end
    helper_method :signed_in_user?

    def whitelisted_user_params
      params.require(:user).permit(:email,
                                   :password,
                                   :password_confirmation)
    end

end
