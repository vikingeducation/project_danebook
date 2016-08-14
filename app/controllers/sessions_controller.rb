class SessionsController < ApplicationController

  # Whitelist.
  skip_before_action :logged_in_user, except: [:destroy]
  skip_before_action :correct_user
  before_action :set_user, only: [:create]
  before_action :activated_user

  def new
  end
  
  def create
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

  private 
    def set_user
      @user = User.find_by(email: params[:session][:email])
    end

    def activated_user
      unless @user.activated?
        flash[:danger] = "Your account has not yet been activated. Please check your email before continuing."
        redirect_to root_url
      end
    end
end
