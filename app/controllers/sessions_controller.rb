class SessionsController < ApplicationController

  # Whitelist.
  skip_before_action :logged_in_user, except: [:destroy]
  skip_before_action :correct_user

  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email])
    @profile = @user.profile
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      remember_check @user
      flash[:success] = 'Login successful.'
      redirect_to @user
    else
      flash[:danger] = 'Invalid username/password.'
      redirect_to new_session_path
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'You are now logged out.'
    redirect_to root_url
  end
end
