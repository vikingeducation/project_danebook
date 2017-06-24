class UsersController < ApplicationController

  before_action :require_current_user, :only => [:edit, :update, :destroy]
  skip_before_action :require_login, :only => [:new, :create]

  def new
    @user = User.new
    @profile = @user.profile.build
  end

  def create  
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Congratulation! You have successfully created an account!"
      redirect_to root_url
    else
      flash[:notice] = "Error! We couldn't create your account!"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private
  def user_params
  params.require(:user).permit( :email, :password, 
                                        :password_confirmation,
                                        :profile_attributes =>
                                            [ :user_id,
                                              :first_name, 
                                              :last_name, 
                                              :birth_date, 
                                              :gender,
                                              :college,
                                              :hometown,
                                              :current_town,
                                              :telephone,
                                              :words_to_live,
                                              :about_me,
                                              :id,
                                              :_destroy ])
  end

end
