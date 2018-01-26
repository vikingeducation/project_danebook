class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]


  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    authorize @user
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        sign_in(@user)
        format.html { redirect_to @user, notice: "Hi #{@user.email}! Welcome to Danebook!" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @user
    respond_to do |format|
      if @current_user.update(user_params)
        format.html { redirect_to @user, notice: 'Your profile has been updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_digest, :name, :birthday, :college, :hometown, :current_town, :phone, :quote, :bio, :profile_pic_id, :cover_pic_id)
    end
end
