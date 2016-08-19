class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def index
    @users = User.search(params[:search], current_user.id)
    @search_terms = params[:search]
  end

  def new
    @user = User.new
    if signed_in_user?
      redirect_to user_timeline_path(current_user)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      User.welcome_email(@user.id)
      sign_in(@user)
      flash[:success] = "Your account has been created"
      redirect_to user_timeline_path(@user)
    else
      flash.now[:danger] = "Account could not be created"
      render :new
    end
  end

  def show
    if User.find_by_id(real_user_id) == nil
      flash[:danger] = "Sorry, that user does not exist. But if you sign up your friends, someday we'll get there!"
      redirect_to user_timeline_path(current_user)
    end
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Your profile has been updated"
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Your profile could not be updated"
      render :edit
    end
  end

  def destroy

  end


  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 {:profile_attributes => [
                                  :first_name,
                                  :last_name,
                                  :birthday,
                                  :gender,
                                  :college,
                                  :hometown,
                                  :currently_lives,
                                  :telephone,
                                  :words_to_live_by,
                                  :about_me,
                                  :profile_picture,
                                  :cover_photo_id,
                                  :prof_photo_id
                                  ]})
  end

end
