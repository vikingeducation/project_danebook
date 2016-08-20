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
    # Conditional for whether the user is in session.
    if id = session[:user_id]
      @current_user ||= User.find_by(id: id)
    # Log user in if he's not in session, but has a remember_token in cookie.
    elsif id = cookies.signed[:user_id]
      user = User.find_by(id: id)
      token = cookies[:remember_token]
      if user && user.authenticated?(:remember,token)
        log_in user
        @current_user = user
      end
    end
  end

  # Persist remember_token to remember digest column in the web server.
  # Store user id and remember token in cookies.
  def remember(user)
    user.remember
    # :httponly to prevent access to the cookie via scripting (XSS?).
    cookies.permanent.signed[:user_id] = { value: user.id, httponly: true }
    cookies.permanent[:remember_token] = { value: user.remember_token, httponly: true }
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

  def correct_profile
    case current_user.profile.id
    when params[:id].to_i
      return true
    else
      flash[:notice] = "You cannot edit this profile."
      redirect_to root_url
    end
  end

  def correct_like
    case current_user
    when Like.find(params[:id].to_i).user
      return true
    else
      flash[:notice] = "You cannot unlike someone else's like."
      redirect_to root_url
    end
  end

  def correct_timeline
    if referer = request.referer
      # Grab the id from the timeline path.
      timeline_id = referer.slice(/\d+\z/)
      return true if timeline_id.to_i == current_user.timeline_id
      flash[:danger] = "You cannot create a new post on someone else's timeline."
      redirect_to current_user
    else
      flash[:danger] = "You can only create a post on a timeline."
      redirect_to current_user
    end
  end

  # Same as logged_in_user and correct_user, but only returns a boolean.
  def user_check
    if current_user
      case current_user.id
      when params[:id].to_i, params[:user_id].to_i
        return true if logged_in?
      end
    end
    false
  end

  # Email notice on activity on user's timeline.
  def queue_like_email(user,resource)
    UserLikeJob.set(wait: 5.seconds).perform_later(user,resource)
  end

  def queue_comment_email(user,resource)
    UserCommentPostJob.set(wait: 5.seconds).perform_later(user,resource)
  end

end
