class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Make methods available to the View.
  helper_method :logged_in?, 
                :current_user, 
                :logged_in_user, 
                :correct_user, 
                :user_check

  # Authorization callbacks.
  before_action :logged_in_user
  before_action :correct_user

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #Store remember_token in remember digest and store cookies.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #Set remember digest to nil and delete cookies.
  def forget(user)
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  #Remember or forget user depending on whether checkbox is checked.
  def remember_check(user)
    remember_me = params[:session][:remember_me]
    return remember user if remember_me == '1'
    return forget user
  end
  
  # Controller filters to ensure proper authorization.
  def logged_in_user
    if !logged_in?
      flash[:notice] = "You must first log in."
      redirect_to login_path 
    end
  end

  def correct_user
    case current_user.id
    when params[:id].to_i, params[:user_id].to_i
      return true
    else
      flash[:notice] = "You are not authorized to access that page."
      redirect_to root_url
    end
  end

  # Same as logged_inuser and correct_user, but only returns a boolean.
  def user_check
    case current_user.id
    when params[:id].to_i, params[:user_id].to_i
      return true if logged_in?
    end
    false
  end

end
