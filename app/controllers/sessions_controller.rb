class SessionsController < ApplicationController
skip_before_action :direct_to_signup, only: :create

  def create
    # fail
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      sign_in(@user)
      flash[:success] = 'You are now logged in'
      redirect_to profile_timeline_path(current_user.profile)
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
