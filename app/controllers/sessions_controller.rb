class SessionsController < ApplicationController

  skip_before_action :require_login, :only=>[:new, :create]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      permanent_sign_in(@user)
    
      flash[:success] = "You've successfully signed in"
      redirect_to user_profiles_path(current_user)
    else
      flash[:error] = "We couldn't sign you in"
      redirect_to new_user_path(@user)
    end

  end

  def destroy
    # another simple helper
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to new_user_path
  end
end
