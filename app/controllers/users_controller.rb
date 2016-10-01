class UsersController < ApplicationController
  before_action :set_user_and_profile, only: [:about, :timeline]
  skip_before_action :require_login, only: [:new, :create, :show]

  def new
    if signed_in_user?
      redirect_to about_user_path(current_user)
    else
      @user = User.new
    end
  end

  def show

  end

  def create
    @user = User.new(user_params)
    if @user.save
      permanent_sign_in(@user)
      flash[:success] = "You've successfully signed up"
      redirect_to about_user_path(@user)
    else
      flash.now[:danger] = "Please correct errors and resubmit the form"
      render :new
    end
  end

  def about

  end

  def timeline
    @post = Post.new
  end


  private

  def set_user_and_profile
    @user =  User.find(params[:id])
    @profile = @user.profile
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation,
                                   :birthday, :gender_cd)
  end


end
