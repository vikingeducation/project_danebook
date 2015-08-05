class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      permanent_sign_in(@user)
      flash[:success] = "You've successfully signed in!"
      redirect_to root_url
    else
      flash[:danger] = "Sign in failed.  Please try again."
      redirect_to :back
    end
  end


  def destroy
    sign_out
    flash[:success] = "You've successfully signed out!"
    redirect_to root_url
  end


end
