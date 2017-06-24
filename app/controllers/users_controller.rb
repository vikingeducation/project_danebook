class UsersController < ApplicationController

  before_action :require_current_user, :only => [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]

  def new
    @user = User.new
    # @profile = Profile.new(:user_id => @user.id)
    @profile = @user.build_profile
  end

  def create
    profile_attr = params[:user][:profile_attributes][:birth_day]
    date = Date.new profile_attr["birth_date(1i)"].to_i, profile_attr["birth_date(2i)"].to_i, profile_attr["birth_date(3i)"].to_i
    params[:user][:profile_attributes]["birthday"] = date.strftime("%d-%m-%Y")
    @user = User.new(user_params)
    # @user.profile.birth_date = date.strftime("%d-%m-%Y")
    if @user.save
      sign_in(@user)
      flash[:success] = "Congratulation! You have successfully created an account!"
      redirect_to user_path
    else
      flash[:notice] = "Error! We couldn't create your account!" + "#{@user.errors.full_messages}"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
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
