class PostsController < ApplicationController
  def index
  end

  def new
    user = User.includes(:posts, :posts => :likes).find(current_user)
    @post = user.posts.build
  end

  def create
    @post = current_user.posts.build(white_list_params)
    if @post.save
      flash[:success] = ["Post has been created successfully"]
      redirect_to new_post_path
    else
      flash.now[:danger] = @post.errors.full_messages
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:success] = ["Post has been deleted successfully"]
    else
      flash[:danger] = ["Post can not be deleted"]
    end
    redirect_to new_post_path
  end

  def like
    post = Post.find_by_id(params[:id])
    like = current_user.likes.build(likeable: post, like: params[:like])
    if like.save
      flash[:success] = ["Like Counted!"]
    else
      flash[:danger] = ["You already liked this post"]
    end
    redirect_to :back
  end

  def unlike
    post = Post.find_by_id(params[:id])
    like = current_user.likes.find_by(likeable: post)
    if like && like.destroy
      flash[:success] = ["Unliked Mother fucker!"]
      redirect_to :back
    end
  end


  private
    def white_list_params
      params.require(:post).permit(:body)
    end
end
