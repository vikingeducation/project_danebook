class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      @user.build_profile.save
       #needs call back to save together.
      flash[:success] = "Thank you for signing up on Danebook!"
      sign_in(@user)
      redirect_to edit_user_profile_path(@user)
    else
      flash[:error] = "Aw, there was an error, try again!"
      render :new
    end
  end


  def index
    @user = current_user
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,
                                { :profile_attributes =>
                                [ :id, birthday, :gender] })
  end
end
