class UsersController < ApplicationController

  before_action :require_login, except: [:new, :show, :create]
  before_action :require_logout, only: [:new]
  before_action :require_current_user, only: [:edit, :update]

  # Signup Page
  def new
    @user = User.new
    @user.build_profile
  end

  # Any User's Timeline
  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      flash[:danger] = "That User Doesn't Exist!"
      @user = current_user
    end
    @profile = @user.profile
    @user.posts.build
  end

  # Create User
  def create
    @user = User.new(user_params)
    if @user.save(user_params)
      sign_in(@user)
      flash[:success] = "Created a new User!"
      redirect_to profile_path(@user)
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
      redirect_to user_path(@user)
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
