class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:success] = 'You are now logged in'
    else
      flash[:error] = 'An error has occurred'
      redirect_to new_user_path
   end
  end
end
