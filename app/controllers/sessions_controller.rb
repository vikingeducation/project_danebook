class SessionsController < ApplicationController
  before_action :require_logout, :only => [:create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        remember_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = 'You are now signed in'
      redirect_to news_feed_path
    else
      flash[:error] = 'Unable to sign in'
      redirect_to signup_path
    end
  end

  def destroy
    if current_user && sign_out
      flash[:success] = 'You are now signed out'
      redirect_to root_path
    else
      redirect_to_referer
      flash[:error] = 'Unable to sign out'
    end
  end
end
