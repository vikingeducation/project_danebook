class UsersController < ApplicationController
  #ADD UNIQUE CONSTRAINT TO USER EMAIL
  #ADD VALIDATIONS FOR USER ATTRIBUTES
  #UPDATE FORM TO RAILS FIELDS
  skip_before_action :require_login, :only => [:create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    redirect_to :timeline
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    params[:user][:birthday] = get_date
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "User has been created!"
      redirect_to :timeline
    else
      flash.now[:warning] = @user.errors.full_messages
      render "static_pages/home"
    end
  end

  def edit
    current_user
  end

  def update
    @user = User.find(params[:id])
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
                                  :gender, :first_name, :last_name, :words_to_live, :about_me, :birthday, :college, :hometown, :tele, :current_add)
    end

    def get_date
      Date.new(params[:user][:year].to_i,
      params[:user][:month].to_i,
      params[:user][:day].to_i)
    end

end
