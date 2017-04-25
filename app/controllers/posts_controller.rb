class PostsController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @posts = @current_user.posts.order("created_at DESC")
    @post = current_user.posts.build if @user == current_user
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created'
      redirect_to user_timeline_path(current_user)
    else
      flash[:warning] = @post.errors.full_messages
      redirect_to user_timeline_path(current_user)
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to user_timeline_path(current_user)
    else
      flash[:warning] = @post.errors.full_messages
      redirect_to user_timeline_path(current_user)
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:content)
  end

end
