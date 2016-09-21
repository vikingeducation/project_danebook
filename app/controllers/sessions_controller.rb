class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]

  def new
    if signed_in_user?
      redirect_to user_timelines_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth
      @user = User.find_by_email_and_uid(auth["email"], auth["uid"]) || User.create_with_omniauth(auth)
      sign_in(@user)
      flash[:notice] = "You've successfully signed in"
      redirect_to user_timelines_path(@user)
    else
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        sign_in(@user)
        flash[:notice] = "You've successfully signed in"
        redirect_to user_timelines_path(@user)
      else
        @user = User.new
        flash.now[:alert] = "Email and password do not match"
        render "sessions/new"
      end
    end
  end

  def destroy
    sign_out
    flash[:notice] = "You've successfully signed out"
    redirect_to root_path
  end

end
