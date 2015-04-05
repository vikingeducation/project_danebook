class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

  def signed_in_user?
    !!current_user
  end
  helper_method :signed_in_user?

  def require_login
    unless signed_in_user?
      flash[:error] = "Not authorized, please sign in"
      redirect_to root_path
    end
  end

  def require_current_user
    unless current_user && params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized to access this page"
      redirect_to root_path
    end
  end

  def post_it
    Post.create(
      :content => params["post"]["content"],
      :user_id => current_user.id
      )
  end

  def comment_it
    Comment.create(
      :content => params["comment"]["content"],
      # :user_id => current_user.id,
      :post_id => post.id
      )
  end
end
