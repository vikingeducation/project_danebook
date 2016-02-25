class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]


  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Welcome to Danebook."
    else
      flash[:error] = "Failed to sign in"
    end
    redirect_to activities_path
  end


  def destroy
    sign_out
    flash[:success] = "You have been signed out."
    redirect_to login_path
  end


end
