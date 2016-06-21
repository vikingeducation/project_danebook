class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Welcome !"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Nope, it didn't work"
      redirect_to(:back)
    end
  end

  def destroy
    if sign_out
      flash[:success] = "See you next time!"
    end
    redirect_to root_path
  end
end
