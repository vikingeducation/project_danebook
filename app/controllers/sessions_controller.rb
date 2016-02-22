class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:create]

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      params[:remember_me] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "You've successfully signed in"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Wrong username/password combination"
      redirect_to :back
    end
  end

  def destroy
    sign_out(@user)
    flash[:success] = "You've successfully signed out"
    redirect_to signup_path
  end
end
