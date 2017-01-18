class PostsController < ApplicationController

  before_action :require_login

  def new
  end

  def create
    @user = current_user
    @post = @user.posts.build(whitelisted_params)

    respond_to do |format|
      if @post.save
        flash[:success] = "Post saved"
        format.html { redirect_to :back }
        format.js { render :new_post }
      else
        flash.now[:error] = @post.errors.full_messages
        format.html { render Rails.application.routes.recognize_path(request.referer)[:action] }
        format.js {}
      end
    end

  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.reversed
    @post = @user.posts.build
    @comment = @post.comments.build
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @user = current_user
    @post = @user.posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted"
      redirect_to :back
    else

    end
  end

  private

  def whitelisted_params
    params.require(:post).permit(:content, :id)
  end

end
