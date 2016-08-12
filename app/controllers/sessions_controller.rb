class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash.notice = "You've signed in."
      redirect_to user_timeline_path(@user)
    else
      flash.notice = "The email and password you entered don't match. Please try again."
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash.notice = "You've signed out."
    redirect_to root_url
  end

end
