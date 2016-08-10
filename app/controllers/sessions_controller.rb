class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])

      sign_in(@user)
      flash[:success] = "You've successfuly signed in!"
      redirect_to timeline_path
    else
      flash.now[:error] = "We couldn't sign you in"
      render root_home
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_path
  end
end
