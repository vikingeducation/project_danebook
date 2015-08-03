class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Successfully signed in"
      redirect_to users_path
    else
      flash.now[:error] = "Unable to sign in"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to users_path
  end
end
