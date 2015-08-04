class UsersController < ApplicationController
  after_action :build_profile, :only => [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "A thing a happened"
      redirect_to edit_user_path(@user)
    else
      flash[:error] = "A thing didn't happened"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
  end

  def timeline
    # render :timeline
  end

  def about
  end

  def build_profile
    @user.build_profile.save
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
