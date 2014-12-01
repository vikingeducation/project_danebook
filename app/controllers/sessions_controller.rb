class SessionsController < ApplicationController

  skip_before_action :require_login, :only => [:new, :create]
  layout "login", only: [:destroy]

  def new
  end

  def create

    # if there's a provider, this login is an omniauth login
    omniauth = !!params[:provider]

    e = env["omniauth.auth"]
    logger.info "omniauth info: #{e}"

    @user = omniauth ? User.from_omniauth(e) : User.find_by_email(params[:email])

    if @user && ( omniauth || @user.authenticate(params[:password]) )
      params[:remember_me] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "You're signed in."
      redirect_to [ @user, :newsfeed ]
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
