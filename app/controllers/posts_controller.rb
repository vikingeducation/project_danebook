class PostsController < ApplicationController

  def new
    @post = Post.new
    render 'static_pages/timeline'
  end

  def create
    @post = current_user.posts.build(whitelisted_post_params)
    if @post.save
      flash[:success] = 'Post created'
    end
    redirect_back(fallback_location: root_url)
  end

  def index
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
    @posts = @user.updates
    @friends = @user.friends.sample(9)
    @photos = @user.photos.sample(9)
    @post = Post.new
    render 'static_pages/timeline'
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user == @post.user  # got a bug! was assigning current_user instead of comparing
      current_user.posts.destroy(@post)
      flash[:success] = 'Post deleted'
      redirect_back(fallback_location: root_url)
    else
      flash[:error] = 'We were unable to do that.'
      redirect_back(fallback_location: root_url)
    end
  end



  private

  def whitelisted_post_params
    params.require(:post).permit(:id, :post_text)
  end

end
