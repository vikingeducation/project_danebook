class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = 'User created!'
      redirect_to home_path
    else
      flash[:error] = 'Something went wrong :('
      redirect_to home_path
    end
  end

  def edit
  end

  def update
    if current_user.update(whitelisted_user_params)
      flash[:success] = 'Successfully updated your profile!'
      redirect_to current_user
    else
      flash.now[:failure] = 'Failed to update your profile'
      redirect_to root_url
    end
  end

  def show
  end

  def index
  end

  def destroy
  end



  private

  def whitelisted_user_params
    params.require(:user).permit(:email,
      :password, :password_confirmation)
  end
end
