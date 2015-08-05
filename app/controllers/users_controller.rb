class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     sign_in(@user)
      flash[:success] = "A thing a happened"
      redirect_to edit_user_profile_path(@user)
    else
      flash[:error] = "A thing didn't happened"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
  end

  def timeline

   @user = User.find(params[:user_id])
   @posts = @user.posts.order("created_at DESC")
  end

  def about
  end



  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
