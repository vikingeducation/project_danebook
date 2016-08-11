class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:notice] = "You've successfully signed in"
      redirect_to timeline_path
    else
      @user = User.new
      flash.now[:alert] = "Email and password do not match"
      render "static_pages/home"
    end
  end

  def destroy
    sign_out
    flash[:notice] = "You've successfully signed out"
    redirect_to root_path
  end

end
