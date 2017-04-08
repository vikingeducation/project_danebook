class UsersController < ApplicationController

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Success! Welcome to Danebook, #{@user.first_name}"
      redirect_to @user
    else
      flash[:error] = "We couldn't sign you up. Please check the form for errors"
      render :new
    end
  end

  private

  def user_params
    # TODO add birthdate
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:id, :sex, :first_name, :last_name, :'birthdate(1i)', :'birthdate(2i)', :'birthdate(3i)'])
  end
end
