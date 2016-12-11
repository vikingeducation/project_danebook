class UsersController < ApplicationController
  before_action :set_user_and_profile, only: [:about, :timeline, :newsfeed]
  before_action :set_profile_cover_photo, only: [:about, :timeline, :friends, :photos, :newsfeed]
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
    if @user.save && @user.build_profile.save
      permanent_sign_in(@user)
      User.delay.send_welcome_email(@user.id)
      flash[:success] = "You've successfully signed up"
      redirect_to newsfeed_user_path(@user)
    else
      flash.now[:danger] = "Please correct errors and resubmit the form"
      render :new
    end
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
    @posts = Post.includes(:user, :likes, :comments => [:author, :likes])
                 .where(user_id: @user.id).order(created_at: :desc)
    @user = User.find(params[:id])
    @friends = @user.friends
    @photos = @user.photos
  end

  def newsfeed
    @post = Post.new
    @comment = Comment.new
    @posts = Post.where(user_id: current_user.friends.pluck(:id))
                 .order(created_at: :desc)
    @photos = Photo.includes(:user => [:profile_photo], :comments => [:author])
                   .where(user_id: current_user.friends.pluck(:id))
                   .order(created_at: :desc)
    @articles = @posts + @photos
    @articles = @articles.sort_by(&:created_at).reverse
    @articles = @articles.paginate(:page => params[:page], :per_page => 3)


    @comments = Comment.includes(:author).where(user_id: current_user.friends.pluck(:id))
    @likes = Like.includes(:initiated_user).where(user_id: current_user.friends.pluck(:id))
    @activities = (@articles + @comments + @likes).sort_by(&:created_at).reverse.first(10)
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

  def set_profile_cover_photo
    @user =  User.includes(:profile_photo, :cover_photo).find(params[:id])
    @profile_photo = @user.profile_photo
    @cover_photo = @user.cover_photo
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :password, :password_confirmation,
                                 :birthday, :gender_cd, :profile_photo_id,
                                 :cover_photo_id)
  end
end
