class UsersController < ApplicationController
  skip_before_action :require_sign_in, :only => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook"
      redirect_to @user
    else
      flash.now[:error] = "Account could not be created"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit( :first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :birthday,
                                  :gender )
  end
end
