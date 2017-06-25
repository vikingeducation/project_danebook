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
      flash[:notice] = "Error! We couldn't create your account!" + "#{@user.errors.full_messages}"
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
    current_params = params[:user][:profile_attributes]
    params[:user][:profile_attributes] = split_date_to_three_cols(current_params)
    if @user.update(user_params)
      flash[:success] = "Congratulation! You have successfully edited your profile!"
      redirect_to @user
    else
      flash[:notice] = "Error! We couldn't edit your profile!" + "#{@user.errors.full_messages}"
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

  def split_date_to_three_cols(current_params)
    date_arr = current_params[:birth_day].split('.')
    current_params[:birth_day] = date_arr[0]
    current_params[:birth_month] = date_arr[1]
    current_params[:birth_year] = date_arr[2]
    current_params
  end

end
