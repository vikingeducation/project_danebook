class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      @user.build_profile.save
       #needs call back to save together.
      flash[:success] = "Thank you for signing up on Danebook!"
      sign_in
      redirect_to edit_user_profile
    else
      flash[:error] = "Aw, there was an error, try again!"
      render :new
    end
  end

  def edit
  end

  def index
  end

  def timeline
    # render :timeline
  end

  def about
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
