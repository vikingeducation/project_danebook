class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user_id, :only => [:show]

  def index
    redirect_to user_activities_path(current_user)
  end

  def show
  end

  def create
    params[:user][:birthday] = get_date
    @user = User.new(user_params)
    if @user.save
      User.send_welcome_email(@user.id)
      sign_in(@user)
      flash[:success] = "User has been created!"
      redirect_to user_activities_path(@user)
    else
      flash.now[:warning] = @user.errors.full_messages
      render "static_pages/home"
    end
  end

  def edit
    @user = current_user
    current_user
  end

  def update
    @user = current_user
    params[:user][:birthday] = get_date if params[:user][:birthday]
    if @user.update(user_params)
      flash[:success] = "User has been updated!"
      redirect_to @user
    else
      flash.now[:warning] = @user.errors.full_messages
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
                                  :gender, :first_name, :last_name, :words_to_live, :about_me, :birthday, :college, :hometown, :tele, :current_add, :profile_photo_id, :cover_photo_id)
    end

    def get_date
      if (1900..2010).include?(params[:user][:year].to_i) && (1..12).include?(params[:user][:month].to_i) && (1..31).include?(params[:user][:day].to_i)
        create_date
      end
    end

    def create_date
      Date.new(params[:user][:year].to_i,
      params[:user][:month].to_i,
      params[:user][:day].to_i)
    end

end
