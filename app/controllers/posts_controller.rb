class PostsController < ApplicationController
  before_action :require_account_owner, :except => [:index]

  def index
    page_owner
    @user = current_user
    @posts = User.find(params[:user_id]).posts.order("created_at DESC")
    @profile = @user.profile
    @post = @user.posts.build
# =>     @comment = @post.comments.build

  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @posts = @user.posts
    @post = current_user.posts.build(whitelisted_params)
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to user_timeline_path(current_user)
    else
      flash.now[:error] = @post.errors.full_messages.join(' ')
      render :index
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy 
      flash[:success] = "Your post was deleted."
    else
      flash[:error] = @post.errors.full_messages.join(', ')
    end

    redirect_to user_timeline_path(current_user)
  end



  def whitelisted_params
    params.require(:post).permit(:id, :author_id, :body) # , :comments_attributes => [:id, :body, :author_id])
  end
end
