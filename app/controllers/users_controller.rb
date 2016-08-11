class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)  # <<<<<<<
      flash[:success] = "Created new user!"
      redirect_to about_path
    else
      flash[:error] = "Failed to Create User!"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :birth_date, :first_name, :last_name, :gender)
  end
end
