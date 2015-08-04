class SessionsController < ApplicationController


  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      # if dont remember me, option not in view yet
      if params[:dont_remember_me]
        sign_in(@user)
      else #the default right now
        permanent_sign_in(@user)
      end
      flash[:success] = "You've successfully signed in"
      redirect_to root_path
    else
      flash[:error] = "We couldn't sign you in"
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end


end
