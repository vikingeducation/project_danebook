class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_logged_out, :only => [:new, :create]

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
    @user = current_user
    if @user.update(user_params)
      redirect_to user_profile_path(@user.id)
    else
      flash[:error] = "Your changes were not saved. Our apes are currently weeping openly in a mad dash to rectify this egregious blunder."
    end
  end

  def edit
  end

  def destroy
  end

  def index
    @user = User.find_by_id(params[:id])
  end

  def show
    @user = User.find_by_id(params[:id])
    @posts = @user.authored_posts
    @post = current_user.authored_posts.build
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
