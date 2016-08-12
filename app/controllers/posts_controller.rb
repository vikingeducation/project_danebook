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
      render user_timeline_path(params[:id])
    end
  end

  def edit

  end

  def update



  end

  private

  def post_params
    params.require(:post).permit(:post_author_id, :post_receiver_id, :body)
  end

end
