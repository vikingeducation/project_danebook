class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.build_profile.save
      flash[:success] = "A thing a happened"
      redirect_to timeline_path
    else
      flash[:error] = "A thing didn't happend"
      render :new
    end
  end

  def edit
  end

  def index
  end

  def timeline
    # render :timeline
  end

  def about
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
