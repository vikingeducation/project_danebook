class SessionController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Signed in"
      redirect_to @user
    else
      flash.now[:error] = "Sign in failed. Uh oh!"
      render root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed Out"
    redirect_to root_path
  end

end
