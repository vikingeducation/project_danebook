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
      redirect_to @user
    else
      flash.now[:error] = "Couldn't log in"
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = "Signed Out"
    redirect_to root_url
  end


end
