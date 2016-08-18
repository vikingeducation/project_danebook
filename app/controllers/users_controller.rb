class UsersController < ApplicationController
  before_action :set_user, :except => [:new, :create, :index]
  before_action :require_login, :except => [:index, :new, :create, :show]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

def index
  @users = User.all
end

def show
  @posts = @user.recent_user_posts
  @post = @user.posts.build
end

def new
  redirect_to login_path
end

def edit
end

def create
  if signed_in_user?
    redirect_to user_path current_user
  else
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to user_path @user
    else
      redirect_to login_path
    end
  end
end

def update
end

def destroy
end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.
        require(:user).
        permit( :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation,
                :birth_date)
    end

    def require_current_user
      unless current_user == User.find(params[:id])
        flash[:error] = "Access denied!!!"
        redirect_to root_path
      end
    end
end
