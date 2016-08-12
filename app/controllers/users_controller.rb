class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
    render 'static_pages/home'
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = 'User created!'
      redirect_to timeline_path
    else
      flash[:error] = 'Something went wrong :('
      render 'static_pages/home'
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
    @user = User.find(params[:id])
    render 'static_pages/about'
  end

  def index
  end

  def destroy
  end



  private

  def whitelisted_user_params
    params.require(:user).permit(:email,
      :password, :password_confirmation,
      :first_name, :last_name, :birthday)
  end
end
