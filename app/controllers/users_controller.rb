class UsersController < ApplicationController
  before_action :set_user_user_controller, only: [:edit, :update, :destroy, :show]
  before_action :require_login, except: [:new, :create, :show]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.search(params[:search])
  end

  def edit
    
  end

  def update
    if current_user.update(user_params) 
      flash[:success] = "Your Danebook profile has been updated"
      redirect_to user_profiles_path(current_user) 
    else
      flash[:danger] = "Failed to update your Danebook profile" + 
        current_user.errors.full_messages.join(", ")
      redirect_to user_profiles_path(current_user) 
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook!"
      redirect_to user_profiles_path(current_user)
    else
      flash.now[:danger] = "Please fill out all fields and make sure your password and password confirmation match"
      render :new
    end
  end

  def destroy
  end

  def show
    @profile = @user.profile
    @post = current_user.posts.build if current_user
    @comment = @post.comments.build if current_user
    @like = @post.likes.build if current_user
    @posts = @user.all_posts
    @photos = Photo.newest_six(@profile)
  end

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, 
        profile_attributes: [:about_me, :words_to_live_by, :telephone, :current_location, :hometown, :college, :id, :birthday])
    end

end
