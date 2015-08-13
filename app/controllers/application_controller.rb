class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  rescue_from ActiveRecord::RecordNotFound, with: :not_found 
  rescue_from Exception, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  def raise_not_found
  raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def not_found
    if current_user
      flash[:failure]="No page found"
      redirect_to user_profile_path(current_user)
    else
      flash.now[:failure]="Please login"
      redirect_to root_path
    end
  end

  def error
    redirect_to root_path
  end
  private



  def sign_in(user)
   session[:user_id] = user.id
   @current_user = user
  end

  def sign_out
   @current_user = nil
   session.delete(:user_id)
  end

  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_user=(user)
   @current_user = user
  end

  def signed_in_user?
   !!current_user
  end
  helper_method :signed_in_user?

  def require_login
   unless signed_in_user?
     flash[:error] = "Please sign in first."
     redirect_to login_path
   end
  end

  def require_current_user
   unless User.find(params[:user_id]) == current_user
     flash[:error] = "Viewing not authorized."
   end
  end

  def store_referer
    session[:referer] = URI(request.referer).path
  end

  def referer
    session.delete(:referer)
  end

 
end
