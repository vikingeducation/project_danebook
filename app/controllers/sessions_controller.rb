class SessionsController < ApplicationController
  #I think I always want a requirement
  # skip_before_action :require_login, :only => 
  def create
    binding.pry
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success]
      redirect_to user_path(@user.id)
    else
      flash.now[:error] = "We couldn't sign you in, try again!"
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_path
  end
end

