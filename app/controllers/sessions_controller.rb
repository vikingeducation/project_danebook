class SessionsController < ApplicationController
  skip_before_action :require_sign_in, :only => [:create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Signed in"
      redirect_to @user
    else
      flash[:error] = "Sign in failed. Uh oh!"
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed Out"
    redirect_to root_path
  end

end
