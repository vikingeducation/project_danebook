class UsersController < ApplicationController
  before_action :set_user, :except => [:new, :create, :index, :newsfeed]
  before_action :require_login, :except => [:index, :new, :create, :show]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

def index
  @users = User.all
end

def show
  @post = @user.text_posts.build
  @feeds = user_posts(@user)
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

def newsfeed
  if signed_in_user?
    @user = current_user
    @post = @user.text_posts.build
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

    def require_current_user
      unless current_user == User.find(params[:id])
        flash[:error] = "Access denied!!!"
        redirect_to root_path
      end
    end

    def feed_posts(user)
      Posting.friend_activities(user).map do |posting|
        resource = find_instance(posting)
        [User.find(posting.user_id), resource]
      end
    end

    def user_posts(user)
      Posting.current_user_activities(user).map do |posting|
        resource = find_instance(posting)
        [User.find(posting.user_id), resource]
      end
    end

    def find_instance(posting)
      type = posting.postable_type.classify
      type.constantize.find(posting.postable_id)
    end

end
