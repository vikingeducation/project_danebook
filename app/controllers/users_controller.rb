class UsersController < ApplicationController
  before_action :current_user, only: [:edit, :update, :destroy]
  before_action :require_new_user, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # builds a profile with the user_id when @user.save runs
    @profile = @user.build_profile

    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome #{@user.fname}!"
      redirect_to root_path
    else
      flash.now[:error] = "Your account could not be created"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit( :fname,
                                  :lname,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :birthday,
                                  :gender )
  end

end