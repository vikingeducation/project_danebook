class PostsController < ApplicationController

  def create
    params[:post_receiver_id] = session[:receiver_id]
    params[:post_author_id] = current_user.id 
    @post = current_user.posts_written.new(post_params)
    @post.post_receiver_id = session[:receiver_id]
    session[:receiver_id] = nil
    if @post.save!
      flash[:success] = "Your message has been posted!"
      redirect_to :back
    else
      flash.now[:danger] = "Your message could not be posted :("
      render :back
    end
  end

  def edit

  end

  def update
    @post = Post.find(params[:id])
    @comment = Comment.new(user_id: current_user.id, body: params[:post][:comment][:body], commentable_id: @post.id, commentable_type: "Post")
    if @comment.save!
      flash[:success] = "Your comment has been posted"
      redirect_to user_timeline_path(@post.post_receiver_id)
    else
      flash[:danger] = "Your comment couldn't be posted"
      render ser_timeline_path(@post.post_receiver_id)
    end

  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Your post has been deleted"
      redirect_to :back
    else
      flash.now[:danger] = "Your post could not be deleted"
      render :back
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_author_id, :post_receiver_id, :body)
  end

end
