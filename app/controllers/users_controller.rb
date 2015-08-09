class UsersController < ApplicationController
  skip_before_action :direct_to_signup, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     sign_in(@user)
      flash[:success] = "A thing a happened"
      redirect_to edit_profile_path(@user.profile)
    else
      flash[:error] = "A thing didn't happened"
      render :new
    end
  end



  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
