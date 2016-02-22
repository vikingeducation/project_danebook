class UsersController < ApplicationController

  before_action :require_login, except: [:new, :show, :create]
  before_action :require_logout, only: [:new]
  before_action :require_current_user, only: [:update]

  # Signup Page
  def new
    @user = User.new
    @user.build_profile
  end

  # Any User's Timeline
  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      @profile = @user.profile
      @posts = @user.posts.order("created_at DESC")
    else
      flash[:danger] = "That User Doesn't Exist!"
      if signed_in_user?
        @profile = current_user.profile
        current_user.posts.build
        @posts = current_user.posts.order("created_at DESC")
        redirect_to user_path(current_user)
      else
        redirect_to signup_path
      end
    end
  end

  # Create User
  def create
    @user = User.new(user_params)
    if @user.save(user_params)
      sign_in(@user)
      flash[:success] = "Created a new User!"
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Failed to create User!"
      @user.build_profile
      render :new
    end
  end

  # Create A Post via Nested Params
  def update
    if current_user.update(user_params)
      flash[:success] = "Success!"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "Failed!"
      redirect_to user_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :avatar,
      profile_attributes: [
        :gender,
        :birthday,
        :college,
        :from,
        :lives,
        :number,
        :words,
        :about
      ],
      posts_attributes: [:body]
    )
  end
end
