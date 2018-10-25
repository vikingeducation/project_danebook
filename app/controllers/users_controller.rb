class UsersController < ApplicationController

  before_action :set_user, except: [:new, :create]
  before_action :require_login, except: [:new, :create]

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created New User Successfully!"
      redirect_to user_timeline_path(@user)
    else
      flash[:danger] = "Unable to Create New User"
      redirect_to root_path
    end
  end

  def show
  end

  def update
    if @current_user.update(user_params)
      flash[:success] = "Profile successfully updated!"
      redirect_to user_profile_path(@current_user)
    else
      flash[:danger] = "Unable to update Profile"
      redirect_to edit_user_profile_path(@current_user)
    end
  end

  def index
    @users = Profile.search(params[:user_query])
  end

  def timeline
    @photos = @current_user.photos
  end

  def friends
  end


private


  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:id, :last_name, :first_name, :birthday, :gender, :college, :hometown, :current_town, :telephone, :about_me, :words_to_live_by, :_destroy])
  end

end
