class PostsController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @posts =  Post.all.where("posted_id = #{params[:user_id]}").order("created_at DESC")
    @post = Post.new
  end 


  def create
    @post = Post.new(params_list)
    @post.posted_id = params[:user_id]
    @post.user_id = current_user.id
    if @post.save
      redirect_to user_posts_path(12)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Your post has been deleted!"
      redirect_to user_posts_path(current_user)
    else
      flash[:danger] = "There was an error deleting your post, try again."
      redirect_to user_posts_path(current_user)
    end
  end

  private

  def params_list
      params.require(:post).permit( :body )
  end
end
