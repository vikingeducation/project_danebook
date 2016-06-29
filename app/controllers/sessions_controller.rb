class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember_check user
      flash[:success] = 'Login successful.'
      redirect_to user, locals: { user: user }
    else
      render 'sessions/new', locals: { user: user }
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'You are now logged out.'
    redirect_to root_url
  end
end
