class SessionsController < ApplicationController

  skip_before_action :require_login, :only => [:new, :create]
  layout "login", only: [:destroy]

  def new
  end

  def create

    # if there's a provider, this login is an omniauth login
    omniauth = !!params[:provider]

    @user = omniauth ? User.from_omniauth(env["omniauth.auth"]) : User.find_by_email(params[:email])

    if @user && ( omniauth || @user.authenticate(params[:password]) )
      params[:remember_me] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "You're signed in."
      redirect_to newsfeed_url
    else
      flash[:error] = "Something went wrong with your signin."
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_path
  end
end
