class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def new
    if current_user
      flash[:success] = "Welcome back #{current_user.first_name}"
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "You've successfully signed in"
      redirect_to root_url
    else
      flash.now[:error] = "We couldn't sign you in"
      @user = User.new
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to login_path
  end
end
