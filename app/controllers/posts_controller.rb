class PostsController < ApplicationController

  def create
    params[:post_receiver_id] = session[:receiver_id]
    params[:post_author_id] = current_user.id 
    @post = current_user.posts_written.new(post_params)
    @post.post_receiver_id = session[:receiver_id]
    session[:receiver_id] = nil
    if @post.save
      flash[:success] = "Your message has been posted!"
      redirect_back(fallback_location: root_path)
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
