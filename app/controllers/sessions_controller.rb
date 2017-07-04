class SessionsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      permanent_sign_in(@user)
      flash[:success] = "Signed in successfully"
      redirect_to root_path
    else
      flash[:danger] = "Failed to log in"
      redirect_to root_path
    end
  end

  def destroy
    sign_out(current_user)
    flash[:success] = "Signed out successfully"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
