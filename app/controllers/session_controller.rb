class SessionController < ApplicationController
  skip_before_action :require_login, :only => [:create]
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me] 
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "You've successfully signed in"
      redirect_to posts_index_path
    else
      flash[:danger] = "We couldn't sign you in"
      redirect_to new_user_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to new_user_path
  end

end
