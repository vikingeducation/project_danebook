class UsersController < ApplicationController
  before_action :set_user_and_profile, only: [:about, :timeline]
  skip_before_action :require_login, only: [:new, :create, :show]

  def new
    if signed_in_user?
      redirect_to about_user_path(current_user)
    else
      @user = User.new
    end
  end

  def show

  end

  def create
    @user = User.new(user_params)
    if @user.save
      permanent_sign_in(@user)
      flash[:success] = "You've successfully signed up"
      redirect_to about_user_path(@user)
    else
      flash.now[:danger] = "Please correct errors and resubmit the form"
      render :new
    end
  end

  def update
  end

  def about
    @user = User.find(params[:id])
    @friends = current_user.initiated_friends
    @pending_friends = @friends - current_user.friends
    @friendship = Friendship.new
  end

  def timeline
    @post = Post.new
    @comment = Comment.new
    @posts = Post.includes(:user, :likes, :comments => [:author, :likes]).order(created_at: :desc)
    @user = User.find(params[:id])
    @friends = @user.friends
  end

  def friends
    @user = User.includes(:initiated_friends).find(params[:id])
    @friends = @user.friends
    @pending_friends = @user.initiated_friends - @friends
  end

  def photos
    @user = User.includes(:photos).find(params[:id])
    @photos = @user.photos
  end

  def index
    @users = User.search(params[:query])
    @friends = current_user.initiated_friends
    @pending_friends = @friends - current_user.friends
    @friendship = Friendship.new
    render :search_result
  end

  private

  def set_user_and_profile
    @user =  User.includes(:profile).find(params[:id])
    @profile = @user.profile
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation,
                                   :birthday, :gender_cd, :profile_photo_id,
                                   :cover_photo_id)
  end


end
