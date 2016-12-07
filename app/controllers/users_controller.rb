class UsersController < ApplicationController

  def new
    @user = User.new
    render :new, layout: "new_user"
  end

  def create
    @user = User.new(strong_user_params)
    if @user.save
      flash[:success] = "Welcome to Danebook!"
      sign_in(@user)
      redirect_to @user
    else
      flash[:warning] = "Unable to create you."
      render :new
    end
  end

  private

    def strong_user_params
      params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :birthday, :sex, :email, profile_attributes: [:birthday, :sex])
    end
end
