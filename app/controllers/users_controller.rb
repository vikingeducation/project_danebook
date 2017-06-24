class UsersController < ApplicationController

  before_action :require_current_user, :only => [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create  
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Congratulated! You have successfully create an account!"
      redirect_to :about
    else
      flash[:notice] = "Error! We couldn't create your account!"
      render :new
    end
  end


  private
  def user_params
  params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
