class UsersController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = 'Welcome to Danebook!'
      redirect_to users_path
    else
      flash[:error] = "Sorry, there was something wrong with your form!"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
                          :first_name,
                          :last_name,
                          :email, 
                          :birth_date,
                          :birth_month,
                          :birth_year,
                          :gender,
                          :password, 
                          :password_confirmation)
  end

end
