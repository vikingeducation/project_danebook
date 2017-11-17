class UsersController < ApplicationController
  before_action :set_user, only: [:create, :show, :edit, :update, :destroy]
  # before_action :is_authorized?, only: [:edit, :update, :destroy]

  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      permanent_sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to edit_user_path(@user)
    else
      @user.build_profile
      flash.now[:error] = "Failed to Create User!"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def edit
     @user = User.find(params[:id])
     @profile = @user.profile
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Updated user details!"
      redirect_to user_path(current_user.id)
    else
      flash.now[:error] = "Failed to update user details!"
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, 
      :profile_attributes =>
                            [:id,
                             :firstname,
                             :lastname,
                             :birthday,
                             :gender,
                             :telephone,
                             :college,
                             :hometown,
                             :currently_lives,
                             :words_to_live_by,
                             :about_me])
  end

  # def is_authorized?
  #   if current_user.id != params[:id]
  #     redirect_to root_url, :flash => { error: 'You are not authorized to do this action.' }
  #   end
  # end
end
