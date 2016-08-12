class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])

      # we'll put this logic into a simple helper
      sign_in(@user)

      flash[:success] = "You've successfully signed in"
      redirect_to user_profiles_path(@user)
    else
      flash[:error] = "We couldn't sign you in"
      redirect_to new_user_path
    end
  end

  def destroy
    # another simple helper
    sign_out
    flash[:success] = "You've successfully signed out"
    redirect_to root_url
  end
end
