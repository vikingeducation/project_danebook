class CommentsController < ApplicationController

  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user, :only => [:destroy, :edit, :update, :show ]

  def index

    @users = User.all
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
    else
      flash.now[:error] = "Please sign up or sign in"
      render :index
    end
  end

  def show
  end

  def new
    @user = current_user
    @comment = Comment.create(
      :content => params[:content],
      :post_id => session[:real_post_id].to_i,
      :user_id => @user.id
      )
    redirect_to user_profile_path(params[:user_id].to_i)
  end

  def edit
    require_current_user
    @user = current_user
  end

  def create
    @user = current_user
    if comment_it
      flash[:success] = "Successfully updated"
    else
      flash.now[:failure] = "failed to update"
      render :edit
    end    
    redirect_to user_profile_path(current_user.id)
  end

  def update
    @user = current_user
    if comment_it
      flash[:success] = "Successfully updated"
    else
      flash.now[:failure] = "failed to update"
      render :edit
    end    
    redirect_to user_profile_path(current_user.id)
  end

  def destroy
    @comment = Comment.find(params[:id].to_i)
    @comment.destroy
    redirect_to user_profile_path(current_user.id)
  end

  private

  def set_user
    @user = current_user
  end

  def comment_params
    params.
      require(:comment).
      permit(:content,
             :user_id,
             :content )
  end
end
