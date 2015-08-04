class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      flash[:success] = 'You are now logged in'
      fail
      redirect_to timeline_path
    else
      flash[:error] = 'An error has occurred'
      fail
      redirect_to new_user_path
   end
  end
end
