class SessionsController < ApplicationController

  skip_before_action :require_login, :only => [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      flash[:error] = "Couldn't log in"
      redirect_to new_user_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed Out"
    redirect_to new_user_path
  end


end
