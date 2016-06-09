class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(permitUserParams)
    if @user.save
      flash.now[:success] = 'You have successfully signed up!'
      redirect_to login_path
    else
      flash.now[:danger] = 'Invalid information. Please try again to sign up.'
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
    def permitUserParams
      permissibleUserParams = [:first_name,
                               :last_name,
                               :email,
                               :password, 
                               :password_confirmation]
      params.require(:user).permit(permissibleUserParams)
    end
end
