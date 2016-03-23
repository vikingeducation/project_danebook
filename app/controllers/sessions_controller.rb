class SessionsController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  
  def create

    @user = User.find_by_email(params["user"]["email"])
    if @user && @user.authenticate(params["user"]["password"])
      if params[:remember_me] 
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      #flash[:success] = "You've successfully signed in"
      redirect_to newsfeed_path(user_id: @user.id)
    else
      flash[:error] = "We couldn't sign you in"
      redirect_to root_url
    end
  end

  def destroy
   # another simple helper
   sign_out
   #flash[:success] = "You've successfully signed out"
   redirect_to root_url
  end

end
