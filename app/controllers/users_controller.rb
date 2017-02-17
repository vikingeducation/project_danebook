class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def new
    reset_session
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @profile = @user.profile
    if @user.save
      flash[:success] = "Welcome to Danebook! Tell us some more about yourself!"
      sign_in(@user)
      redirect_to edit_user_profile_path(@user.id)
    else
      flash.now[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "It is done."
      redirect_to user_profile_path(current_user.id)
    else
      flash[:error] = "Your changes were not saved. Our apes are currently weeping openly in a mad dash to rectify this egregious blunder."
    end
  end

  def index
    @user = User.find_by_id(params[:id])
    @users = User.user_search(params[:query])
  end

  def show
    @user = User.find_by_id(params[:id])
    @posts = @user.authored_posts
    @post = current_user.authored_posts.build
  end

  def destroy
    if current_user.destroy
      flash[:success] = "Account deleted."
      sign_out
      redirect_to root_path
    else
      flash[:error] = "Oops! Something went wrong!"
      redirect_to edit_user_profile_path(current_user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :remember_me,
            profile_attributes: [
              :user_id,
              :birthday, 
              :gender,
              :college,
              :hometown,
              :city,
              :about_me,
              :words_to_live_by,
              :telephone,
              :profile_pic_id]
            )
  end

end
