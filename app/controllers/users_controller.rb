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
    flash[:danger] = "Already signed in"
    redirect_to root_path
  else
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created!"
      sign_in(@user)
      redirect_to root_path
    else
      flash[:danger] = "couldn't sign you in"
      render "sessions/new"
    end
  end
end

def update
  if signed_in_user?
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Sucessfully updated your picture"
    else
      flash[:danger] = "Failed to update picture"
    end
    redirect_to :back
  else
    flash[:danger] = "Failed to update picture"
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
    flash[:danger] = "Please login to complete this operation"
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
