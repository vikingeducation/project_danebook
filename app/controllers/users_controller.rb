class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params_hash)

    if @user.save
      flash[:success] = "Successfully created a user"
      redirect_to new_user_path
    else
      flash[:error] = "errorrrrrr"
      render :new
    end
  end

  def show
  end

  def destroy
  end

  private

    def params_hash
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :dob, :gender)
    end
end
