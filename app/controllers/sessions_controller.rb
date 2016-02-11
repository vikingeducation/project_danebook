class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      params[:remember_me] ? permament_sign_in(@user) : sign_in(@user)
      flash[:success] = "You've successfully signed in"
      redirect_to root_path
    else
      flash[:danger] = "Wrong username/password combination"
      redirect_to :back
    end
  end

  def destroy
    sign_out(@user)
    flash[:success] = "You've successfully signed out"
    redirect_to root_path
  end
end
