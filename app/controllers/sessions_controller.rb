class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_by_email(params[:email]) || User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    if @user && @user.authenticate(params[:password])
      params[:remember_me] ? permanent_sign_in(@user) : sign_in(@user)
      flash[:success] = "You've successfully signed in"
      redirect_to current_user
    else
      flash.now[:error] = "Wrong email/password combination, please try again!"
      @user = User.new
      render 'users/new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_path
  end

end
