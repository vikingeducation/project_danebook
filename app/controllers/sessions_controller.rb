class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      sign_in(@user)
      flash[:success] = 'You are now logged in'
      redirect_to user_timeline_path(@user)
    else
      flash[:error] = 'An error has occurred'
      redirect_to new_user_path
   end
  end

  def destroy
    sign_out
    redirect_to new_user_path
  end
end
