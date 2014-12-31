class UsersController < ApplicationController
  skip_before_action :require_sign_in, only: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @users = @user.friend_requests.includes(profile: :photo).paginate(:page => params[:page], :per_page => 12)
  end

  def new
    if signed_in?
      redirect_to current_user
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.build_profile.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook"
      redirect_to @user
      # Uncomment the line below to send welcome emails to users
      # User.welcome_email(@user.id)
    else
      flash.now[:error] = "Your account could not be created"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @friends = @user.friends.includes(profile: :photo)
    @posts = @user.posts.include_post_info.order(created_at: :desc)
    @post = current_user.posts.build
  end

  private

  def user_params
    params.require(:user).permit( :first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :birthday,
                                  :gender )
  end
end
