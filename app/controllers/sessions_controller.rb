class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "You have successfully signed in"
      redirect_to user_timeline_path(current_user)
    else
      flash[:danger] = "Incorrect log-in information. Please try again"
      redirect_to new_user_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to new_user_path
  end
end
