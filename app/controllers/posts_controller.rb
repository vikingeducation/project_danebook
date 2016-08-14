class PostsController < ApplicationController

  def new
    @post = Post.new
    render 'static_pages/timeline'
  end

  def create
    current_user.posts.create(whitelisted_post_params)
    redirect_to timeline_path
  end

  def index
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
    @posts = @user.posts.order('created_at desc')
    @post = Post.new
    render 'static_pages/timeline'
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user = @post.user
      current_user.posts.destroy(@post)
      flash[:success] = 'Post deleted'
      redirect_to :back
    else
      flash[:error] = 'We were unable to do that.'
      redirect_to :back
    end
  end



  private

  def whitelisted_post_params
    params.require(:post).permit(:id, :post_text)
  end

end
