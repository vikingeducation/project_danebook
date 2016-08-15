class SessionsController < ApplicationController

  # Whitelist.
  skip_before_action :logged_in_user, except: [:destroy]
  skip_before_action :correct_user
  before_action :set_user, only: [:create]
  before_action :validate_credentials, only: [:create]

  def new
  end
  
  def create
    @profile = @user.profile
    log_in @user
    remember_check @user
    flash[:success] = 'Login successful.'
    redirect_to @user
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

    def validate_credentials
      if @user.activated?
        unless @user && @user.authenticate(params[:session][:password])
          flash[:danger] = 'Invalid username/password.'
          redirect_to login_path
        end
      else
        flash[:danger] = "Your account has not yet been activated. Please check your email before continuing."
        redirect_to root_url
      end
    end
end
