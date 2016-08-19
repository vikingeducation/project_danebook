# Users Controller
class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  before_action :require_current_user, except: [:create, :new, :show, :friends, :index]

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      User.delay.send_welcome_email(@user.id)
      flash[:success] = 'Created new user!'
      redirect_to @user
    else
      flash[:error] = 'Failed to Create User!'
      redirect_to root_url
    end
  end

  def new
    redirect_to current_user if signed_in_user?
    @user = User.new
    @user.build_profile
  end

  def show
    User.includes(:posts, :profiles)
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC')
  end

  def friends
    @user = User.find(params[:user_id])
  end

  def index
    @user = current_user
    @results = User.search(params[:query])
  end

  def destroy
    if current_user.destroy
      flash[:success] = 'Goodbye!'
    else
      flash[:error] = 'Failed to Delete User!'
    end
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 profile_attributes: [:first_name,
                                                      :last_name,
                                                      :birthday,
                                                      :about])
  end

  def update_profile_params
    params.require(:user).permit(profile_attributes: [:first_name,
                                                      :last_name,
                                                      :birthday,
                                                      :about])
  end

  def require_current_user
    unless params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this"
      redirect_to root_url
    end
  end
end
