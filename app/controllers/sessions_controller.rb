
class SessionsController < ApplicationController

  skip_before_action :require_login, :only => [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "You have successfully signed in"
      redirect_to @user
    else
      flash[:danger] = "We couldn't signed you in"
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    flash[:success] = "You have successfully signed out"
    redirect_to root_url
  end
end
