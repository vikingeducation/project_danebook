class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_logged_out, :only => [:new, :create]

  def new
    reset_session
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Danebook!"
      sign_in(@user)
      redirect_to @user
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
    @user = current_user
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
              :telephone],
            post_attributes: [
              :body])
  end

end
