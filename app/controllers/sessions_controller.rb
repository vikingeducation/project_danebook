class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password]) && sign_in(@user)
      flash[:success] = 'You are now signed in'
      redirect_to root_path
    else
      flash[:error] = 'Unable to sign in'
      redirect_to signup_path
    end
  end

  def destroy
    if current_user && sign_out
      flash[:success] = 'You are now signed out'
      redirect_to root_path
    else
      redirect_to request.referer
      flash[:error] = 'Unable to sign out'
    end
  end
end
