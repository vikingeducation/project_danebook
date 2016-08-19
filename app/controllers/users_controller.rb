class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  before_action :set_user, except: [ :create, :new ]
  before_action :require_current_user, except: [ :show, :about, :create, :new ]

  def show
    @posts = @user.posts.order(created_at: :desc).includes(:likes, :comments)
    @post = current_user.posts.build if @user == current_user
    @comment = current_user.comments.build
    @friendship = Friendship.new

    build_friend_box
  end

  def new
    @user = User.new
    redirect_to user_path(current_user) if signed_in_user?
  end

  def create
    if signed_in_user?
      redirect_to timeline_path
    else
      @user = User.new(user_params)
      if @user.save
        sign_in(@user)
        # flash[:success] = "Created new user!"
        redirect_to user_path(@user)
      else
        flash[:danger] = "Please fill out all fields!"
        redirect_to root_path
      end
    end
  end

  def edit
    current_user.build_hometown unless current_user.hometown
    current_user.build_residency unless current_user.residency
  end

  def update
    if current_user.update(user_params)
      # flash[:success] = "Successfully updated your profile"
      redirect_to about_user_path(current_user)
    else
      flash.now[:danger] = "Failed to update your profile"
      render :edit
    end
  end

  def about

  end

  private

  def user_params
    params.
      require(:user).
      permit( :first_name,
              :last_name,
              :email,
              :password,
              :password_confirmation,
              :birth_date,
              :gender,
              :telephone,
              :quote,
              :about,
              :college,
              hometown_attributes: [ :id, :name, :country ],
              residency_attributes: [ :id, :name, :country ]
              )
  end

  def set_user
    begin
     @user = User.find(params[:id])
   rescue
      render :file => "public/404.html",  :status => 404
    end
  end

  def build_friend_box
    friends = @user.sample_friends(9)

    @left_col, @center_col, @right_col = [], [], []
    friends.each_index do |index|
      case index % 3
      when 0
        @left_col << friends[index]
      when 1
        @center_col << friends[index]
      else
        @right_col << friends[index]
      end
    end

    friends
  end

end
