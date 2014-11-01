class UsersController < ApplicationController

  layout :choose_layout

  before_action :set_return_path, only: [:update]

  skip_before_action :require_login, only: [:new, :create]
  before_action :skip_login, only: [:new]


  # search function only
  def index
    @query = params[:query]
    @users = User.search(@query)
  end

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook!"
      redirect_to @user
    else
      flash[:error] = "Something went awry with your signup. Please make sure all your information was correct."
      redirect_to root_url
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_timeline_url(@user.id)
  end

  def edit
  end

  def update
    @user = current_user

    if params[:profile_photo_id]
      @user.profile_photo = @user.photos.find(params[:profile_photo_id])
    elsif params[:cover_photo_id]
      @user.cover_photo = @user.photos.find(params[:cover_photo_id])
    end

    if @user.save
      flash[:success] = "Photo updated."
    else
      flash[:error] = "Sorry, that didn't work."
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
  end

  private

  def whitelisted_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :profile_attributes => [:month, :day, :year, :gender, :user_id] )
  end

  def choose_layout
    case action_name
      when "index" then "search"
      when "new" then "login"
      else ""
    end
  end

  def skip_login
    redirect_to current_user if signed_in_user?
  end
end
