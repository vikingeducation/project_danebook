class SessionsController < ApplicationController
  skip_before_action :require_login
  
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Signed in!"
      redirect_to root_url
    else
      flash[:error] = "Couldn't sign in "
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've signed out!"
    redirect_to root_url
  end


end
