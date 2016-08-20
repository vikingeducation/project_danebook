class UsersController < ApplicationController
  before_action :set_user, :except => [:new, :create, :index, :newsfeed]
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
  if signed_in_user?
    session[:return_to] = request.referer
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Sucessfully updated your picture"
      redirect_to session[:return_to]
    else
      flash[:error] = "Failed to update picture"
      render
    end
  else
    redirect_to login_path
  end
end

def destroy
end

def newsfeed
  if signed_in_user?
    @user = current_user
    @post = Post.new
    @feeds = feed_posts(@user)
  else
    flash[:error] = "Please login to complete this operation"
    redirect_to login_path
  end
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

    def feed_posts(user)
      feed = Posting.activities(user).map do |posting|
        resource = find_instance(posting)
        [User.find(posting.user_id), resource]
      end
    end

    def find_instance(posting)
      type = posting.postable_type.classify
      type.constantize.find(posting.postable_id)
    end
end
