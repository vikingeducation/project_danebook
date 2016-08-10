class UsersController < ApplicationController
  def new
    @user = User.new
    render "static_pages/home"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to timeline_path
    else
      flash[:error] = "Password #{@user.errors.messages[:password][0]}!"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,:password, :password_confirmation)
  end

end
