class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
        flash[:success] = "You've successfully signed into Danebook!"
        redirect_to current_user
    else
      flash[:danger] = "We did not sign you into Danebook. Please provide a valid email and password"
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end
end