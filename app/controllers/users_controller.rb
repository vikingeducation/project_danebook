class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Danebook!"
      redirect_to @user
    else
      flash.now[:danger] = "You dun goofed."
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
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
