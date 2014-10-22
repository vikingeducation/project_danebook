class UsersController < ApplicationController
  layout "login", only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelisted_params)

    if @user.save
      flash[:success] = "Welcome to Danebook!"
      redirect_to @user
    else
      flash[:error] = "Something went awry with your signup. Please make sure all your information was correct."
      redirect_to root_url
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def whitelisted_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
