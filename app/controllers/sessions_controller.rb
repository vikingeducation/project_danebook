class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      flash[:success] = 'You are now logged in'
      sign_in(@user)
      redirect_to user_profile_path(@user)
    else
      flash[:error] = 'An error has occurred'
      redirect_to new_user_path
    end
  end


  def destroy
    sign_out
    redirect_to root_path
  end
end
