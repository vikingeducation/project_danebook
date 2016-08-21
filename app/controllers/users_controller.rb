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

def edit
end

def create
  if signed_in_user?
    redirect_to root_path
  else
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      flash[:error] = "couldn't sign you in"
      redirect_to login_path
    end
  end
end

def update
  if signed_in_user?
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Sucessfully updated your picture"
    else
      flash[:error] = "Failed to update picture"
    end
    redirect_to :back
  else
    redirect_to login_path
  end
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
                :birth_date,
                :profile_pic_id,
                :cover_pic_id)
    end

    def require_current_user
      unless current_user == User.find(params[:id])
        flash[:error] = "Access denied!!!"
        redirect_to root_path
      end
    end
end
