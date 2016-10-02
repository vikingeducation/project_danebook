class PostsController < ApplicationController

  # def new
  #   @post = Post.new
  #   render 'static_pages/timeline'
  # end

  def create
    @post = current_user.posts.build(whitelisted_post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      else
        format.html { redirect_back(fallback_location: root_url) }
      end
    end
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
    respond_to do |format|
      if current_user == @post.user
        current_user.posts.destroy(@post)
        format.js
        format.html { redirect_back(fallback_location: root_url) }
      else
        format.html { redirect_back(fallback_location: root_url) }
      end
    end
  end



  private

  def whitelisted_post_params
    params.require(:post).permit(:id, :post_text)
  end

end
