class SessionsController < ApplicationController

  layout 'home_layout.html.erb'

  def new
    @user = User.new
    render "home"
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Thanks for signing in!"
      redirect_to timeline_path
    else
      flash.now[:error] = "Error! We couldn't sign you in."
      render :new
    end
  end

  def destroy
    if sign_out
      flash[:success] = "You have successfully signed out"
      redirect_to signin_path
    else
      flash[:error] = "Angry robots have prevented you from signing out.  You're stuck here forever."
      redirect_to timeline_path
    end
  end
  
end
