class SessionsController < ApplicationController
  def new
    # figure out re-render for bad logins
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      flash[:success] = "Welcome back, #{@user.first_name}"
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      redirect_to @user
    else
      flash[:error] = "We had trouble signing you in. Please check your login details"
      render :new
    end
  end
end
