class UsersController < ApplicationController

  skip_before_action :require_login, :only => [:index, :new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @profile = @user.build_profile(profile_params)
    if @user.save && @profile.save
      sign_in(@user)
      flash.notice = "User created."
      redirect_to user_profile_path(@user)
    else
      render :index
    end
  end

  def destroy
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @post = @user.posts.build
    @comment = Comment.new
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :birthdate, :gender)
  end

end
