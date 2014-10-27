class SessionsController < ApplicationController

  skip_before_action :require_login, :only => [:new, :create]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      params[:remember_me] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "Successful sign-on"
      redirect_to @user
    else
      flash[:error] = "Sign-in failed"
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end
end
