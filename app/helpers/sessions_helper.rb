module SessionsHelper

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

end
