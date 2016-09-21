class PostsController < ApplicationController

  def create
    @new_post = current_user.posts_written.new(post_params)
    @new_post.post_receiver_id = session[:receiver_id]
    if @new_post.save
      @post = current_user.posts_written.new
      @comment = current_user.comments_written.new
      respond_to :js
    else
      flash[:danger] = "Your message could not be posted :("
      redirect_back(fallback_location: root_path)
    end
  end

  def edit

  end

  def update
  
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user.id == @post.post_author_id && @post.destroy
      flash[:success] = "Your post has been deleted"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Your post could not be deleted"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_author_id, :post_receiver_id, :body)
  end

end
