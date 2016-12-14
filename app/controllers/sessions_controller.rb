class SessionsController < ApplicationController

  skip_before_action :require_login, :only => [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Welcome!"
      redirect_to user_timeline_path(current_user)
      # redirect_to edit_user_profile_url(current_user)
    else
      flash.now[:error] = "Couldn't log in"
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed Out"
    redirect_to root_url
  end


end
