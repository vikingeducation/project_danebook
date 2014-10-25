class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      flash.now[:error] = "Your account could not be created"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
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