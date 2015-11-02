class SessionsController < ApplicationController
    
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me] # <<<<<<<
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "You've successfully signed in"
      redirect_to root_url
    else
      flash.now[:error] = "Sign In failed"
      render :new
    end
  end
  
  
  def destroy
    # another simple helper
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end
    
end
