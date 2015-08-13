class LoginsController < ApplicationController
  before_filter :store_referer
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me] # <<<<<<<
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "You've successfully signed in!"
      redirect_to user_posts_path(@user, newsfeed: true)
    else
      flash[:error] = "You could not be signed in. Please try again."
      redirect_to new_user_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "You've signed out!"
    redirect_to new_user_path
  end
end
