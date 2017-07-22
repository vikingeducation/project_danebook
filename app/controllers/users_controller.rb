require 'pry'

class UsersController < ApplicationController

  before_action :require_current_user, :only => [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Congratulation! You have successfully created an account!"
      redirect_to @user
    else
      flash[:danger] = "Error! We couldn't create your account!" + "#{@user.errors.full_messages}"
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
    @user = User.find(params[:id])
    @profile = @user.profile
    # binding.pry
    if @user.update(user_params)
      flash[:success] = "Congratulation! You have successfully edited your profile!"
      redirect_to @user
    else
      flash[:danger] = "Error! We couldn't edit your profile! #{@user.errors.full_messages}"
      render :edit
    end
  end

  private
  def user_params
  params.require(:user).permit( :email, :password,
                                        :password_confirmation,
                                        {:profile_attributes =>
                                            [ :user_id,
                                              :first_name,
                                              :last_name,
                                              :birth_day,
                                              :birth_month,
                                              :birth_year,
                                              :gender,
                                              :college,
                                              :hometown,
                                              :current_town,
                                              :telephone,
                                              :words_to_live,
                                              :about_me,
                                              :id,
                                              :_destroy ]})
  end


end
