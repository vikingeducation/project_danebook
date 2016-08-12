class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @post = Post.new
    @posts = current_user.posts
  end

  def new
    redirect_to current_user if signed_in_user?
    @user = User.new
    @profile = Profile.new

  end

  def create
    @user = User.new(whitelisted_user_params)
    @profile = @user.build_profile(whitelisted_profile_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "User was saved in database"
      redirect_to @user
    else
      flash[:error] = "User was NOT! saved in database"
      render :new
    end
  end

  def edit
  end

  def update
    #tobewritten
  end

  def destroy
    #tobewritten
  end

  private
    def set_user
      @user = User.find(current_user.id)
    end

    def whitelisted_user_params
      params.
        require(:user).
        permit( :username,
                :email,
                :password,
                :password_confirmation)

    end

    def whitelisted_profile_params
      params.
        require(:profile).
        permit( :first_name,
                :last_name,
                :month,
                :day,
                :year,
                :gender)
    end
end
