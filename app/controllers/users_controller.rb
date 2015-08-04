class UsersController < ApplicationController

  def new
    @user = User.new
    @user.birthdates.build
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success]="Your account was successfully created!"
      redirect_to root_path
    else
      flash[:error]="We couldn't create your account."
      render :new #currently blank page
    end
  end

  def show
  end

  private

  def whitelisted_user_params
    params.require(:user).permit( :first_name, :last_name, :email,
                                  :password, :password_confirmation,
                                  :id)
  end
end
