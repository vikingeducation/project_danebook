class SessionsController < ApplicationController


  def new
    @user = User.find_by_email(params[:email])
  end


  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
        flash[:success] = "User Signed in Successfully!"
        redirect_to user_timeline_path(@user)
      else
        sign_in(@user)
        flash[:success] = "User Signed in Successfully!"
        redirect_to user_timeline_path(@user)
      end
    else
      flash[:danger] = "Unable to sign in - Please check your email and password."
      redirect_to root_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Logged Out Successfully!"
    redirect_to root_path
  end



end
