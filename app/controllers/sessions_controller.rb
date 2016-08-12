class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      redirect_to user_path(@user)
    else
      flash[:error] = "We couldn't sign you in"
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end

end
