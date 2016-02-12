class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]


  def new
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
      redirect_to user_timeline_path(@user)
    else
      flash[:error] = "Failed to sign in"
      redirect_to root_path
    end
  end


  def destroy
    sign_out
    flash[:success] = "You have been signed out"
    redirect_to root_path
  end


end
