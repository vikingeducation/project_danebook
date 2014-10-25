class SessionsController < ApplicationController

	def create
	  @user = User.find_by_email(params[:email])
	  if @user && @user.authenticate(params[:password])
	    if params[:remember_me]
	      permanent_sign_in(@user)
	    else
	      sign_in(@user)
	    end
	    flash[:success] = "You've successfully signed in"
	    redirect_to root_path
	  else
	    flash.now[:error] = "We couldn't sign you in"
	    render :new
	  end
	end

	def destroy
    sign_out
    flash[:success] = "Signed Out"
    redirect_to root_path
  end


end
