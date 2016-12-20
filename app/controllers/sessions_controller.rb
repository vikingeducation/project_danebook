class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to root_path
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Welcome back, #{@user.first_name}."
      redirect_to @user
    else
      flash.now[:error] = "Sign-in unsuccessful."
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed out."
    redirect_to root_path
  end
end
