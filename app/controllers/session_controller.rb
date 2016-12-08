class SessionController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "You've successfully signed in"
      redirect_to @user
    else
      flash[:danger] = "We couldn't sign you in"
      redirect_to new_user_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end

end
