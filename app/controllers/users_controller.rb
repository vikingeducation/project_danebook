class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_logged_out, :only => [:create, :new]
  def new
    @new = true
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      User.delay.send_welcome_email(@user.id)
      sign_in(@user)
      flash[:success] = "Welcome to Danebook!"
      redirect_to @user
    else
      flash[:danger] = @user.errors.first.join(" ")
      redirect_back(fallback_location: :new)
    end
  end

  def index
    @user = User.find( params[:id])
    @post = Post.new
    @posts = Post.where(user_id: params[:id]).reverse
  end

  def show
    @user = User.find_by_id(params[:id])
    @profile = @user.profile
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :remember_me, profile_attributes: [:birthday, :gender, :user_id])
  end

end
