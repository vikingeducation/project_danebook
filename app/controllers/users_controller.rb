class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create, :show]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    login_redirect
    @user = User.new
  end

  def timeline
    params[:id].nil? ? @user = current_user : @user = User.find(params[:id])
    @friends = @user.friends.sample(6)
    @photos = @user.photos.sample(6)

  end

  def index
    @users = User.search(params[:query])

  end

  def friends
    params[:user_id].nil? ? @user = current_user : @user = User.find(params[:user_id])
    @friends = @user.friends

  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:notice] = "User successfully created"
      redirect_to :back
    else
      flash[:notice] = "User not created, fix your errors"
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if current_user.update(user_params)
      flash[:notice] = "User succesfully updated"
      @user = User.find(params[:id])
      redirect_to :back
    else
      flash[:notice] = "user not created, fix your errors"
      render :edit
    end
  end

  def edit
    @current_user
    @user = @current_user
    render "about_edit"
  end

  def show
    @user = User.find(params[:id])
    render "about"
  end

  def destroy
    current_user.destroy
    sign_out
    redirect_to root
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :b_day, :b_month, :b_year, :gender, :email, :password, :password_confirmation, :college, :home, :lives, :phone, :words, :bio,  :posts_attributes => [:id, :body, :author_id, :user_id ] )
  end

end
