class UsersController < ApplicationController
  layout "login", only: [:new]

  skip_before_action :require_login, only: [:new, :create]
  before_action :skip_login, only: [:new]
  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(whitelisted_params)
    asdfjklasfjkl
    if @user.save!
      sign_in(@user)
      flash[:success] = "Welcome to Danebook!"
      redirect_to @user
    else
      flash[:error] = "Something went awry with your signup. Please make sure all your information was correct."
      redirect_to root_url
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_timeline_url(@user.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def whitelisted_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :profile_attributes => [:month, :day, :year, :gender, :user_id] )
  end

  def skip_login
    redirect_to current_user if signed_in_user?
  end
end
