class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.build_profile(profile_params)
    if @user.save
      sign_in(@user)
      flash.notice = "User created."
      redirect_to user_profile_path(@user)
    else
      flash.now[:error] = "Problems."
      render :new
    end
  end

  def destroy
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :birthdate, :gender)
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :birthdate, :gender)
  end

end
