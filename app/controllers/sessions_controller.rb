class SessionsController < ApplicationController

  before_action :set_user, only: [ :new, :create ]


  def new
  end


  def create
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "User Signed in Successfully!"
      redirect_to user_newsfeed_path(@user)
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

private

  def set_user
    @user = User.find_by_email(params[:email])
  end



end
