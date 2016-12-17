class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create]
  skip_before_action :require_login, :only => [:new, :create]

  def index
    redirect_to root_url
  end

  def new
    if signed_in_user?
      @user = current_user
      redirect_to @user
    else
      @user = User.new
      @user.profile = @user.build_profile
      render :new, layout: 'login'
    end
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      User.delay.welcome_email(@user.id)
      sign_in(@user)
      flash[:success] = "Welcome"
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(whitelisted_params)
      flash[:success] = "Profile successfully updated"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

  private

  def whitelisted_params
    params.require(:user).permit( :first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  { profile_attributes: [
                                     :id,
                                     :birth_month,
                                     :birth_day,
                                     :birth_year,
                                     :gender,
                                     :college,
                                     :hometown,
                                     :current_town,
                                     :phone,
                                     :words_to_live_by,
                                     :about_me ] }
)
  end



end
