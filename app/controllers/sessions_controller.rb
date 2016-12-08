class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

    def new
      if signed_in_user?
        redirect_to users_path
      end
    end

    def create
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        sign_in(@user)
        flash[:success] = "Successfully signed in"
        redirect_to users_path
      else
        flash[:danger] = "Sorry, you couldn't be signed in"
        render :new
      end
    end

    def destroy
      sign_out
      flash[:success] = "You have successfully signed out"
      redirect_to signup_path
    end

end
