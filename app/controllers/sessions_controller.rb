class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Successfully signed in"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Unable to sign in"
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
