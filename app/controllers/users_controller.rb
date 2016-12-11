class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, except: [:index, :show, :new, :create]

  skip_before_action :authenticate, only: [:new, :create]

  def index
    @post = current_user.posts.build
    allowed_ids = [current_user.id, *current_user.friend_ids]
    @posts = Post.includes(:comments).where(post_type: "Post", user_id: allowed_ids).order(created_at: :desc)
  end

  def new
    create_session unless session[:user_id]
    if signed_in_user?
      redirect_to users_path
    end
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(whitelisted)
    if @user.save
      sign_in(@user)
      flash[:success] = ["Successfully signed in"]
      redirect_to users_path
    else
      flash.now[:danger] = ["Something went wrong signing up"]
      @user.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
      render :new
    end
  end

  def show
    @post = current_user.posts.build
    @posts = Post.includes(:comments).where(post_type: "Post", user_id: @user.id).order(created_at: :desc)
    render :index
  end

  private

    def whitelisted
      # if params[:user][:profile_attributes]["birthday(1i)"]
      #   params[:user][:profile_attributes][:birthday] = parse_date_select
      # end
      params.require(:user).permit(
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    {
                                      profile_attributes:[
                                                          :first_name,
                                                          :last_name,
                                                          :birthday,
                                                          :gender
                                                        ]
                                    }
                                  )
    end


    def correct_user
      unless params[:id] == current_user.id.to_s
        flash[:danger] = ["You cannot mess with other users! Jerk.."]
        redirect_to user_path(current_user)
      end
    end


    def set_user
      @user = User.find(params[:id])
    end

end
