class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # http_basic_authenticate_with  :name => "foo",
  #                               :password => "bar",
  #                               :only => [:update, :create]
  #
  # USERS = { "foo" => "bar" }
  #
  # before_action :authenticate, only:[:update, :create]

  private

    # def authenticate
    #   authenticate_or_request_with_http_digest do |username|
    #     USERS[username]
    #   end
    # end

    # Simply store our ID in the session
  # and set the current user instance var
  def sign_in(user)
    user.regenerate_auth_token
    cookies[:auth_token] = user.auth_token
    @current_user = user
  end

  # reverse the sign in...
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

# Will turn the current_user into a boolean
# e.g. `nil` becomes false and anything else true.
  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in!"
      redirect_to root_url  #< Remember this is a custom route
    end
  end

  def require_current_user
    # don't forget that params is a string!!!
    #puts "CURRENT is #{current_user.id.to_s}and USER IS #{params[:user_id]} **"
    #puts "Current controller is #{params[:controller]}"

    if (params[:controller] == "users" && params[:id] != current_user.id.to_s) ||
       (params[:controller] != "users" && params[:user_id] != current_user.id.to_s) 
        flash[:error] = "You're not authorized to view this"
        redirect_to root_url
    end
  end 

  def current_user_view?
    params[:user_id] == current_user.id.to_s||
    (!params[:user_id] && params[:id] == current_user.id.to_s)
  end  
  helper_method :current_user_view?

  def not_yet_friends(user)
    current_user.initiated_friend_requests.where("friend_receiver_id = ?",@user.id).empty?
  end
  helper_method :not_yet_friends

  def find_user_by_email(email)
     User.find_by_email(email)
  end  
end
