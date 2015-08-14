class PostsController < ApplicationController

  before_action :require_current_user, :except => [:index]


  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @new_post = current_user.posts.build if signed_in_user?
    @friends = @user.friended_users.sample(6)
  end


  def create
    @new_post = current_user.posts.build(post_params)
    if @new_post.save
      flash[:success] = "New post created!"
      redirect_to [current_user, :posts]
    else
      flash.now[:danger] = "New post not saved. Please try again."
      @user = User.find(params[:user_id])
      @posts = @user.posts
      @friends = @user.friended_users.sample(6)
      render :index
    end
  end


  def destroy
    if Post.find(params[:id]).destroy!
      flash[:success] = 'Post deleted!'
    else
      flash[:danger] = "Sorry, we couldn't delete your post. Please try again."
    end
    redirect_to user_posts_path(current_user)
  end


  private


    def post_params
      params.require(:post).permit(:body)
    end


    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:danger] = "You're not authorized to do this!"
        redirect_to user_posts_path(params[:user_id])
      end
    end

end
