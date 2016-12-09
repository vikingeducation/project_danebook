class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_logged_out, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Danebook!"
      sign_in(@user)
      redirect_to @user
    else
      flash.now[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      render :new
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
    @user = User.find_by_id(params[:id])
    @profile = @user.profile
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :remember_me,
            profile_attributes: [:user_id, :birthday, :gender])
  end

end
