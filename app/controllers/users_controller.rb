class UsersController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]

  def about
    @user = User.find(params[:id])
  end

  def new
    if signed_in_user?
      @user = current_user
      redirect_to newsfeed_path
    else
      @user = User.new
      @user.profile = @user.build_profile
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      User.delay.send_welcome_email(@user.id)
      flash[:success] = 'Welcome to Danebook!'
      redirect_to about_user_path(@user)
    else
      flash[:warning] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    @profile = @user.profile || @user.build_profile
  end

  def update
    @user = current_user
    set_photos
    if @user.update(user_params)
      flash[:success] = "Profile updated!"
      redirect_to about_user_path(@user)
    else
      flash[:warning] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
                          :first_name,
                          :last_name,
                          :email, 
                          :birth_date,
                          :birth_month,
                          :birth_year,
                          :gender,
                          :password, 
                          :password_confirmation,
                        { :profile_attributes => [
                                                :college, 
                                                :hometown,
                                                :current_location,
                                                :telephone,
                                                :words, 
                                                :about_me,
                                                :_destroy ] } )
  end

end
