class UsersController < ApplicationController

  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created a new User!"
      redirect_to @user
    else
      flash.now[:danger] = "Failed to create User!"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :birthday,
      :gender)
  end
end
