class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

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

  def show
    
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Successfully updated profile!"
      redirect_to current_user
    else
      flash.now[:danger] = "Failed to update your profile!"
      render :edit
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
