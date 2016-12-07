class UsersController < ApplicationController

  def index

  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      flash[:success] = "Welcome"
      redirect_to @user
    else
      flash[:error] = "Try again"
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def whitelisted_params
    params.require(:user).permit(:email, 
                                 :password, 
                                 :password_confirmation)
  end

end
